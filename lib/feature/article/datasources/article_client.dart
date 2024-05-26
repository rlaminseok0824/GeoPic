import 'package:dio/dio.dart';
import 'package:fullstack_fe/feature/article/models/article_record.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'article_client.g.dart';

@prod
@lazySingleton
@RestApi()
abstract class ArticleClient {
  @factoryMethod
  factory ArticleClient(Dio dio) = _ArticleClient;

  @GET('/articles/position')
  Future<List<ArticleRecord>> fetchArticlesByPostion({
    @Query('lat') required double lat,
    @Query('lng') required double lng,
  });

  @GET('/articles/{id}')
  Future<ArticleRecord> fetchArticleById(
    @Path() String id,
  );

  @GET('/articles/')
  Future<List<ArticleRecord>> fetchArticles();

  @POST('/articles/')
  Future<ArticleRecord> createRecord(@Body() ArticleRecord record);

  @PUT('/articles/{id}')
  Future<ArticleRecord> updateRecord(
    @Path() String id,
    @Body() ArticleRecord record,
  );

  @DELETE('/articles/{id}')
  Future<void> deleteRecord(@Path() String id);
}
