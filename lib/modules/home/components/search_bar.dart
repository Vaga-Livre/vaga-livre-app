import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../parks/controllers/ParksSearchController.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({super.key});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final _searchController = context.watch<ParksSearchController>();

    final isSearching = _searchController.isSearching;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          AppBar(
            elevation: isSearching ? 4 : 1,
            centerTitle: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(28),
                bottom: isSearching && _searchController.searchSuggestions.isNotEmpty
                    ? Radius.zero
                    : const Radius.circular(28),
              ),
            ),
            leading: isSearching || _searchController.results != null
                ? IconButton(
                    icon: const Icon(Icons.arrow_back), onPressed: _searchController.exitSearch)
                : null,
            title: TextField(
              controller: _searchController.queryTextController,
              focusNode: _searchController.searchInputFocusNode,
              onSubmitted: (value) => _searchController.searchCurrentQuery(),
              decoration: const InputDecoration.collapsed(
                hintText: "Pesquisar locais e endereços",
                fillColor: Colors.amber,
              ),
            ),
            actions: [
              IconButton(
                icon: isSearching ? const Icon(Icons.close) : const Icon(Icons.search),
                onPressed: _searchController.startSearching,
              ),
              const SizedBox.square(dimension: 8),
            ],
          ),
          if (isSearching)
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                decoration: ShapeDecoration(
                  color: ElevationOverlay.colorWithOverlay(
                      colorScheme.surface, colorScheme.surfaceTint, 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.zero,
                      bottom: Radius.circular(12),
                    ),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: ListBody(
                  children: List.generate(
                    max(0, _searchController.searchSuggestions.length * 2 - 1),
                    (i) {
                      if (i.isEven) {
                        final term = _searchController.searchSuggestions[i ~/ 2];
                        return ListTile(
                          title: Text(term.label),
                          onTap: () => _searchController.selectTerm(term),
                          dense: true,
                        );
                      } else {
                        return const Divider(height: 0);
                      }
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
