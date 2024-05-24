import 'package:fullstack_fe/core/resources/storage/storage.dart';
import 'package:fullstack_fe/core/resources/storage/storage_key.dart';
import 'package:injectable/injectable.dart';

@singleton
class ProfileStorage {
  final AppStorage _storage;

  ProfileStorage(this._storage);

  String? get profile {
    return _storage.get(StorageKey.profileRecords);
  }

  Future<void> saveProfile(String profile) async {
    await _storage.set(StorageKey.profileRecords, profile);
  }

  Future<void> deleteProfile() async {
    await _storage.remove(StorageKey.profileRecords);
  }
}
