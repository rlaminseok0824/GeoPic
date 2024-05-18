import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/routers/app_routes.dart';
import 'package:fullstack_fe/presentation/home/bloc/home_bottom_navigation_bar_cubit.dart';
import 'package:fullstack_fe/presentation/home/view/home_bottom_navigation_bar.dart';

class HomePageView extends StatefulWidget {
  final List<HomeBottomNavigationBarItem> bottomNavigationBarItems;
  const HomePageView({
    super.key,
    required this.bottomNavigationBarItems,
  });

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _bottomNavigationListener(
    HomeBottomNavigationBarState bottomNavigationState,
  ) {
    pageController.jumpToPage(bottomNavigationState.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBottomNavigationBarCubit,
        HomeBottomNavigationBarState>(
      listener: (context, bottomNavigationState) {
        if (bottomNavigationState.currentIndex == 1) {
          const ArticleRecordRoute().push(context);
        } else {
          _bottomNavigationListener(bottomNavigationState);
        }
      },
      child: _buildPageView(),
    );
  }

  Widget _buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: widget.bottomNavigationBarItems
          .map(
            (item) => item.page,
          )
          .toList(),
    );
  }
}
