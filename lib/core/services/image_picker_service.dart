import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ImagePickerService {
  final ImagePicker _imagePicker;
  ImagePickerService(this._imagePicker);

  Future<XFile?> pickFromAlbum() async {
    final file = await _imagePicker.pickImage(source: ImageSource.gallery);
    return file;
  }
}
