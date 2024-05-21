import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/formatters.dart';
import '../../../utils/initial_letters.dart';
import '../../parks/controllers/parks_search_controller.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = BlocProvider.of<ParksSearchController>(context, listen: false);

    return BlocBuilder<ParksSearchController, ParkSearchState>(
        bloc: searchController,
        builder: (context, state) {
          final bool validState = state is ParksNearbyDestinationResults;
          final parks = validState ? state.parksNearby : <SearchResult>[];

          return Scaffold(
            appBar: AppBar(
              title: Text(validState ? state.query : "Resultados da pesquisa"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    context.pop();
                    searchController.startSearching();
                  },
                )
              ],
            ),
            body: !validState
                ? const Center(child: Text("Resultados de pequisa indisponíveis"))
                : parks.isEmpty
                    ? const Center(child: Text("Nenhum resultado encontrado"))
                    : ListView.separated(
                        separatorBuilder: (context, index) => const Divider(height: 0),
                        itemCount: parks.length,
                        itemBuilder: (context, index) {
                          final SearchResult item = parks[index];

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
        });
  }
}
