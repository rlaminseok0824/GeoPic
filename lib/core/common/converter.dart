import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

class XFileConverter implements JsonConverter<XFile?, String?> {
  const XFileConverter();

  @override
  String? toJson(XFile? value) {
    return null;
  }

  @override
  XFile? fromJson(String? json) {
    return null;
  }
}

class XFileListConverter implements JsonConverter<List<XFile>, String?> {
  const XFileListConverter();

  @override
  String? toJson(List<XFile> value) {
    return null;
  }

  @override
  List<XFile> fromJson(String? json) {
    return [];
  }
}
