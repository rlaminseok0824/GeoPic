import 'package:dio/dio.dart';
import 'package:fullstack_fe/feature/live_stream/models/live_stream_record.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'live_stream_client.g.dart';

@prod
@lazySingleton
@RestApi()
abstract class LiveStreamClient {
  @factoryMethod
  factory LiveStreamClient(Dio dio) = _LiveStreamClient;

  @GET('/live_streams/')
  Future<List<LiveStreamRecord>> fetchLiveStreams();

  @POST('/live_streams')
  Future<LiveStreamRecord> createRecord(@Body() LiveStreamRecord record);

  @DELETE('/live_streams/{id}')
  Future<void> deleteRecord(@Path() String id);
}
