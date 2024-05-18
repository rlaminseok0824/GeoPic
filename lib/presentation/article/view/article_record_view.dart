import 'package:flutter/material.dart';
import 'package:fullstack_fe/presentation/article/view/activity_record_location.dart';
import 'package:fullstack_fe/presentation/article/view/activity_record_position.dart';
import 'package:fullstack_fe/presentation/article/view/article_record_content.dart';
import 'package:fullstack_fe/presentation/article/view/article_record_picture.dart';
import 'package:fullstack_fe/presentation/article/view/article_record_title.dart';

class ArticleRecordView extends StatefulWidget {
  const ArticleRecordView({super.key});

  @override
  State<ArticleRecordView> createState() => _ArticleRecordViewState();
}

class _ArticleRecordViewState extends State<ArticleRecordView> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ArticleRecordPicture(),
        ArticleRecordTitle(),
        ArticleRecordContent(),
        ArticleRecordLocation(),
        ArticleRecordPosition(),
      ],
    );
  }
}
