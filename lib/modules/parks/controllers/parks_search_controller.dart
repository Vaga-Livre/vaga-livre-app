import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/debouncer.dart';

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
      debouncer.run(() {
        // TODO: Do the request here
        searchSuggestions = const [
          SearchResult(
            label: "Ideal",
            location: LatLng(-5.160009, -42.785307),
            address: "Rua Pedro Valentin, 2057",
            slotsCount: 3,
            price: 12,
            description:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer quis neque imperdiet libero interdum hendrerit. Suspendisse venenatis pretium est, id pretium turpis varius in. Duis ut dolor lobortis, mollis eros at, hendrerit nibh. In quis posuere augue, et luctus arcu. Donec vulputate, elit sit amet molestie facilisis, odio massa porttitor eros, ut varius felis sapien vitae ex. Nam pharetra at lectus vel molestie. Nunc id elementum tellus, quis malesuada sapien. Ut fringilla venenatis sollicitudin."
                "\nNulla lectus orci, ultricies vitae turpis in, volutpat mollis purus. Quisque nec odio auctor, porta mi at, scelerisque erat. Vivamus hendrerit enim accumsan, convallis ipsum eu, placerat leo. Pellentesque tempus nunc in neque cursus, vel dignissim massa dapibus. Maecenas auctor tellus sit amet accumsan elementum. Morbi dapibus, ligula id vulputate consequat, diam ipsum congue leo, laoreet iaculis ipsum dolor in tellus. Pellentesque ac eros vel erat pharetra porttitor. Praesent tincidunt elementum sapien, vel sollicitudin nisl porta et. Morbi mattis sem ac ultricies varius. Etiam a nisl mi. Fusce molestie, ligula ac sagittis accumsan, dui nunc sagittis erat, nec mollis nulla nisi sit amet ex. Nunc elementum erat ac risus consequat, ut sollicitudin ipsum hendrerit. Phasellus fermentum sollicitudin nunc. Aliquam bibendum nec mauris ut tempor. Suspendisse potenti.",
          ),
          SearchResult(
            label: "Sacolão",
            location: LatLng(-5.160096, -42.787671),
            address: "Rua Pedro Valentin, 2057",
            slotsCount: 3,
            price: 6,
            description: "Curabitur et ligula in augue dignissim ultrices.",
          ),
          SearchResult(
            label: "Junekinho Produções",
            location: LatLng(-5.16278689, -42.78500430),
            address: "Rua Pedro Valentin, 2057",
            slotsCount: 3,
            price: 18,
            description:
                "Maecenas placerat nec leo sed tincidunt. Aenean at turpis tortor. Sed laoreet nibh interdum tellus porttitor sodales. Sed ultrices massa ut volutpat ullamcorper. Etiam venenatis magna vehicula urna mollis, quis facilisis urna porta. In mollis eleifend ligula, vel aliquam turpis. Aenean neque eros, scelerisque vel dui id, suscipit varius urna.",
          ),
        ];

        notifyListeners();
      });
    }
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
