import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/feature/article/models/article_record.dart';

class ArticleScreen extends StatelessWidget {
  final ArticleRecord record;

  const ArticleScreen({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(record),
            const SizedBox(height: 24),
            _buildImage(record),
            const SizedBox(height: 24),
          ],
        )
      ],
    );
  }

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

  static Row _buildTitle(ArticleRecord record) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(record.title!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
