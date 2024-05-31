import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/routers/app_routes.dart';
import 'package:fullstack_fe/presentation/home/bloc/home_bottom_navigation_bar_cubit.dart';
import 'package:fullstack_fe/presentation/home/view/home_bottom_navigation_bar.dart';
import 'package:fullstack_fe/presentation/map/view/article_record_bottom_sheet.dart';
import 'package:go_router/go_router.dart';

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
        if (bottomNavigationState.currentIndex == 2) {
          _buildDialog(context).then((value) {
            pageController.jumpToPage(0);
          });
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

  Future<void> _buildDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text('실시간 영상 스트리밍',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        context.pop();
                        const LiveStreamRecordRoute().push(context);
                      },
                    ),
                    const Divider(),
                    TextButton(
                      child: const Text('사진 및 영상 업로드',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        context.pop();
                        const ArticleRecordRoute().push(context).then(
                          (value) {
                            print(value);
                            ArticleRecordBottomSheet.show(
                                context: context, record: value);
                          },
                        );
                      },
                    ),
                  ],
                )),
          ));
        });
  }
}
