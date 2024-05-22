part of 'article_record_cubit.dart';

@freezed
class ArticleRecordState with _$ArticleRecordState {
  const factory ArticleRecordState.initial(
    ArticleRecord record,
  ) = _Initial;

  const factory ArticleRecordState.submitting(
    ArticleRecord record,
  ) = _Submitting;

  const factory ArticleRecordState.submitSucceed(
    ArticleRecord record,
  ) = _SubmitSucceed;

  const factory ArticleRecordState.submitFailed(
    ArticleRecord record,
  ) = _SubmitFailed;

  const factory ArticleRecordState.loaded(
    ArticleRecord record,
  ) = _Loaded;
}
