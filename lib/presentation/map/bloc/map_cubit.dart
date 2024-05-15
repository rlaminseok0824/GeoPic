import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:fullstack_fe/core/common/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'map_state.dart';
part 'map_cubit.freezed.dart';

@lazySingleton
class MapCubit extends Cubit<MapState> {
  late final NaverMapController _controller;
  late Position _position;
  late final NLocationOverlay _locationOverlay;
  MapCubit() : super(const MapState());

  void initMap(NaverMapController controller) async {
    _controller = controller;
    _position = await initializePosition();
    _locationOverlay = _controller.getLocationOverlay();
    // _locationOverlay
    //     .setIcon(const NOverlayImage.fromAssetImage('assets/position.png'));
    _locationOverlay.setIconSize(const Size(100, 100));
    _controller.setLocationTrackingMode(NLocationTrackingMode.noFollow);
    emit(MapState.initial(
        controller: _controller,
        position: _position,
        locationOverlay: _locationOverlay));
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
}
