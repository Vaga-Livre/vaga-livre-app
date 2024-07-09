import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/extension.dart';
import '../components/app_bottom_sheet.dart';
import '../components/map/map_widget.dart';
import '../components/search_bar.dart';
import '../components/search_header.dart';
import '../controllers/map_controller.dart';
import '../controllers/parks_search_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimatedMapController mapsController;

  @override
  void initState() {
    super.initState();

    mapsController = AnimatedMapController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyMapController(animatedMapsController: mapsController),
      child: ChangeNotifierProxyProvider<MyMapController, ParksSearchController>(
        create: (context) => ParksSearchController(
          queryTextController: TextEditingController(text: ""),
          searchInputFocusNode: FocusNode(),
          mapController: context.read<MyMapController>(),
        ),
        update: (context, value, previous) {
          if (previous?.mapController == value) return previous!;

          log("CREATING NEW PARKS SEARCH CONTROLLER");

          return ParksSearchController(
            queryTextController: TextEditingController(text: ""),
            searchInputFocusNode: FocusNode(),
            mapController: value,
          );
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                MapWidget(),
                const AppHeaderArea(),
                const AppSearchBar(),
              ],
            ),
          ),
          bottomSheet: BottomSheet(
            elevation: 0,
            onClosing: () {},
            enableDrag: false,
            clipBehavior: Clip.antiAlias,
            builder: (context) => const AppBottomSheet(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go("/reservas");
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: NavigationBar(
            elevation: 0,
            onDestinationSelected: (value) async {
              switch (value) {
                case 2:
                  showAdaptiveDialog(
                    context: context,
                    builder: (context) => AlertDialog.adaptive(
                      title: const Text("Deseja Sair?"),
                      content: const Text("Tem certeza que deseja sair?"),
                      actions: [
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const Text('cancelar'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(foregroundColor: context.colorScheme.error),
                          onPressed: () => context.go("/login"),
                          child: const Text('Sair mesmo assim'),
                        ),
                      ],
                    ),
                  );
                  break;
                default:
                  break;
              }
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.directions_car),
                label: "Explorar",
              ),
              NavigationDestination(
                icon: Icon(Icons.access_time),
                label: "Reservas",
              ),
              NavigationDestination(
                icon: Icon(Icons.logout),
                label: "Sair",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
