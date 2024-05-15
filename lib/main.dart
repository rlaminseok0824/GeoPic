import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/core/services/err_tracking_service.dart';
import 'package:fullstack_fe/presentation/app.dart';
import 'package:injectable/injectable.dart';

void main() {
  ErrTrackingService.init(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    await configureDependencies(Environment.prod);
    await NaverMapSdk.instance.initialize(
        clientId: dotenv.env['NAVER_CLIENT_ID'],
        onAuthFailed: (ex) {
          print('********* 네이버맵 인증오류 : $ex *********');
        });
    runApp(const MyApp());
  });
}
