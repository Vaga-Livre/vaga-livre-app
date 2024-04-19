import 'package:flutter/material.dart';

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
      bottomNavigationBar: NavigationBar(
        elevation: 0,
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
            icon: Icon(Icons.settings),
            label: "Opções",
          ),
        ],
      ),
    );
  }
}
