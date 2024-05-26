part of 'article_view_cubit.dart';

@freezed
class ArticleViewState with _$ArticleViewState {
  const factory ArticleViewState.initial({
    @Default([]) List<ArticleRecord> listArticles,
    ArticleRecord? loadedArticleRecord,
    NLatLng? currentLocation,
  }) = _Initial;

  const factory ArticleViewState.loading({
    required List<ArticleRecord> listArticles,
    ArticleRecord? loadedArticleRecord,
    NLatLng? currentLocation,
  }) = _Loading;

  const factory ArticleViewState.loaded({
    required List<ArticleRecord> listArticles,
    required ArticleRecord loadedArticleRecord,
    NLatLng? currentLocation,
  }) = _Loaded;

  const factory ArticleViewState.loadFailed({
    required List<ArticleRecord> listArticles,
    ArticleRecord? loadedArticleRecord,
    DateTime? loadedDate,
    required String message,
  }) = _LoadFailed;
}
