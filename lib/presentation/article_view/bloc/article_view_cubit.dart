import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:fullstack_fe/feature/article/models/article_record.dart';
import 'package:fullstack_fe/feature/article/repositories/article_repository.dart';
import 'package:fullstack_fe/feature/live_stream/models/live_stream_record.dart';
import 'package:fullstack_fe/feature/live_stream/repositories/live_stream_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_view_cubit.freezed.dart';
part 'article_view_state.dart';

@injectable
class ArticleViewCubit extends Cubit<ArticleViewState> {
  final ArticleRepository _articleRepository;
  final LiveStreamRepository _liveStreamRepository;
  ArticleViewCubit(this._articleRepository, this._liveStreamRepository)
      : super(const ArticleViewState.initial());

  Future<void> load(double? latitude, double? longtitude) async {
    if (latitude == null || longtitude == null) return;

    final articleResult = await _articleRepository.fetchRecords();
    final livestreamResult = await _liveStreamRepository.fetchRecords();

    final List<ArticleRecord> articleArr = [];
    final List<LiveStreamRecord> livestreamArr = [];
    articleResult.fold((l) {
      articleArr.addAll(l);
    }, (r) => null);

    livestreamResult.fold((l) {
      livestreamArr.addAll(l);
    }, (r) => null);
    if (articleArr.isEmpty && livestreamArr.isEmpty) {
      return emit(ArticleViewState.loadFailed(
          listArticles: articleArr,
          listLiveStreams: livestreamArr,
          loadedArticleRecord: null,
          message: "No data found"));
    }
    return emit(ArticleViewState.loaded(
        listArticles: articleArr,
        loadedArticleRecord: articleArr.first,
        listLiveStreams: livestreamArr,
        currentLocation: NLatLng(latitude, longtitude)));
  }
}
