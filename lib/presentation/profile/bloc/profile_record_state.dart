part of 'profile_record_cubit.dart';

@freezed
class ProfileRecordState with _$ProfileRecordState {
  const factory ProfileRecordState.initial(
    String name,
  ) = _Initial;

  const factory ProfileRecordState.submitting(
    String name,
  ) = _Submitting;

  const factory ProfileRecordState.submitSucceed(
    String name,
  ) = _SubmitSucceed;

  const factory ProfileRecordState.submitFailed(
    String name,
  ) = _SubmitFailed;
}
