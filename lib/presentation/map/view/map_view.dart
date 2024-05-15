import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:fullstack_fe/core/common/location.dart';
import 'package:geolocator/geolocator.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final NaverMapController _controller;
  late Position _position;

  final marker = NMarker(id: "test", position: NLatLng(37.5666, 126.979));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Stack(children: [
        NaverMap(
          options: const NaverMapViewOptions(),
          onMapReady: (controller) {
            _controller = controller;
          },
        ),
      ]),
    );
  }
}
