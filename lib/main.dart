import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'modules/home/controllers/map_controller.dart';
import 'modules/home/controllers/parks_search_controller.dart';
import 'routes/router.dart';
import 'theme.dart';
import 'utils/enviroment.dart';
import 'utils/object_box.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Environment.initialize();
  await initializeDateFormatting('pt_BR', null);

  await Supabase.initialize(
    url: Environment.get('PUBLIC_SUPABASE_URL'),
    anonKey: Environment.get('PUBLIC_SUPABASE_ANON_KEY'),
  );

  await ObjectBox.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late final AnimatedMapController mapsController;

  @override
  void initState() {
    super.initState();

    mapsController = AnimatedMapController(vsync: this, duration: Durations.extralong2);
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
        child: MaterialApp.router(
          routerConfig: router,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: MaterialTheme(ThemeData.light().textTheme).light(),
        ),
      ),
    );
  }
}
