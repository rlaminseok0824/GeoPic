import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fullstack_fe/core/errors/api_failure.dart';
import 'package:fullstack_fe/core/services/err_tracking_service.dart';
import 'package:fullstack_fe/feature/article/datasources/article_client.dart';
import 'package:fullstack_fe/feature/article/models/article_record.dart';
import 'package:fullstack_fe/feature/picture/datasources/picture_client.dart';
import 'package:injectable/injectable.dart';

@prod
@LazySingleton()
class ArticleRepository {
  final ArticleClient _articleClient;
  final PictureClient _pictureClient;

  ArticleRepository(this._articleClient, this._pictureClient);

  Future<Either<ArticleRecord, ApiFailure>> createRecord({
    required ArticleRecord record,
  }) async {
    String imageUrl = '';
    //파일 업로드
    if (record.pictureFile != null) {
      try {
        final file = await MultipartFile.fromFile(record.pictureFile!.path);
        final response = await _pictureClient.uploadPictures(pictures: [file]);
        imageUrl = response.data['url'];
      } on DioException catch (e, s) {
        ErrTrackingService.captureException(
            ErrTrackingService.captureException(e, stackTrace: s));

        return right(ApiFailure.serverError(e, message: 'Server upload error'));
      } catch (e, s) {
        ErrTrackingService.captureException(
          e,
          stackTrace: s,
        );
        return right(ApiFailure.clientError(
          e,
          message: 'Client upload error',
        ));
      }
    }

    try {
      final result = await _articleClient
          .createRecord(record.copyWith(pictureFile: null, imageUrl: imageUrl));
      return left(result);
    } on DioException catch (e, s) {
      ErrTrackingService.captureException(
          ErrTrackingService.captureException(e, stackTrace: s));
      return right(ApiFailure.serverError(e, message: 'Server create error'));
    } catch (e, s) {
      ErrTrackingService.captureException(
        e,
        stackTrace: s,
      );
      return right(ApiFailure.clientError(
        e,
        message: 'Client create error',
      ));
    }
  }

  Future<Either<List<ArticleRecord>, ApiFailure>> fetchRecords() async {
    try {
      final result = await _articleClient.fetchArticles();
      return left(result);
    } on DioException catch (e, s) {
      ErrTrackingService.captureException(
          ErrTrackingService.captureException(e, stackTrace: s));
      return right(ApiFailure.serverError(e, message: 'Server fetch error'));
    } catch (e, s) {
      ErrTrackingService.captureException(
        e,
        stackTrace: s,
      );
      return right(ApiFailure.clientError(
        e,
        message: 'Client fetch error',
      ));
    }
  }
}
