import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:fullstack_fe/core/common/location.dart';
import 'package:fullstack_fe/core/resources/app_assets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'map_state.dart';
part 'map_cubit.freezed.dart';

@lazySingleton
class MapCubit extends Cubit<MapState> {
  bool isMapReady = false;
  late final NaverMapController _controller;
  late Position _position;
  late final NLocationOverlay _locationOverlay;
  MapCubit() : super(const MapState());

  void initMap(NaverMapController controller) async {
    if (!isMapReady) {
      _controller = controller;
      _position = await initializePosition();
      _controller.setLocationTrackingMode(NLocationTrackingMode.noFollow);
      _locationOverlay = _controller.getLocationOverlay();
      _locationOverlay.setIconSize(const Size(20, 20));
      isMapReady = true;
    }

    _controller.updateCamera(
      NCameraUpdate.withParams(
          target: NLatLng(_position.latitude, _position.longitude), zoom: 15.0),
    );
  }

  void setPosition(Position position) {
    _position = position;
  }

  void updateCamera() {
    _controller.updateCamera(
      NCameraUpdate.withParams(
          target: NLatLng(_position.latitude, _position.longitude)),
    );
  }

  void addMarker(NLatLng latLng, {String type = 'tap'}) {
    const icon = NOverlayImage.fromAssetImage(AppAssets.markerIcon);

    final marker = NMarker(
        id: type, position: latLng, icon: icon, size: const Size(30, 30));
    _controller.addOverlay(marker);

    _controller.updateCamera(
      NCameraUpdate.withParams(
          target: NLatLng(latLng.latitude, latLng.longitude)),
    );
  }
}
