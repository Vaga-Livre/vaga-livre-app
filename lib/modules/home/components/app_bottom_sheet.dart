import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../config/extension.dart';
import '../../../utils/formatters.dart';
import '../../../utils/initial_letters.dart';
import '../controllers/parks_search_controller.dart';

class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet({super.key});

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final double resultCardDesiredWidth = 400;
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
              child: Padding(
                padding: bottomSheetPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        "${results.length} ${pluralResults ? "estacionamentos" : "estacionamento"} perto de ${destinationName}",
                        style: context.textTheme.titleLarge,
                      ),
                    ),
                    SingleChildScrollView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      child: IntrinsicHeight(
                        child: Row(
                          children: results.map(
                            (park) {
                              final pluralSlots = park.slotsCount != 1;

                              return Card(
                                elevation: 2,
                                surfaceTintColor: Colors.transparent,
                                color: context.colorScheme.onPrimary,
                                margin: const EdgeInsets.only(right: 10),
                                clipBehavior: Clip.hardEdge,
                                child: InkWell(
                                  onTap: () => context.read<ParksSearchController>().selectPark(park),
                                  child: Container(
                                    width: cardWidth,
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          minVerticalPadding: 0,
                                          contentPadding: const EdgeInsets.all(0),
                                          leading: CircleAvatar(child: Text(initialLetters(park.label))),
                                          titleTextStyle: context.textTheme.titleMedium,
                                          title: Text(
                                            park.label,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(left: 2.0, top: 2),
                                                child: Icon(Icons.pentagon, size: 14),
                                              ),
                                              const SizedBox.square(dimension: 4),
                                              Expanded(
                                                child: Text(
                                                  park.address,
                                                  style: context.textTheme.bodySmall,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox.square(dimension: 6),
                                        Text("R\$ ${currencyFormatter.format(park.price)}/hora"),
                                        Text(
                                          "${park.slotsCount} "
                                          "${pluralSlots ? "espaços" : "espaço"} "
                                          "${pluralSlots ? "disponíveis" : "disponível"}",
                                        ),
                                        const Divider(height: 8),
                                        Text(
                                          park.description,
                                          maxLines: 3,
                                          overflow: TextOverflow.fade,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go("/search-results");
                      },
                      child: const Center(child: Text("Ver lista completa")),
                    )
                  ],
                ),
              ),
            ),
          );
        });

    // return BottomSheet(
    //   onClosing: () {},
    //   elevation: 0,
    //   backgroundColor: context.colorScheme.onPrimary,
    //   shape: Border(
    //     top: BorderSide(
    //       color: context.colorScheme.outlineVariant,
    //       strokeAlign: BorderSide.strokeAlignInside,
    //     ),
    //   ),
    //   builder: (context) {

    //   },
    // );
  }
}
