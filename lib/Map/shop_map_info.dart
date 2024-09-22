import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopMapInfoPage extends StatefulWidget {
  const ShopMapInfoPage({super.key});

  @override
  State<ShopMapInfoPage> createState() => _ShopMapInfoPageState();
}

class _ShopMapInfoPageState extends State<ShopMapInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop location"),
      ),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(82.75, 82.54),
          zoom: 15,
        ),
      ),
    );
  }
}
