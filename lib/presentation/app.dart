import 'package:flutter/material.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _buildTheme(),
      debugShowCheckedModeBanner: false, //debug banner 안 보이게끔
      home: Container(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary, background: AppColors.background),
      scaffoldBackgroundColor: AppColors.background,
    );
  }
}
