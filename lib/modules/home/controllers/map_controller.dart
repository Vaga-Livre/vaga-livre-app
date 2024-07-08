import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MyMapController extends ChangeNotifier {
  double userLatitude = 0.0;
  double userLongitude = 0.0;
  String erro = '';
  final AnimatedMapController animatedMapsController;

  MyMapController({required this.animatedMapsController});

  // void getPosition() async {
  //   try {
  //     Position position = await _getCurrentUserPosition();

  //     userLatitude = position.latitude;
  //     userLongitude = position.longitude;

  //     focusOn(LatLng(userLatitude, userLongitude));
  //   } catch (e) {
  //     erro = e.toString();
  //   }

  //   notifyListeners();
  // }

  void focusOn(LatLng local) {
    animatedMapsController.animateTo(
      dest: local,
    );
  }

  void focusOnAll(List<LatLng> locals) {
    if (locals.isEmpty) return;
    animatedMapsController.animatedFitCamera(
      cameraFit: CameraFit.coordinates(
        coordinates: locals,
        padding: const EdgeInsets.all(64).copyWith(top: 16),
      ),
      rotation: 0,
    );
  }

  Future<Position> _getCurrentUserPosition() async {
    LocationPermission permission;

    bool ativado = await Geolocator.isLocationServiceEnabled();

    if (!ativado) {
      return Future.error('Habilite a localização do seu celular');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Autorize o acesso a localização');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Autorize o acesso a localização nas configurações');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void dispose() {
    animatedMapsController.dispose();
    super.dispose();
  }
}
