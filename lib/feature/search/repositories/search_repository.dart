import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fullstack_fe/core/errors/api_failure.dart';
import 'package:fullstack_fe/core/services/err_tracking_service.dart';
import 'package:fullstack_fe/feature/search/datasources/search_client.dart';
import 'package:fullstack_fe/feature/search/models/location_info.dart';
import 'package:injectable/injectable.dart';

@prod
@LazySingleton()
class SearchRepository {
  final SearchClient _searchClient;

  SearchRepository(this._searchClient);

  Future<Either<LocationInfo, ApiFailure>> fetchGeocodes({
    required String position,
  }) async {
    try {
      final result = await _searchClient.fetchGeocodes(position: position);
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
