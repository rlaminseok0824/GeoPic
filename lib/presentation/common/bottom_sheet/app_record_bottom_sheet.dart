import 'package:flutter/material.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';

class AppRecordBottomSheet extends StatelessWidget {
  const AppRecordBottomSheet._({
    Key? key,
    required this.height,
    required this.body,
  }) : super(key: key);

  final double height;
  final Widget body;
  static Future<void> show({
    required BuildContext context,
    required double height,
    required Widget body,
  }) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.0),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (context) => AppRecordBottomSheet._(height: height, body: body),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 8),
          _buildBar(),
          const SizedBox(height: 32),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: body,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildBar() {
    return Container(
      width: 62,
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
