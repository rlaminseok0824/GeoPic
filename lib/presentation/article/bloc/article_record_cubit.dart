import 'package:bloc/bloc.dart';
import 'package:fullstack_fe/feature/article/models/article_record.dart';
import 'package:fullstack_fe/feature/search/models/location_info.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_record_cubit.freezed.dart';
part 'article_record_state.dart';

@injectable
class ArticleRecordCubit extends Cubit<ArticleRecordState> {
  ArticleRecordCubit()
      : super(ArticleRecordState.initial(ArticleRecord(
          date: DateTime.now(),
        )));

  void load(LocationInfo locationInfo) {
    update((previous) => previous.copyWith(
          location: locationInfo.place,
          latitude: locationInfo.latitude,
          longitude: locationInfo.longitude,
        ));
    emit(ArticleRecordState.loaded(state.record));
  }

  void update(
    ArticleRecord Function(ArticleRecord previous) onUpdate,
  ) async {
    final newRecord = onUpdate(state.record);
    emit(ArticleRecordState.initial(newRecord));
  }

  void patch() async {
    emit(ArticleRecordState.submitting(state.record));
    if (state.record.id == null) {
      return emit(ArticleRecordState.submitFailed(state.record));
    }
    await Future.delayed(const Duration(seconds: 1));
    emit(ArticleRecordState.submitSucceed(state.record));
  }

  void submit() async {
    emit(ArticleRecordState.submitting(state.record));

    await Future.delayed(const Duration(seconds: 1));
    emit(ArticleRecordState.submitSucceed(state.record));
  }
}
