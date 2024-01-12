import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AboutUsPage extends StatelessWidget {
  AboutUsPage({super.key});
  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        //zoom sur la position de l'utilisateur sur la carte
        onPressed: () {
          mapController.move(mapController.camera.center, 18.0);
        },
        child: const Icon(Icons.gps_fixed),
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(47.2060287,-1.5393726),
          initialZoom: 13.0
        ),
        mapController: mapController,
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          const MarkerLayer(markers: [
            Marker(
              child: Icon(Icons.location_on),
              point: LatLng(47.2060287,-1.5393726),
            )
          ])
        ],
      )
    );
  }
}
