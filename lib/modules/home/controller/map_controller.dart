import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String erro = '';
  late GoogleMapController _mapsController;

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    getPosicao();
  }

  getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
      _mapsController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    } catch (e) {
      erro = e.toString();
    }

    notifyListeners();
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permission;

    bool ativado = await Geolocator.isLocationServiceEnabled();

    if (!ativado) {
      return Future.error('Habilite a localizacao do seu celular');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Autorize o acesso a localizacao');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Autorize o acesso a localizacao nas configuracoes');
    }

    return await Geolocator.getCurrentPosition();
  }
}
