import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/presentation/article_view/view/article_view_page.dart';
import 'package:fullstack_fe/presentation/home/bloc/home_bottom_navigation_bar_cubit.dart';
import 'package:fullstack_fe/presentation/home/view/home_bottom_navigation_bar.dart';
import 'package:fullstack_fe/presentation/home/view/home_page_view.dart';
import 'package:fullstack_fe/presentation/map/view/map_page.dart';
import 'package:fullstack_fe/presentation/profile/view/profile_record_page.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage._();

  static Widget builder(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => getIt<HomeBottomNavigationBarCubit>())
    ], child: const HomePage._());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bottomNavigationBarItems = [
    HomeBottomNavigationBarItem(
      page: const MapPage(),
      iconBuilder: (isSelected) => Icon(
        Icons.home,
        size: 40,
        color: isSelected ? Colors.white : AppColors.greyPrimary,
      ),
      label: 'home',
    ),
    HomeBottomNavigationBarItem(
        page: const ArticleViewPage(lat: 0, lng: 0),
        iconBuilder: (isSelected) => Icon(Icons.filter_sharp,
            size: 40, color: isSelected ? Colors.white : AppColors.greyPrimary),
        label: 'view'),
    HomeBottomNavigationBarItem(
      page: Container(),
      iconBuilder: (isSelected) => Icon(
        Icons.add_circle_outline_outlined,
        size: 40,
        color: isSelected ? Colors.white : AppColors.greyPrimary,
      ),
      label: 'add',
    ),
    HomeBottomNavigationBarItem(
      page: const ProfileRecordPage(),
      iconBuilder: (isSelected) => Icon(
        Icons.person_rounded,
        size: 40,
        color: isSelected ? Colors.white : AppColors.greyPrimary,
      ),
      label: 'mypage',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageView(
        bottomNavigationBarItems: bottomNavigationBarItems,
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        bottomNavigationBarItems: bottomNavigationBarItems,
      ),
    );
  }
}
