import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../config/extension.dart';
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
                Expanded(
                  child: SingleChildScrollView(
                    // physics: const ClampingScrollPhysics(),
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
                        children: <Widget>[
                          if (state.suggestedParks.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Text("Estacionamentos", style: context.textTheme.titleMedium),
                            ),
                          ...state.suggestedParks.map(
                            (suggestion) {
                              return ListTile(
                                // dense: true,
                                leading: CircleAvatar(
                                  backgroundColor: colorScheme.surfaceContainerHighest,
                                  foregroundColor: colorScheme.onSurfaceVariant,
                                  child: const Text(
                                    "E",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                title: Text(suggestion.label),
                                subtitle: Text(
                                  suggestion.address,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: const Icon(Icons.arrow_forward),
                                onTap: () {
                                  context.push("/park", extra: suggestion);
                                },
                              );
                            },
                          ),
                          const Divider(height: 0),
                          if (state.destinations.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Text("Destinos", style: context.textTheme.titleMedium),
                            ),
                          ...state.destinations.map(
                            (DestinationResult suggestion) {
                              return ListTile(
                                // dense: true,
                                leading: CircleAvatar(
                                  backgroundColor: colorScheme.surfaceContainerHighest,
                                  foregroundColor: colorScheme.onSurfaceVariant,
                                  child: const Icon(Icons.location_on),
                                ),
                                title: Text(suggestion.label),
                                subtitle: Text(
                                  suggestion.address,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: const Icon(Icons.search),

                                onTap: () {
                                  searchController.searchParksCloseTo(suggestion);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
