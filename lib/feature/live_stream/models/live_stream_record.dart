import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_stream_record.freezed.dart';
part 'live_stream_record.g.dart';

@freezed
class LiveStreamRecord with _$LiveStreamRecord {
  factory LiveStreamRecord({
    String? id,
    String? username,
    String? videoId,
    String? title,
    String? content,
    double? latitude,
    double? longitude,
    @Default([]) List<String> tags,
    String? location,
    required DateTime date,
  }) = _LiveStreamRecord;

  LiveStreamRecord._();

  factory LiveStreamRecord.mock(DateTime? date) => LiveStreamRecord(
        username: 'username',
        title: 'title',
        content: 'content',
        latitude: 37.5665,
        longitude: 126.978,
        tags: ['tag1', 'tag2'],
        location: 'Seoul',
        date: date ?? DateTime.now(),
      );

  bool get isUnfinished =>
      (videoId == null || videoId!.isEmpty) ||
      (title == null || title!.isEmpty) ||
      (latitude == null || longitude == null) ||
      (longitude == null || longitude == null);

  factory LiveStreamRecord.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamRecordFromJson(json);
}
