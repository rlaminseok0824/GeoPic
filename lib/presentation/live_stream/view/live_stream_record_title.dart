import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/presentation/common/text_fields/app_text_area.dart';
import 'package:fullstack_fe/presentation/live_stream/bloc/live_stream_record_cubit.dart';

class LiveStreamRecordTitle extends StatelessWidget {
  const LiveStreamRecordTitle({super.key});

  final textStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.greyPrimary);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('제목', style: textStyle),
          const SizedBox(height: 10),
          BlocBuilder<LiveStreamRecordCubit, LiveStreamRecordState>(
            builder: (context, state) {
              return AppTextArea(
                  initialValue: state.record.title ?? '',
                  onChanged: (value) => context
                      .read<LiveStreamRecordCubit>()
                      .update((previous) => previous.copyWith(title: value)));
            },
          )
        ],
      ),
    );
  }
}
