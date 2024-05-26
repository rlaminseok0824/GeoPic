import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:fullstack_fe/feature/article/models/article_record.dart';
import 'package:fullstack_fe/feature/article/repositories/article_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_view_cubit.freezed.dart';
part 'article_view_state.dart';

@injectable
class ArticleViewCubit extends Cubit<ArticleViewState> {
  final ArticleRepository _articleRepository;
  ArticleViewCubit(this._articleRepository)
      : super(const ArticleViewState.initial());

  Future<void> load(double? latitude, double? longtitude) async {
    print('load');
    if (latitude == null || longtitude == null) return;

    final result = await _articleRepository.fetchRecords();
    emit(result.fold((l) {
      l.add(ArticleRecord.mock(DateTime.now()));
      return ArticleViewState.loaded(
          listArticles: l,
          loadedArticleRecord: ArticleRecord.mock(DateTime.now()));
    }, (r) {
      return const ArticleViewState.loadFailed(
          listArticles: [], message: 'Failed to load articles');
    }));
  }
}
