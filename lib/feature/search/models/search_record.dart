import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fullstack_fe/feature/search/models/location_info.dart';

part 'search_record.freezed.dart';

@freezed
class SearchRecord with _$SearchRecord {
  factory SearchRecord({
    String? text,
    @Default([]) List<LocationInfo> locations,
    required DateTime date,
  }) = _SearchRecord;

  SearchRecord._();

  bool get isUnfinished => (text == null || text!.isEmpty);
}
