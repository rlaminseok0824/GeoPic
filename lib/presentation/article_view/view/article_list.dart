import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/feature/article/models/article_record.dart';
import 'package:fullstack_fe/feature/live_stream/models/live_stream_record.dart';
import 'package:fullstack_fe/presentation/article_view/bloc/article_view_cubit.dart';
import 'package:fullstack_fe/presentation/article_view/view/article_screen.dart';
import 'package:fullstack_fe/presentation/article_view/view/livestream_screen.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(24),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Stack(
          children: [
            BlocBuilder<ArticleViewCubit, ArticleViewState>(
                builder: (context, state) {
              final combinedList = [
                ...state.listArticles
                    .map((article) => {'type': 'article', 'record': article}),
                ...state.listLiveStreams.map((liveStream) =>
                    {'type': 'liveStream', 'record': liveStream}),
              ];

              // Shuffle the combined list
              combinedList.shuffle(Random());
              return Swiper(
                itemBuilder: (context, index) {
                  final item = combinedList[index];

                  if (item['type'] == 'article') {
                    return ArticleScreen(
                      record: item['record'] as ArticleRecord,
                    );
                  } else {
                    final liveStreamRecord = item['record'] as LiveStreamRecord;
                    return LivestreamScreen(
                      record: liveStreamRecord,
                    );
                  }
                },
                itemCount:
                    state.listArticles.length + state.listLiveStreams.length,
                scrollDirection: Axis.vertical,
              );
            }),
          ],
        ),
      ),
    );
  }
}
