import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/core/routers/app_routes.dart';
import 'package:fullstack_fe/presentation/common/text_fields/app_text_area.dart';
import 'package:fullstack_fe/presentation/live_stream/bloc/live_stream_record_cubit.dart';

class LiveStreamRecordLocation extends StatelessWidget {
  const LiveStreamRecordLocation({super.key});

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
                    context.read<LiveStreamRecordCubit>().load(result);
                  }),
              child: Text('위치', style: textStyle)),
          const SizedBox(height: 10),
          BlocBuilder<LiveStreamRecordCubit, LiveStreamRecordState>(
            builder: (context, state) {
              return AppTextArea(
                  initialValue: state.record.location ?? '',
                  onChanged: (value) => context
                      .read<LiveStreamRecordCubit>()
                      .update(
                          (previous) => previous.copyWith(location: value)));
            },
          )
        ],
      ),
    );
  }
}
