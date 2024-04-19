import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/extension.dart';
import '../../parks/controllers/parks_search_controller.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final _searchController = context.watch<ParksSearchController>();

    if (_searchController.results?.isNotEmpty == true) {
      final results = _searchController.results!;
      final plural = results.length > 1;

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
                  "${results.length} ${plural ? "estacionamentos" : "estacionamento"} perto",
                  style: context.textTheme.titleLarge,
                ),
              ),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: results
                      .map(
                        (e) => Card(
                          margin: const EdgeInsets.only(right: 10),
                          elevation: 2,
                          child: SizedBox(
                            height: 100,
                            width: 200,
                            child: Center(
                              child: Text(e.label),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              TextButton(
                onPressed: () {},
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
