import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/extension.dart';
import '../../../utils/formatters.dart';
import '../../../utils/initial_letters.dart';
import '../../parks/controllers/parks_search_controller.dart';
import '../controller/map_controller.dart';

class AppBottomSheet extends StatelessWidget {
  AppBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final _searchController = context.watch<ParksSearchController>();

    if (_searchController.results?.isNotEmpty == true) {
      final results = _searchController.results!;
      final pluralResults = results.length > 1;

      return SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(16).copyWith(bottom: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "${results.length} ${pluralResults ? "estacionamentos" : "estacionamento"} perto",
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
                          child: InkWell(
                            onTap: () {
                              context.read<MapController>().focusOn(park.location);
                            },
                            child: Container(
                              width: 350,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        child: Text(
                                          initialLetters(park.label),
                                        ),
                                      ),
                                      const SizedBox.square(dimension: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            park.label,
                                            style: context.textTheme.titleMedium,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.pentagon, size: 14),
                                              const SizedBox.square(dimension: 4),
                                              Text(park.address,
                                                  style: context.textTheme.bodySmall),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
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
      );
    } else {
      return const SizedBox(width: 0, height: 0);
    }

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
