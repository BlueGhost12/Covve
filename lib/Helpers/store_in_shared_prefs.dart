import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void storeInSharedPrefs(Map data) async {
  final prefs = await SharedPreferences.getInstance();
  String info = jsonEncode(data);
  prefs.setString('userInfo', info);
}
