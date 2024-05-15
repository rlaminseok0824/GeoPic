import 'package:flutter/material.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';

class CurrentPositionButton extends StatelessWidget {
  const CurrentPositionButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.secondaryPoint),
        child: ConstrainedBox(
            constraints: const BoxConstraints.expand(height: 40, width: 40),
            child: SizedBox(
              height: 40,
              width: 40,
              child: IconButton(
                icon:
                    const Icon(Icons.my_location, color: AppColors.background),
                onPressed: onPressed,
              ),
            )));
  }
}
