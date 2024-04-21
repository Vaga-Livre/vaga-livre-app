import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vagalivre/utils/formatters.dart';

import '../../../utils/initial_letters.dart';
import '../../parks/controllers/parks_search_controller.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage(this.controller, {super.key});

  final ParksSearchController controller;

  static Widget builder(BuildContext context) {
    final controller = context.read<ParksSearchController>();

    return SearchResultsPage(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.queryTextController.text),
        actions: [
          IconButton(
            onPressed: () {
              context.pop();
              controller.startSearching();
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: controller.results == null
          ? const Center(
              child: Text("Nenhum resultado disponível"),
            )
          : ListView.separated(
              separatorBuilder: (context, index) => const Divider(height: 0),
              itemCount: controller.results!.length,
              itemBuilder: (context, index) {
                final item = controller.results![index];

                return ListTile(
                  title: Text(item.label),
                  subtitle: Text(item.label),
                  isThreeLine: false,
                  leading: CircleAvatar(
                    child: Text(initialLetters(item.label)),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("R\$ ${currencyFormatter.format(item.price)}/hora"),
                      const Icon(Icons.arrow_right),
                    ],
                  ),
                  onTap: () => context.push("/park/${item.label}"),
                );
              },
            ),
    );
  }
}
