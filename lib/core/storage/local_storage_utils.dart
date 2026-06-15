

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUtils {

  late final SharedPreferences _prefs;

  Future<LocalStorageUtils> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  SharedPreferences get prefs => _prefs;


  Future<void> setBool(String key, bool value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool = prefs.getBool(key) ?? false;
    return bool;
  }

  Future<void> setString (String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> removeString (String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<String> getString(String string) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(string) ?? "";
  }



}

