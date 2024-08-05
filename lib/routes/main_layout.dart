import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/extension.dart';
import '../modules/home/pages/home_page.dart';
import '../modules/reservation/pages/reservation_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({this.initialTabIndex, super.key});

  final int? initialTabIndex;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _navigationIndex;

  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    _navigationIndex = widget.initialTabIndex ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setupPage();
    });
  }

  @override
  void didUpdateWidget(covariant MainLayout oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialTabIndex != widget.initialTabIndex) {
      setupPage();
    }
  }

  void setupPage() {
    setState(() {
      _navigationIndex = widget.initialTabIndex ?? 0;
      if (_navigationIndex != pageController.page) {
        pageController.jumpToPage(_navigationIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationIndex,
        onTap: (value) async => onBottomNavigationTap(value, context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: "Explorar"),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: "Reservas"),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Sair"),
        ],
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          ReservationPage(),
        ],
      ),
    );
  }

  void onBottomNavigationTap(int value, BuildContext context) {
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
        setState(() {
          _navigationIndex = value;
          pageController.jumpToPage(value);
        });
        break;
    }
  }
}
