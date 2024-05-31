part of 'live_stream_record_cubit.dart';

@freezed
class LiveStreamRecordState with _$LiveStreamRecordState {
  const factory LiveStreamRecordState.initial(
    LiveStreamRecord record,
  ) = _Initial;

  const factory LiveStreamRecordState.submitting(
    LiveStreamRecord record,
  ) = _Submitting;

  const factory LiveStreamRecordState.submitSucceed(
    LiveStreamRecord record,
  ) = _SubmitSucceed;

  const factory LiveStreamRecordState.submitFailed(
    LiveStreamRecord record,
  ) = _SubmitFailed;
}
