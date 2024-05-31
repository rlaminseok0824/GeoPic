import 'package:dio/dio.dart';
import 'package:fullstack_fe/feature/search/models/location_info.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'search_client.g.dart';

@prod
@lazySingleton
@RestApi()
abstract class SearchClient {
  @factoryMethod
  factory SearchClient(Dio dio) = _SearchClient;

  @GET('/geocodes/')
  Future<LocationInfo> fetchGeocodes({
    @Query('position') required String position,
  });
}
