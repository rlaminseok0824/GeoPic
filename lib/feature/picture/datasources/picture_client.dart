import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'picture_client.g.dart';

@prod
@lazySingleton
@RestApi()
abstract class PictureClient {
  @factoryMethod
  factory PictureClient(Dio dio) = _PictureClient;

  @POST('/articles/picture')
  @MultiPart()
  Future<HttpResponse> uploadPictures({
    @Part() required List<MultipartFile> pictures,
  });
}
