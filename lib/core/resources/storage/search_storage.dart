import 'dart:convert';

import 'package:fullstack_fe/core/resources/storage/storage.dart';
import 'package:fullstack_fe/core/resources/storage/storage_key.dart';
import 'package:fullstack_fe/feature/search/models/location_info.dart';
import 'package:injectable/injectable.dart';

@singleton
class SearchStorage {
  final AppStorage _storage;

  SearchStorage(this._storage);

  List<LocationInfo>? get searchRecords {
    List<String>? stringList = _storage.getLists(StorageKey.searchRecords);
    if (stringList == null) return [];
    return stringList
        .map((jsonString) => LocationInfo.fromJson(json.decode(jsonString)))
        .toList();
  }

  Future<void> saveSearchRecord(LocationInfo location) async {
    List<String> stringList = _storage.getLists(StorageKey.searchRecords) ?? [];
    stringList.add(json.encode(location.toJson()));
    await _storage.setLists(StorageKey.searchRecords, stringList);
  }

  Future<void> deleteSearchRecord(LocationInfo location) async {
    List<LocationInfo> locationList = searchRecords ?? [];
    locationList.removeWhere((item) => item.place == location.place);

    List<String> stringList =
        locationList.map((loc) => json.encode(loc.toJson())).toList();
    await _storage.setLists(StorageKey.searchRecords, stringList);
  }

  Future<void> clearSearchRecords() async {
    await _storage.remove(StorageKey.searchRecords);
  }
}
