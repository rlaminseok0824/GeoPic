import 'package:flutter/material.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isDisabled;
  final bool isLoading;
  final double width;

  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isDisabled,
    required this.isLoading,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: isDisabled
            ? null
            : isLoading
                ? () {}
                : onPressed,
        child: Container(
            key: key,
            width: width,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: isDisabled ? AppColors.secondary : AppColors.primary,
                borderRadius: BorderRadius.circular(8),
                border: isDisabled
                    ? Border.all(color: AppColors.greyPrimary)
                    : null),
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(text,
                    style: TextStyle(
                      color: isDisabled ? Colors.black : Colors.white,
                      fontWeight:
                          isDisabled ? FontWeight.w700 : FontWeight.w800,
                    ))));
  }
}
