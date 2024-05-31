import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_info.freezed.dart';
part 'location_info.g.dart';

@freezed
class LocationInfo with _$LocationInfo {
  factory LocationInfo({
    String? place,
    required double latitude,
    required double longitude,
  }) = _LocationInfo;

  LocationInfo._();

  factory LocationInfo.fromJson(Map<String, dynamic> json) =>
      _$LocationInfoFromJson(json);
}
