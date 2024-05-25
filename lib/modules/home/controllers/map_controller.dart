import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MyMapController extends ChangeNotifier {
  double userLatitude = 0.0;
  double userLongitude = 0.0;
  String erro = '';
  MapController mapsController = MapController();

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
    mapsController.move(local, mapsController.camera.zoom);
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
}
