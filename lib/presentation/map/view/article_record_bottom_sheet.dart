import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/feature/article/models/article_record.dart';
import 'package:fullstack_fe/presentation/common/bottom_sheet/app_record_bottom_sheet.dart';
import 'package:go_router/go_router.dart';

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
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTitle(context, record[index]),
                          const SizedBox(height: 24),
                          _buildImage(record[index]),
                          const SizedBox(height: 24),
                        ],
                      )
                    ],
                  );
                }),
          ));

  // body: Column(
  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   children: [
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         _buildTitle(context, record),
  //         const SizedBox(height: 24),
  //         _buildImage(record),
  //         const SizedBox(height: 24),
  //       ],
  //     )
  //   ],
  // ));

  static ClipRRect _buildImage(ArticleRecord record) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 200,
          width: double.infinity,
          color: AppColors.background,
          child: record.imageUrl == null
              ? null
              : Image.network(record.imageUrl!, fit: BoxFit.cover),
        ));
  }

  static Row _buildTitle(BuildContext context, ArticleRecord record) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(record.title!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        IconButton(
          icon: const Icon(
            Icons.close,
            size: 24,
          ),
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}
