import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/core/routers/app_routes.dart';
import 'package:fullstack_fe/presentation/article/bloc/article_record_cubit.dart';
import 'package:fullstack_fe/presentation/common/text_fields/app_text_area.dart';

class ArticleRecordLocation extends StatelessWidget {
  const ArticleRecordLocation({super.key});

  final textStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.greyPrimary);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () => const SearchRoute().push(context).then((result) {
                    context.read<ArticleRecordCubit>().load(result);
                  }),
              child: Text('위치', style: textStyle)),
          const SizedBox(height: 10),
          BlocBuilder<ArticleRecordCubit, ArticleRecordState>(
            builder: (context, state) {
              print('state.record.location: ${state.record.location}');
              return AppTextArea(
                  initialValue: state.record.location ?? '',
                  onChanged: (value) => context
                      .read<ArticleRecordCubit>()
                      .update(
                          (previous) => previous.copyWith(location: value)));
            },
          )
        ],
      ),
    );
  }
}
