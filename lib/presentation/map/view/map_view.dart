import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:fullstack_fe/core/common/location.dart';
import 'package:fullstack_fe/presentation/map/view/current_position_button.dart';
import 'package:geolocator/geolocator.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final NaverMapController _controller;
  late Position _position;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    _position = await initializePosition();
  }

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
        Positioned(
          bottom: 20,
          right: 20,
          child: CurrentPositionButton(
            onPressed: () async {
              _position = await initializePosition();
              _controller.updateCamera(
                NCameraUpdate.withParams(
                    target: NLatLng(_position.latitude, _position.longitude)),
              );

              setState(() {});
            },
          ),
        )
      ]),
    );
  }
}
