import 'package:bloc/bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/core/resources/storage/profile_storage.dart';
import 'package:fullstack_fe/feature/live_stream/models/live_stream_record.dart';
import 'package:fullstack_fe/feature/live_stream/repositories/live_stream_repository.dart';
import 'package:fullstack_fe/feature/search/models/location_info.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_stream_record_state.dart';
part 'live_stream_record_cubit.freezed.dart';

@injectable
class LiveStreamRecordCubit extends Cubit<LiveStreamRecordState> {
  // final String videoId;
  final LiveStreamRepository _liveStreamRepository;

  LiveStreamRecordCubit(this._liveStreamRepository)
      : super(LiveStreamRecordState.initial(LiveStreamRecord(
          date: DateTime.now(),
        )));

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

    final result = await _liveStreamRepository.createRecord(
        record: state.record.copyWith(
            videoID: "video",
            username: getIt<ProfileStorage>().profile,
            content: "content"));

    return result.fold((l) => emit(LiveStreamRecordState.submitSucceed(l)),
        (r) => emit(LiveStreamRecordState.submitFailed(state.record)));
  }
}
