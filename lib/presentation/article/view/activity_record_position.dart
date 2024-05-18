import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/presentation/article/bloc/article_record_cubit.dart';
import 'package:fullstack_fe/presentation/common/text_fields/app_text_area.dart';

class ArticleRecordPosition extends StatelessWidget {
  const ArticleRecordPosition({super.key});

  final textStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.greyPrimary);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('경도', style: textStyle),
                  const SizedBox(height: 10),
                  BlocBuilder<ArticleRecordCubit, ArticleRecordState>(
                    builder: (context, state) {
                      return AppTextArea(
                          readOnly: true,
                          onChanged: (value) => context
                              .read<ArticleRecordCubit>()
                              .update((previous) => previous.copyWith(
                                  longitude: double.parse(value))));
                    },
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('위도', style: textStyle),
                  const SizedBox(height: 10),
                  BlocBuilder<ArticleRecordCubit, ArticleRecordState>(
                    builder: (context, state) {
                      return AppTextArea(
                          readOnly: true,
                          onChanged: (value) => context
                              .read<ArticleRecordCubit>()
                              .update((previous) => previous.copyWith(
                                  latitude: double.parse(value))));
                    },
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
