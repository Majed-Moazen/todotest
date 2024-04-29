import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChachHelper {
  ChachHelper({Key? key});

  static SharedPreferences? sharedpreferences;

  static init() async {
    sharedpreferences = await SharedPreferences.getInstance();
  }

  static setDataString({required key, required value}) async {
    return await sharedpreferences?.setString(key, value);
  }

  static setDataInt({required key, required int value}) async {
    return await sharedpreferences?.setInt(key, value);
  }

  static setDataList({required key, required value}) async {
    return await sharedpreferences?.setStringList(key, value);
  }

  static getDataList({required key}) {
    return sharedpreferences?.getStringList(key);
  }

  static getData({
    required key,
  }) {
    return sharedpreferences?.get(key);
  }
}
