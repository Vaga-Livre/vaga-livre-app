import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../controllers/parks_search_controller.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({super.key});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final searchController = context.watch<ParksSearchController>();
    final isSearching = searchController.isSearching;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ParksSearchController, ParkSearchState>(
          bloc: searchController,
          builder: (context, state) {
            final showLeadingIcon =
                isSearching || (state is! MapViewParksResults && state is! LoadingResults);
            final hasSuggestions = isSearching &&
                (state is DestinationsSearchResults &&
                    (state.destinations.isNotEmpty || state.suggestedParks.isNotEmpty));
            final suggestions = [
              if (hasSuggestions) ...[...state.suggestedParks, ...state.destinations],
            ];

            return Column(
              children: [
                AppBar(
                  centerTitle: false,
                  elevation: isSearching ? 4 : 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: const Radius.circular(28),
                      bottom: hasSuggestions ? Radius.zero : const Radius.circular(28),
                    ),
                  ),
                  leading: showLeadingIcon
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: searchController.exitSearch,
                        )
                      : null,
                  title: TextField(
                    controller: searchController.queryTextController,
                    focusNode: searchController.searchInputFocusNode,
                    onSubmitted: (value) => searchController.searchCurrentQuery(),
                    decoration: const InputDecoration.collapsed(
                      hintText: "Pesquisar locais e endereços",
                      fillColor: Colors.amber,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: isSearching ? const Icon(Icons.close) : const Icon(Icons.search),
                      onPressed: searchController.startSearching,
                    ),
                    const SizedBox.square(dimension: 8),
                  ],
                ),
                if (hasSuggestions)
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
                          suggestions.length * 2 - 1,
                          (i) {
                            if (i.isEven) {
                              final suggestion = suggestions[i ~/ 2];
                              return ListTile(
                                dense: true,
                                // TODO :use switch to ensure exaustive checking
                                title: Text(suggestion.label),
                                onTap: () => suggestion is ParkResult
                                    ? context.push("/park", extra: suggestion)
                                    : searchController.searchParksCloseTo(suggestion),
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
            );
          }),
    );
  }
}
