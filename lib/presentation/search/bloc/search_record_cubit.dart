import 'package:bloc/bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/feature/search/models/location_info.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fullstack_fe/core/resources/storage/storage.dart';

part 'search_record_state.dart';
part 'search_record_cubit.freezed.dart';

@injectable
class SearchRecordCubit extends Cubit<SearchRecordState> {
  SearchRecordCubit()
      : super(SearchRecordState.initial(
            getIt<AppStorage>().get('search_reocrds') ?? [], ""));

  void update(
    String Function(String previous) onUpdate,
  ) async {
    final newRecord = onUpdate(state.searchText);
    emit(SearchRecordState.initial(state.record, newRecord));
  }

  void patch() async {
    emit(SearchRecordState.submitting(state.record, state.searchText));
    if (state.record.isEmpty) {
      return emit(
          SearchRecordState.submitFailed(state.record, state.searchText));
    }
    await Future.delayed(const Duration(seconds: 1));
    emit(SearchRecordState.submitSucceed(state.record, state.searchText));
  }

  void submit() async {
    emit(SearchRecordState.submitting(state.record, state.searchText));

    await Future.delayed(const Duration(seconds: 1));
    emit(SearchRecordState.submitSucceed(state.record, state.searchText));
  }
}
