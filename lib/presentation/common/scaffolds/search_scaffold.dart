import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/presentation/map/view/map_search_bar.dart';

class SearchScaffold extends StatelessWidget {
  final Widget body;
  final double appBarHeight;

  const SearchScaffold({
    super.key,
    required this.body,
    required this.appBarHeight,
  });

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
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          height: appBarHeight,
          color: AppColors.background,
          child: MapSearchBar(height: appBarHeight)),
    );
  }
}
