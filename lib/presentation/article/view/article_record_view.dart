import 'package:flutter/material.dart';
import 'package:fullstack_fe/presentation/article/view/article_record_picture.dart';

class ArticleRecordView extends StatefulWidget {
  const ArticleRecordView({super.key});

  @override
  State<ArticleRecordView> createState() => _ArticleRecordViewState();
}

class _ArticleRecordViewState extends State<ArticleRecordView> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [ArticleRecordPicture()],
    );
  }
}
