import 'package:flutter/material.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';

class BackwardScaffold extends StatelessWidget {
  final Widget body;
  final double appBarHeight;
  const BackwardScaffold(
      {super.key, required this.body, required this.appBarHeight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(children: [
          _buildBody(context),
          _buildAppBar(context),
        ]));
  }

  Widget _buildBody(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      margin: EdgeInsets.only(top: topPadding + appBarHeight),
      child: body,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          height: appBarHeight,
          color: AppColors.background,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          )),
    );
  }
}
