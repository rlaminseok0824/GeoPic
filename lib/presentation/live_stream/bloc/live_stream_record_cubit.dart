import 'package:bloc/bloc.dart';
import 'package:fullstack_fe/feature/live_stream/models/live_stream_record.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_stream_record_state.dart';
part 'live_stream_record_cubit.freezed.dart';

@injectable
class LiveStreamRecordCubit extends Cubit<LiveStreamRecordState> {
  LiveStreamRecordCubit()
      : super(LiveStreamRecordState.initial(LiveStreamRecord(
          date: DateTime.now(),
        )));

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
