import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:fullstack_fe/feature/article/models/article_record.dart';
import 'package:fullstack_fe/presentation/article_view/view/article_screen.dart';
import 'package:fullstack_fe/presentation/common/bottom_sheet/app_record_bottom_sheet.dart';

class ArticleRecordBottomSheet {
  const ArticleRecordBottomSheet._();

  static Future<void> show({
    required BuildContext context,
    required List<ArticleRecord> record,
  }) =>
      AppRecordBottomSheet.show(
          context: context,
          height: double.infinity,
          body: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Swiper(
                itemCount: record.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ArticleScreen(record: record[index]);
                }),
          ));
}
