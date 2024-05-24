import 'package:bloc/bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/core/resources/storage/profile_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_record_state.dart';
part 'profile_record_cubit.freezed.dart';

@injectable
class ProfileRecordCubit extends Cubit<ProfileRecordState> {
  ProfileRecordCubit() : super(const ProfileRecordState.initial(''));

  void update(String profile) {
    emit(ProfileRecordState.initial(profile));
  }

  void submit() {
    emit(ProfileRecordState.submitting(state.name));
    getIt<ProfileStorage>().saveProfile(state.name);
    emit(ProfileRecordState.submitSucceed(state.name));
  }

  void load() {
    String profile =
        getIt<ProfileStorage>().profile ?? 'user-${const Uuid().v4()}';
    getIt<ProfileStorage>().saveProfile(profile);
    emit(ProfileRecordState.initial(profile));
  }
}
