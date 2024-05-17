import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier {
  double userLatitude = 0.0;
  double userLongitude = 0.0;
  String erro = '';
  late GoogleMapController mapsController;

  onMapCreated(GoogleMapController gmc) async {
    mapsController = gmc;
    getPosition();
    print("created");
  }

  void getPosition() async {
    try {
      Position position = await _getCurrentUserPosition();

      userLatitude = position.latitude;
      userLongitude = position.longitude;

      focusOn(LatLng(userLatitude, userLongitude));
    } catch (e) {
      erro = e.toString();
    }

    notifyListeners();
  }

  void focusOn(LatLng local) {
    mapsController.animateCamera(CameraUpdate.newLatLng(local));
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
