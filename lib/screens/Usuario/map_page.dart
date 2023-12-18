import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = new Location();

  LatLng? _currentPosition = null;

  static const LatLng _pRestaurante = LatLng(11.0191, -74.8681);
  static const LatLng _pUsuario = LatLng(11.0201, -74.8511);

  @override
  void initState() {
    super.initState();
    getLocationUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return _currentPosition == null
        ? const Center(
            child: Text("Loading..."),
          )
        : Scaffold(
            appBar: AppBar(title: const Text("Mapa")),
            body: GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _pRestaurante, zoom: 13),
                markers: {
                  Marker(
                      markerId: const MarkerId("_currentLocation"),
                      infoWindow: const InfoWindow(title: "Repartidor"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: _currentPosition!),
                  const Marker(
                      markerId: MarkerId("_sourceLocation"),
                      infoWindow: InfoWindow(title: "Casa"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: _pRestaurante),
                  const Marker(
                      markerId: MarkerId("_destinationLocation"),
                      infoWindow: InfoWindow(title: "Restaurante"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: _pUsuario)
                }),
          );
  }

  Future<void> getLocationUpdate() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }
    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        if (mounted) {
          setState(() {
            _currentPosition =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _locationController.changeSettings(interval: 1000);
    _locationController.onLocationChanged.listen(null)?.cancel();
    super.dispose();
  }
}
