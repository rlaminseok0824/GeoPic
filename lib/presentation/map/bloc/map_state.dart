part of 'map_cubit.dart';

@freezed
class MapState with _$MapState {
  const factory MapState() = _MapState;

  const factory MapState.initial({
    required NaverMapController controller,
    required Position position,
    required NLocationOverlay locationOverlay,
  }) = _Initial;
}
