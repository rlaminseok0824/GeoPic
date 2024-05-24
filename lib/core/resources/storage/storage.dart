import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AppStorage {
  late final SharedPreferences _sharedPreferences;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  dynamic get(String key) {
    return _sharedPreferences.get(key);
  }

  List<String>? getLists(String key) {
    final value = _sharedPreferences.getStringList(key);
    return value;
  }

  void clear() async {
    await _sharedPreferences.clear();
  }

  bool has(String key) {
    return _sharedPreferences.containsKey(key);
  }

  Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }

  Future<bool> set(String key, data) async {
    return await _sharedPreferences.setString(key, data.toString());
  }

  Future<bool> setLists(String key, data) async {
    return await _sharedPreferences.setStringList(key, data);
  }
}
