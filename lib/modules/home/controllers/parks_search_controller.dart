import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../utils/cached_http_client.dart';
import '../../../utils/debouncer.dart';
import '../../../utils/object_box.dart';
import '../../../utils/typedefs.dart';
import 'map_controller.dart';

class DestinationResult {
  final String label;
  final String address;
  final LatLng location;

  const DestinationResult({required this.label, required this.address, required this.location});
}

class ParkResult extends DestinationResult {
  final String description;
  final int slotsCount;
  final double price;

  const ParkResult({
    required super.label,
    required super.address,
    required super.location,
    required this.description,
    required this.slotsCount,
    required this.price,
  });
}

class ParksSearchController extends Cubit<ParkSearchState> with ChangeNotifier {
  final MyMapController mapController;

  Debouncer debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  // Search Bar ->
  bool isSearching = false;
  final FocusNode searchInputFocusNode;
  final TextEditingController queryTextController;
  // <- Search Bar

  final _httpClient = CachedHttpClient(Client(), ObjectBox.store);
  final _supabaseClient = Supabase.instance.client;

  ParksSearchController({
    required this.searchInputFocusNode,
    required this.queryTextController,
    required this.mapController,
  }) : super(MapViewParksResults(parksNearby: [])) {
    queryTextController.addListener(() => searchRecommendations());
  }

  void startSearching() {
    _cleanSearchText();
    isSearching = true;
    searchInputFocusNode.requestFocus();

    notifyListeners();
  }

  void exitSearch() {
    _cleanSearchText();
    isSearching = false;

    searchInputFocusNode.unfocus();

    notifyListeners();
    emit(MapViewParksResults(parksNearby: []));
  }

  Future<void> searchCurrentQuery() async {
    if (debouncer.isRunning) await debouncer.future;
    isSearching = false;
    notifyListeners();
  }

  Future<void> searchRecommendations() async {
    if (!isSearching) {
      isSearching = true;

      notifyListeners();
    }

    if (queryTextController.text.isEmpty) {
      return;
    }

    final originalState = state;

    await debouncer.run(() async {
      final query = queryTextController.text.trim();
      final terms = _toSearchTsQuery(query);

      searchParks() async {
        final List<JsonType> resultsData =
            await _supabaseClient.from("park").select().textSearch("name", terms);

        final data = resultsData.map((e) => ParkResult(
              label: e["name"],
              address: e["address_line"],
              description: (e["description"] as String).replaceAll("\\n", '\n'),
              location: LatLng(double.parse(e["latitude"]), double.parse(e["longitude"])),
              slotsCount: 0,
              price: (e["hourly_rate"] as num).toDouble(),
            ));

        return data.toList();
      }

      searchAddresses() async {
        final uri = Uri.https(
          'nominatim.openstreetmap.org',
          '/search.php',
          {
            'countrycodes': 'br',
            'format': 'jsonv2',
            'limit': '20',
            'q': query,
          },
        );
        // final uri = Uri.https(
        //   'places.googleapis.com',
        //   '/v1/places:searchText',
        //   {'key': Environment.get('GOOGLE_MAPS_SEARCH_API_KEY')},
        // );

        final response = await _httpClient.get(
          uri,
          // body: {'textQuery': query, 'languageCode': 'pt'},
          // headers: {
          //   'Content-Type': 'application/json',
          //   'X-Goog-Api-Key': Environment.get('GOOGLE_MAPS_SEARCH_API_KEY'),
          //   'X-Goog-FieldMask': 'places.displayName,places.formattedAddress,places.location'
          // },
        );

        final addressesData = json.decode(response.body);

        if (response.statusCode == 200) {
          final list = (addressesData as List).cast<JsonType>();
          return list
              .map((map) => DestinationResult(
                    label: map["name"],
                    address: map["display_name"],
                    location: LatLng(
                      double.parse(map["lat"]),
                      double.parse(map["lon"]),
                    ),
                  ))
              .toList();
        } else {
          throw Exception(
              "Ocorreu um erro ao buscar endereços: ${addressesData["error"]["message"]}");
        }
      }

      // nome pra listar os endereços: Destinos

      final [parks, addresses] = await Future.wait<List<DestinationResult>>([
        searchParks(),
        searchAddresses(),
      ]).catchError(
        (error, stackTrace) {
          log("Error on search recommendation", error: error, stackTrace: stackTrace);
          return [];
        },
      );

      if (state == originalState) {
        emit(DestinationsSearchResults(
          suggestedParks: parks.cast(),
          destinations: addresses,
        ));
      }
    });
  }

  _toSearchTsQuery(String query) => query.splitMapJoin(
        RegExp(r"[ ,\.]"),
        onMatch: (match) => " | ",
        onNonMatch: (match) => "$match:*",
      );

  void searchParksCloseTo(DestinationResult destination) async {
    final List<JsonType> resultsData = await _supabaseClient.rpc(
      'parks_nearby',
      params: {
        "lat": destination.location.latitude,
        "lon": destination.location.longitude,
      },
    );

    final parks = resultsData
        .map((e) => ParkResult(
              label: e["name"],
              address: e["address_line"],
              description: e["description"],
              location: LatLng(double.parse(e["latitude"]), double.parse(e["longitude"])),
              slotsCount: 0,
              price: (e["hourly_rate"] as num).toDouble(),
            ))
        .toList();

    // Set destination as query Text
    queryTextController.text = destination.label;
    searchInputFocusNode.unfocus();
    mapController
        .focusOnAll(List.of(<DestinationResult>[destination, ...parks].map((e) => e.location)));
    emit(ParksNearbyDestinationResults(
      query: destination.label,
      destination: destination,
      parksNearby: parks,
      selectedPark: null,
    ));

    notifyListeners();
  }

  selectPark(ParkResult park) {
    if (state is! ParksNearbyDestinationResults) return;
    final originalState = state as ParksNearbyDestinationResults;

    emit(ParksNearbyDestinationResults(
      query: originalState.query,
      destination: originalState.destination,
      parksNearby: originalState.parksNearby,
      selectedPark: park,
    ));

    searchInputFocusNode.unfocus();
    mapController.focusOn(park.location);

    notifyListeners();
  }

  void _cleanSearchText() {
    queryTextController.text = "";
  }

  @override
  void dispose() {
    debouncer.dispose();
    super.dispose();
  }
}

sealed class ParkSearchState {
  const ParkSearchState();
}

/// Parks nearby a destination
class ParksNearbyDestinationResults extends ParkSearchState {
  final String query;
  final DestinationResult destination;
  final List<ParkResult> parksNearby;
  final ParkResult? selectedPark;

  ParksNearbyDestinationResults({
    required this.query,
    required this.destination,
    required this.parksNearby,
    required this.selectedPark,
  });
}

/// This can be shown as search suggestions and in the map
class DestinationsSearchResults extends ParkSearchState {
  // Suggestions only. Should not be displayed in the map
  final List<ParkResult> suggestedParks;
  final List<DestinationResult> destinations;

  DestinationsSearchResults({required this.suggestedParks, required this.destinations});
}

/// Map without any search should show the available parks in the map view
class MapViewParksResults extends ParkSearchState {
  final List<ParkResult> parksNearby;

  MapViewParksResults({required this.parksNearby});
}

class LoadingResults extends ParkSearchState {}
