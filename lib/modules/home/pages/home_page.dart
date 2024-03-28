import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vagalivre/config/extension.dart';
import 'package:vagalivre/utils/debouncer.dart';

import '../components/map_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Debouncer debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  bool isSearching = false;
  List<String> searchSuggestions = [];

  late final FocusNode searchInputFocusNode;
  late final TextEditingController searchController;

  String? selectedTerm;

  @override
  void initState() {
    super.initState();

    searchInputFocusNode = FocusNode();
    searchController = TextEditingController(text: "");
    searchController.addListener(() => search(searchController.text));
  }

  void startSearch() {
    cleanSearchText();
    searchInputFocusNode.requestFocus();
  }

  void cleanSearchText() {
    setState(() {
      searchController.text = "";
      searchSuggestions = [];
    });
  }

  void exitSearch() {
    setState(() {
      cleanSearchText();
      isSearching = false;
    });
  }

  void search(String term) {
    if (!isSearching) {
      setState(() {
        isSearching = true;
      });
    }

    debouncer.run(() {
      if (mounted) {
        setState(() {
          searchSuggestions =
              term.characters.map((e) => e.toUpperCase()).toList();
        });
      }
    });
  }

  selectTerm(String term) {
    selectedTerm = term;
    exitSearch();
  }

  @override
  void dispose() {
    searchInputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            MapWidget(),
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              padding:
                  const EdgeInsets.all(16) + const EdgeInsets.only(top: 56),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Horário",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SegmentedButton(
                        style: SegmentedButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                        ),
                        onSelectionChanged: (p0) {},
                        segments: const [
                          ButtonSegment(
                            value: TimeOfDay(hour: 10, minute: 0),
                            label: Text(
                              "10:00",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          ButtonSegment(
                            value: TimeOfDay(hour: 10, minute: 0),
                            label: Text(
                              "12:00",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        selected: {},
                        emptySelectionAllowed: true,
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Tipo",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      FilterChip(
                        label: const Text(
                          "Carro",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        avatar: const Icon(Icons.directions_car),
                        deleteIcon: const Icon(Icons.arrow_drop_down),
                        onDeleted: () {},
                        onSelected: (value) {},
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  AppBar(
                    elevation: isSearching ? 4 : 1,
                    centerTitle: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: const Radius.circular(28),
                        bottom: isSearching && searchSuggestions.isNotEmpty
                            ? Radius.zero
                            : const Radius.circular(28),
                      ),
                    ),
                    leading: isSearching
                        ? IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: exitSearch)
                        : null,
                    title: TextField(
                      controller: searchController,
                      focusNode: searchInputFocusNode,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Pesquisa",
                        fillColor: Colors.amber,
                      ),
                    ),
                    actions: [
                      isSearching
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                cleanSearchText();
                                searchInputFocusNode.requestFocus();
                              },
                            )
                          : IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: startSearch,
                            ),
                      const SizedBox.square(dimension: 8),
                    ],
                  ),
                  if (isSearching)
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.5,
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Container(
                          decoration: ShapeDecoration(
                            color: ElevationOverlay.colorWithOverlay(
                                colorScheme.surface,
                                colorScheme.surfaceTint,
                                2),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.zero,
                                bottom: Radius.circular(12),
                              ),
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ListBody(
                            children: List.generate(
                              max(0, searchSuggestions.length * 2 - 1),
                              (i) {
                                if (i.isEven) {
                                  final term = searchSuggestions[i ~/ 2];
                                  return ListTile(
                                    title: Text(term),
                                    onTap: () => selectTerm(term),
                                    dense: true,
                                  );
                                } else {
                                  return const Divider(height: 0);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
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
