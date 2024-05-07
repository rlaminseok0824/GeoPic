import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/presentation/home/bloc/home_bottom_navigation_bar_cubit.dart';

class HomeBottomNavigationBarItem {
  final Widget page;
  final Widget Function(bool isSelected) iconBuilder;
  final String label;
  HomeBottomNavigationBarItem({
    required this.page,
    required this.iconBuilder,
    required this.label,
  });
}

class HomeBottomNavigationBar extends StatelessWidget {
  final List<HomeBottomNavigationBarItem> bottomNavigationBarItems;

  const HomeBottomNavigationBar({
    super.key,
    required this.bottomNavigationBarItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: AppColors.background),
        child: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var i = 0; i < bottomNavigationBarItems.length; i++)
                      _buildBottomNavigationBarItem(context, i),
                  ],
                ))));
  }

  Widget _buildBottomNavigationBarItem(BuildContext context, int index) {
    return Builder(builder: (context) {
      final item = bottomNavigationBarItems[index];
      final isSelected =
          (context.watch<HomeBottomNavigationBarCubit>().state.currentIndex ==
              index);
      return GestureDetector(
        onTap: () => context.read<HomeBottomNavigationBarCubit>().moveTo(index),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 65, maxWidth: 65),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.background,
              borderRadius: BorderRadius.circular(15),
              boxShadow: isSelected
                  ? const [
                      BoxShadow(
                        color: AppColors.greyPrimary,
                        blurRadius: 10,
                        spreadRadius: 1,
                      )
                    ]
                  : [],
            ),
            child: item.iconBuilder(isSelected),
          ),
        ),
      );
    });
  }
}
