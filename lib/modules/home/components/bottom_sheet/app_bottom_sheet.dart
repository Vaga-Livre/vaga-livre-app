import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagalivre/modules/home/components/bottom_sheet/park_result_card.dart';

import '../../../../config/extension.dart';
import '../../../../utils/formatters.dart';
import '../../../../utils/initial_letters.dart';
import '../../controllers/parks_search_controller.dart';

class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet({super.key});

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeData;
    final textTheme = theme.textTheme;

    const double resultCardDesiredWidth = 400;
    final size = MediaQuery.sizeOf(context);
    final bottomSheetPadding = const EdgeInsets.all(16).copyWith(bottom: 0);

    final cardWidth = min(
      resultCardDesiredWidth,
      size.width - bottomSheetPadding.horizontal - 2,
    );

    return BlocConsumer<ParksSearchController, ParkSearchState>(
      listener: (context, state) {
        final hasSearchResults = state is ParksNearbyDestinationResults;
        setState(() {
          _isOpen = hasSearchResults;
        });
      },
      buildWhen: (previous, current) => current is ParksNearbyDestinationResults,
      builder: (context, state) {
        final hasSearchResults = state is ParksNearbyDestinationResults;

        final results = hasSearchResults ? state.parksNearby : [];
        final destinationName = hasSearchResults ? state.destination.label : "";
        final pluralResults = results.length > 1;
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _isOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          secondChild: const SizedBox(width: double.maxFinite, height: 0),
          firstChild: SizedBox(
            width: double.maxFinite,
            child: Container(
              padding: bottomSheetPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "${results.length} ${pluralResults ? "estacionamentos" : "estacionamento"}"
                      " perto de $destinationName",
                      style: textTheme.titleLarge,
                    ),
                  ),
                  SingleChildScrollView(
                    clipBehavior: Clip.antiAlias,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(4),
                    child: IntrinsicHeight(
                      child: Row(
                        children: List.of(
                          Iterabled.separatedBy(
                            separator: () => const SizedBox.square(dimension: 8),
                            results.map(
                              (park) => ParkResultCard(
                                park: park,
                                width: cardWidth,
                                textTheme: textTheme,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextButton(
                      onPressed: () => context.push("/search-results"),
                      child: const Center(child: Text("Ver lista completa")),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
