import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../utils/debouncer.dart';
import '../../../utils/typedefs.dart';
import '../../home/controller/map_controller.dart';

class SearchResult {
  final String label;
  final String address;
  final String description;
  final LatLng location;
  final int slotsCount;
  final double price;

  const SearchResult({
    required this.label,
    required this.address,
    required this.description,
    required this.location,
    required this.slotsCount,
    required this.price,
  });
}

class ParksSearchController extends ChangeNotifier {
  final MapController mapController;

  Debouncer debouncer = Debouncer(delay: const Duration(seconds: 1));

  bool isSearching = false;
  List<SearchResult> searchSuggestions = [];
  List<SearchResult>? results = [];

  final FocusNode searchInputFocusNode;
  final TextEditingController queryTextController;

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
    results = null;
    searchSuggestions = [];

    searchInputFocusNode.unfocus();

    notifyListeners();
  }

  void searchCurrentQuery() async {
    searchRecommendations();

    await Future.delayed(debouncer.delay + Durations.short4);

    results = searchSuggestions;
    isSearching = false;

    notifyListeners();
  }

  void searchRecommendations() {
    if (!isSearching) {
      isSearching = true;

      notifyListeners();
    }

    if (queryTextController.text.isNotEmpty) {
      debouncer.run(() async {
        final supaClient = Supabase.instance.client;

        final terms = queryTextController.text.splitMapJoin(
          RegExp(r"[ ,\.]"),
          onMatch: (match) => " | ",
          onNonMatch: (match) => "$match:*",
        );

        final supaFuture = supaClient.from("park").select().textSearch("name", terms);
        final List<JsonType> resultsData = await supaFuture;

        final data = resultsData.map((e) => SearchResult(
              label: e["name"],
              address: e["address_line"],
              description: e["description"],
              location: LatLng(double.parse(e["latitude"]), double.parse(e["longitude"])),
              slotsCount: 0,
              price: (e["hourly_rate"] as num).toDouble(),
            ));

        searchSuggestions = data.toList();

        notifyListeners();
      });
    }
  }

  selectTerm(SearchResult term) {
    results = [term];
    searchInputFocusNode.unfocus();
    queryTextController.text = term.label;
    isSearching = false;

    // mapController.focusOn(results)

    notifyListeners();
  }

  void _cleanSearchText() {
    queryTextController.text = "";
    searchSuggestions = [];
  }
}
