import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/debouncer.dart';

class SearchResult {
  final LatLng location;
  final String label;

  SearchResult(
    this.label,
    this.location,
  );
}

class ParksSearchController extends ChangeNotifier {
  Debouncer debouncer = Debouncer(delay: const Duration(seconds: 1));

  bool isSearching = false;
  List<SearchResult> searchSuggestions = [];
  List<SearchResult>? results = [];

  final FocusNode searchInputFocusNode;
  final TextEditingController queryTextController;

  ParksSearchController({required this.searchInputFocusNode, required this.queryTextController}) {
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
    print("Submmited");
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

    if (queryTextController.text.isNotEmpty)
      debouncer.run(() {
        // TODO: Do the request here
        searchSuggestions = [
          SearchResult("Ideal", const LatLng(-5.160009, -42.785307)),
          SearchResult("Sacolão", const LatLng(-5.160096, -42.787671)),
          SearchResult("Junekinho Produções", const LatLng(-5.16278689, -42.78500430)),
        ];

        notifyListeners();
      });
  }

  selectTerm(SearchResult term) {
    results = [term];
    searchInputFocusNode.unfocus();
    queryTextController.text = term.label;
    isSearching = false;

    notifyListeners();
  }

  void _cleanSearchText() {
    queryTextController.text = "";
    searchSuggestions = [];
  }
}
