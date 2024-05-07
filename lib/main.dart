import 'package:flutter/material.dart';
import 'package:fullstack_fe/core/services/err_tracking_service.dart';
import 'package:fullstack_fe/presentation/app.dart';

void main() {
  ErrTrackingService.init(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());
  });
}
