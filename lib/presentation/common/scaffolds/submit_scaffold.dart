import 'package:flutter/material.dart';
import 'package:fullstack_fe/presentation/common/buttons/app_elevated_button.dart';
import 'package:fullstack_fe/presentation/common/scaffolds/backward_scaffold.dart';

class SubmitScaffold extends StatelessWidget {
  final Widget body;
  final double appBarHeight;
  final void Function() onSubmit;
  final bool canSubmit;
  final bool isSubmitting;

  const SubmitScaffold(
      {super.key,
      required this.body,
      required this.appBarHeight,
      required this.onSubmit,
      required this.canSubmit,
      required this.isSubmitting});

  @override
  Widget build(BuildContext context) {
    return BackwardScaffold(
        body: Column(
          children: [
            body,
            _buildSubmitButton(context),
          ],
        ),
        appBarHeight: appBarHeight);
  }

  Widget _buildSubmitButton(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom + 24;
    return ClipRect(
        child: Container(
            padding: EdgeInsets.only(
                bottom: bottomPadding, left: 24, right: 24, top: 24),
            child: AppElevatedButton(
              text: '제출',
              onPressed: onSubmit,
              isDisabled: !canSubmit,
              isLoading: isSubmitting,
            )));
  }
}
