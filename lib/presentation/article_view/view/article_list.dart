import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/presentation/article_view/bloc/article_view_cubit.dart';
import 'package:fullstack_fe/presentation/article_view/view/article_screen.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Stack(children: [
        BlocBuilder<ArticleViewCubit, ArticleViewState>(
            builder: (context, state) {
          return Swiper(
            itemBuilder: (context, index) {
              return ArticleScreen(
                record: state.listArticles[index],
              );
            },
            itemCount: state.listArticles.length,
            scrollDirection: Axis.vertical,
          );
        }),
      ]),
    );
  }
}
