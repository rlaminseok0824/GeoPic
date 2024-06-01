import 'package:flutter/material.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/feature/article/models/article_record.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:intl/intl.dart';

class ArticleScreen extends StatelessWidget {
  final ArticleRecord record;

  const ArticleScreen({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildTitle(record),
          const SizedBox(height: 10),
          _buildUsernameAndData(record),
          const SizedBox(height: 24),
          _buildImage(record),
          const SizedBox(height: 24),
          _buildDescription(record),
        ]),
        const Spacer(),
        Column(
          children: [
            _buildLocation(record),
            const SizedBox(height: 12),
            _buildTags(record),
            const SizedBox(height: 48),
          ],
        )
      ],
    );
  }

  static ClipRRect _buildImage(ArticleRecord record) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 300,
          width: double.infinity,
          color: AppColors.background,
          child: record.imageUrl == null
              ? const Icon(
                  Icons.image,
                )
              : InstaImageViewer(
                  child: Image.network(record.imageUrl!, fit: BoxFit.cover)),
        ));
  }

  static Row _buildTitle(ArticleRecord record) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(record.title!,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
      ],
    );
  }

  static Widget _buildDescription(ArticleRecord record) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(record.content!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }

  static Row _buildTags(ArticleRecord record) {
    return Row(
      children: record.tags
          .map((tag) => Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(tag,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ))
          .toList(),
    );
  }

  static Row _buildLocation(ArticleRecord record) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.point,
            ),
            const SizedBox(width: 8),
            Text(record.location!),
          ],
        ),
        Row(
          children: [
            _buildLatitude(record),
            const SizedBox(width: 8),
            _buildLongitude(record),
          ],
        )
      ],
    );
  }

  static Row _buildUsernameAndData(ArticleRecord record) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(width: 8),
            Text(record.username!),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.calendar_today),
            const SizedBox(width: 8),
            Text(DateFormat('yyyy-MM-dd').format(record.date.toLocal())),
          ],
        )
      ],
    );
  }

  static Row _buildLatitude(ArticleRecord record) {
    return Row(
      children: [
        const Text('위도'),
        const SizedBox(width: 8),
        Text(record.latitude!.toStringAsFixed(3)),
      ],
    );
  }

  static Row _buildLongitude(ArticleRecord record) {
    return Row(
      children: [
        const Text('경도'),
        const SizedBox(width: 8),
        Text(record.longitude!.toStringAsFixed(3)),
      ],
    );
  }
}
