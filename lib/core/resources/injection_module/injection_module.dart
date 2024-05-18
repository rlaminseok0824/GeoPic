import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Logger get loggerDev => Logger(level: Level.debug);

  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();

  @lazySingleton
  GlobalKey<NavigatorState> get navigationKey => GlobalKey<NavigatorState>();
}
