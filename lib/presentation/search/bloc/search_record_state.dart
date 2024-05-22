part of 'search_record_cubit.dart';

@freezed
class SearchRecordState with _$SearchRecordState {
  const factory SearchRecordState.initial(
    SearchRecord reocrd,
  ) = _Initial;

  const factory SearchRecordState.submitting(
    SearchRecord reocrd,
  ) = _Submitting;

  const factory SearchRecordState.submitSucceed(
    SearchRecord reocrd,
  ) = _SubmitSucceed;

  const factory SearchRecordState.submitFailed(
    SearchRecord reocrd,
  ) = _SubmitFailed;
}
