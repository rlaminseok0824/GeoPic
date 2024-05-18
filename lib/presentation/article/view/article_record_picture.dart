import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/core/services/image_picker_service.dart';
import 'package:fullstack_fe/presentation/article/bloc/article_record_cubit.dart';

class ArticleRecordPicture extends StatelessWidget {
  const ArticleRecordPicture({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            GestureDetector(
                onTap: () async {
                  getIt<ImagePickerService>().pickFromAlbum().then(
                      (pictureFile) => context
                          .read<ArticleRecordCubit>()
                          .update((previous) => previous.copyWith(
                              pictureFile:
                                  pictureFile ?? previous.pictureFile)));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 290,
                    width: double.infinity,
                    color: AppColors.greyPrimary,
                    child: BlocBuilder<ArticleRecordCubit, ArticleRecordState>(
                      builder: (context, state) {
                        final picture = state.record.pictureFile;
                        if (picture == null) {
                          return _buildPicturePlaceholder();
                        }
                        return _buildPicture(picture.path);
                      },
                    ),
                  ),
                ))
          ],
        ));
  }
}

Widget _buildPicturePlaceholder() {
  return const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        Icons.image_outlined,
        size: 24,
        color: AppColors.background,
      ),
      SizedBox(height: 8),
      Text('사진 또는 영상 추가',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.background,
          ))
    ],
  );
}

Widget _buildPicture(
  String imagePath,
) {
  return Stack(
    fit: StackFit.expand,
    children: [
      Image.file(
        File(imagePath),
        fit: BoxFit.cover,
      )
    ],
  );
}
