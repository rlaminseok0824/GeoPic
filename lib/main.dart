import 'package:flutter/material.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/core/services/err_tracking_service.dart';
import 'package:fullstack_fe/presentation/app.dart';
import 'package:injectable/injectable.dart';

void main() {
  ErrTrackingService.init(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await configureDependencies(Environment.prod);
    runApp(const MyApp());
  });
}
