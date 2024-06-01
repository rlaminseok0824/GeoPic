import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fullstack_fe/core/errors/api_failure.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/core/resources/storage/profile_storage.dart';
import 'package:fullstack_fe/core/services/err_tracking_service.dart';
import 'package:fullstack_fe/feature/live_stream/datasources/live_stream_client.dart';
import 'package:fullstack_fe/feature/live_stream/models/live_stream_record.dart';
import 'package:injectable/injectable.dart';

@prod
@LazySingleton()
class LiveStreamRepository {
  final LiveStreamClient _liveStreamClient;

  LiveStreamRepository(
    this._liveStreamClient,
  );

  Future<Either<LiveStreamRecord, ApiFailure>> createRecord({
    required LiveStreamRecord record,
  }) async {
    try {
      final result = await _liveStreamClient.createRecord(record.copyWith(
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

  Future<Either<List<LiveStreamRecord>, ApiFailure>> fetchRecords() async {
    try {
      final result = await _liveStreamClient.fetchLiveStreams();
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
