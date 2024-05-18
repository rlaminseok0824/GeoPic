import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'article_record.freezed.dart';
// part 'article_record.g.dart';

@freezed
class ArticleRecord with _$ArticleRecord {
  factory ArticleRecord({
    String? id,
    String? username,
    String? title,
    String? content,
    XFile? pictureFile,
    String? imageUrl,
    double? latitude,
    double? longitude,
    @Default([]) List<String> tags,
    String? location,
    required DateTime date,
  }) = _ArticleRecord;

  ArticleRecord._();

  factory ArticleRecord.mock(DateTime? date) => ArticleRecord(
        username: 'username',
        title: 'title',
        content: 'content',
        imageUrl: 'https://picsum.photos/200/300',
        latitude: 37.5665,
        longitude: 126.978,
        tags: ['tag1', 'tag2'],
        location: 'Seoul',
        date: date ?? DateTime.now(),
      );

  bool get isUnfinished =>
      (username == null || username!.isEmpty) ||
      (title == null || title!.isEmpty) ||
      (latitude == null || longitude == null) ||
      (longitude == null || longitude == null);

  // factory ArticleRecord.fromJson(Map<String, dynamic> json) =>
  //     _$ArticleRecordFromJson(json);
}
