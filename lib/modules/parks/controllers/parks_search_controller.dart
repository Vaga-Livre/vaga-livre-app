import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../utils/debouncer.dart';
import '../../../utils/cached_http_client.dart';
import '../../../utils/object_box.dart';
import '../../../utils/typedefs.dart';
import '../../home/controller/map_controller.dart';

class AddressSearchResult {
  final String label;
  final String address;
  final LatLng location;

  const AddressSearchResult({required this.label, required this.address, required this.location});
}

class SearchResult extends AddressSearchResult {
  final String description;
  final int slotsCount;
  final double price;

  const SearchResult({
    required super.label,
    required super.address,
    required super.location,
    required this.description,
    required this.slotsCount,
    required this.price,
  });
}

class ParksSearchController extends ChangeNotifier {
  final MapController mapController;

  Debouncer debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  bool isSearching = false;
  bool isLoadingSearch = false;
  List<AddressSearchResult> searchSuggestions = [];
  List<AddressSearchResult> addressesResults = [];
  List<SearchResult>? resultsParks = [];
  SearchResult? selectedPark;

  final FocusNode searchInputFocusNode;
  final TextEditingController queryTextController;

  final _httpClient = CachedHttpClient(Client(), ObjectBox.store);
  final _supabaseClient = Supabase.instance.client;

  ParksSearchController(
      {required this.searchInputFocusNode,
      required this.queryTextController,
      required this.mapController}) {
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
    resultsParks = null;
    searchSuggestions = [];

    searchInputFocusNode.unfocus();

    notifyListeners();
  }

  Future<void> searchCurrentQuery() async {
    if (debouncer.isRunning) await debouncer.future;

    addressesResults = searchSuggestions.whereType<AddressSearchResult>().toList();
    resultsParks = searchSuggestions.whereType<SearchResult>().toList();
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

    await debouncer.run(() async {
      final query = queryTextController.text.trim();
      final terms = _toSearchTsQuery(query);

      searchParks() async {
        final List<JsonType> resultsData =
            await _supabaseClient.from("park").select().textSearch("name", terms);

        final data = resultsData.map((e) => SearchResult(
              label: e["name"],
              address: e["address_line"],
              description: e["description"],
              location: LatLng(double.parse(e["latitude"]), double.parse(e["longitude"])),
              slotsCount: 0,
              price: (e["hourly_rate"] as num).toDouble(),
            ));

        return data.toList();
      }

      searchAddresses() async {
        // final uri = Uri.https(
        //   'nominatim.openstreetmap.org',
        //   '/search.php',
        //   {
        //     'countrycodes': 'br',
        //     'format': 'jsonv2',
        //     'limit': '20',
        //     'q': query,
        //   },
        // );
        final uri = Uri.https(
          'places.googleapis.com',
          '/v1/places:searchText',
          {'key': FlutterConfig.get('GOOGLE_MAPS_SEARCH_API_KEY')},
        );

        final response = await _httpClient.post(
          uri,
          body: {'textQuery': query, 'languageCode': 'pt'},
          headers: {
            'Content-Type': 'application/json',
            'X-Goog-Api-Key': FlutterConfig.get('GOOGLE_MAPS_SEARCH_API_KEY'),
            'X-Goog-FieldMask': 'places.displayName,places.formattedAddress,places.location'
          },
        );

        final addressesData = json.decode(response.body);

        if (response.statusCode == 200) {
          final List list = addressesData["places"];
          return list
              .map((map) => AddressSearchResult(
                    label: map['displayName']['text'],
                    address: map["formattedAddress"],
                    location: LatLng(
                      map["location"]["latitude"],
                      map["location"]["longitude"],
                    ),
                  ))
              .toList();
        } else {
          throw Exception(
              "Ocorreu um erro ao buscar endereços: ${addressesData["error"]["message"]}");
        }
      }

      // nome pra listar os endereços: Destinos

      final [parks, addresses] = await Future.wait<List<AddressSearchResult>>([
        searchParks(),
        searchAddresses(),
      ]);

      searchSuggestions = [...parks, ...addresses];

      notifyListeners();
    });
  }

  _toSearchTsQuery(String query) => query.splitMapJoin(
        RegExp(r"[ ,\.]"),
        onMatch: (match) => " | ",
        onNonMatch: (match) => "$match:*",
      );

  // selectTerm(SearchResult term) {
  //   results = [term];
  //   searchInputFocusNode.unfocus();
  //   queryTextController.text = term.label;
  //   isSearching = false;

  //   // mapController.focusOn(results)

  //   notifyListeners();
  // }

  void _cleanSearchText() {
    queryTextController.text = "";
    searchSuggestions = [];
  }

  @override
  void dispose() {
    debouncer.dispose();
    super.dispose();
  }
}
