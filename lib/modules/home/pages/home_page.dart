import 'package:flutter/material.dart';

import '../components/bottom_sheet/app_bottom_sheet.dart';
import '../components/map/map_widget.dart';
import '../components/search_bar.dart';
import '../components/search_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      body: const SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            MapWidget(),
            SizedBox(width: 640, child: AppHeaderArea()),
            SizedBox(width: 640, child: AppSearchBar()),
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
    );
  }
}
