import 'package:bloc/bloc.dart';
import 'package:fullstack_fe/feature/live_stream/models/live_stream_record.dart';
import 'package:fullstack_fe/feature/search/models/location_info.dart';
import 'package:fullstack_fe/feature/websocket/repositories/websocket_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_stream_record_state.dart';
part 'live_stream_record_cubit.freezed.dart';

@injectable
class LiveStreamRecordCubit extends Cubit<LiveStreamRecordState> {
  final WebsocketRepository _websocketRepository;
  final String videoId;

  LiveStreamRecordCubit(this._websocketRepository, {required this.videoId})
      : super(LiveStreamRecordState.initial(LiveStreamRecord(
          date: DateTime.now(),
          videoId: videoId,
        ))) {
    // setupWebSocketListener();
  }

  Future<void> setupWebSocketListener() async {
    try {
      await _websocketRepository.connectWebsocket(
        (message) => print(message),
        roomId: "123",
        isBroadcasting: true,
      );
    } catch (e) {
      print(e);
    }
  }

  void load(LocationInfo locationInfo) {
    update((previous) => previous.copyWith(
          location: locationInfo.place,
          latitude: locationInfo.latitude,
          longitude: locationInfo.longitude,
        ));
    emit(LiveStreamRecordState.initial(state.record));
  }

  void update(
    LiveStreamRecord Function(LiveStreamRecord previous) onUpdate,
  ) async {
    final newRecord = onUpdate(state.record);
    emit(LiveStreamRecordState.initial(newRecord));
  }

  void submit() async {
    emit(LiveStreamRecordState.submitting(state.record));

    await Future.delayed(const Duration(seconds: 1));
    emit(LiveStreamRecordState.submitSucceed(state.record));
  }
}
