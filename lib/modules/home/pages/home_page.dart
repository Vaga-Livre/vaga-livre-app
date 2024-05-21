import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/extension.dart';
import '../components/app_bottom_sheet.dart';
import '../components/map_widget.dart';
import '../components/search_bar.dart';
import '../components/search_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        builder: (context) => AppBottomSheet(),
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
    );
  }
}
