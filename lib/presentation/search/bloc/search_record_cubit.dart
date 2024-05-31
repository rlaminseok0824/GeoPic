import 'package:bloc/bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/core/resources/storage/search_storage.dart';
import 'package:fullstack_fe/feature/search/models/location_info.dart';
import 'package:fullstack_fe/feature/search/models/search_record.dart';
import 'package:fullstack_fe/feature/search/repositories/search_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_record_state.dart';
part 'search_record_cubit.freezed.dart';

@injectable
class SearchRecordCubit extends Cubit<SearchRecordState> {
  final SearchRepository _searchRepository;
  SearchRecordCubit(
    this._searchRepository,
  ) : super(SearchRecordState.initial(SearchRecord(
          date: DateTime.now(),
          locations: getIt<SearchStorage>().searchRecords ?? [],
        )));

  void load() {
    final searchRecords = getIt<SearchStorage>().searchRecords;
    final record = state.reocrd.copyWith(locations: searchRecords ?? []);
    emit(SearchRecordState.initial(record));
  }

  void update(
    SearchRecord Function(SearchRecord previous) onUpdate,
  ) async {
    final newRecord = onUpdate(state.reocrd);
    emit(SearchRecordState.initial(newRecord));
  }

  void submit() async {
    emit(SearchRecordState.submitting(state.reocrd));

    final result =
        await _searchRepository.fetchGeocodes(position: state.reocrd.text!);

    return result.fold((l) {
      final realLocation = l.copyWith(place: state.reocrd.text);
      getIt<SearchStorage>().saveSearchRecord(realLocation);
      update((previous) =>
          previous.copyWith(locations: [...previous.locations, realLocation]));
      emit(SearchRecordState.submitSucceed(state.reocrd));
    }, (r) => emit(SearchRecordState.submitFailed(state.reocrd)));
  }

  void onPressed(LocationInfo locationInfo) {
    getIt<SearchStorage>().deleteSearchRecord(locationInfo);
    getIt<SearchStorage>().saveSearchRecord(locationInfo);
    load();
    emit(SearchRecordState.submitSucceed(state.reocrd));
  }
}
