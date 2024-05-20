part of 'search_record_cubit.dart';

@freezed
class SearchRecordState with _$SearchRecordState {
  const factory SearchRecordState.initial(
      List<LocationInfo> record, String searchText) = _Initial;

  const factory SearchRecordState.submitting(
      List<LocationInfo> record, String searchText) = _Submitting;

  const factory SearchRecordState.submitSucceed(
      List<LocationInfo> record, String searchText) = _SubmitSucceed;

  const factory SearchRecordState.submitFailed(
      List<LocationInfo> record, String searchText) = _SubmitFailed;
}
