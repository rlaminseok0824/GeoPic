import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fullstack_fe/core/errors/api_failure.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/core/resources/storage/profile_storage.dart';
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

  ArticleRepository(
    this._articleClient,
    this._pictureClient,
  );

  Future<Either<ArticleRecord, ApiFailure>> createRecord({
    required ArticleRecord record,
  }) async {
    List<String> pictureUrls = [];

    //파일 업로드
    if (record.pictureFile != null) {
      try {
        final files = [await MultipartFile.fromFile(record.pictureFile!.path)];
        final response = await _pictureClient.uploadPictures(pictures: files);
        pictureUrls = List<String>.from(response.data['urls']);
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
      final result = await _articleClient.createRecord(record.copyWith(
        imageUrl: pictureUrls.firstOrNull,
        pictureFile: null,
        username: getIt<ProfileStorage>().profile,
      ));
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

  Future<Either<List<ArticleRecord>, ApiFailure>> fetchArticlesByPostion(
      {required double latitude, required double longitude}) async {
    try {
      final result = await _articleClient.fetchArticlesByPostion(
        lat: latitude,
        lng: longitude,
      );
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
