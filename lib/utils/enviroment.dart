import 'dart:io' if (kIsWeb) 'package:flutter/foundation.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Environment {
  static Environment? _instance;
  static Environment get instance {
    assert(_instance == null || _instance?._initialized == true,
        "You must initialize the Environment instance before calling any Environment methods");
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      // web or desktop
      _instance ??= _FlutterDotEnvEnvironment();
    } else {
      // Android or iOS
      _instance ??= _FlutterConfigEnvironment();
    }

    return _instance!;
  }

  static Future<void> initialize() async {
    await instance._initialize();
    _instance!._initialized = true;
  }

  static String get(String key) => instance._getValue(key);

  // abstract methods
  bool get _initialized;
  set _initialized(bool value);
  Future<void> _initialize();
  String _getValue(String key);
}

class _FlutterConfigEnvironment implements Environment {
  @override
  bool _initialized = false;

  @override
  Future<void> _initialize() => FlutterConfig.loadEnvVariables();

  @override
  String _getValue(String key) => FlutterConfig.get(key).toString();
}

class _FlutterDotEnvEnvironment implements Environment {
  @override
  bool _initialized = false;

  @override
  Future<void> _initialize() => dotenv.load();

  @override
  String _getValue(String key) => dotenv.get(key);
}
