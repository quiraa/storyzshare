import 'package:flutter_story_app/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  late SharedPreferences prefs;

  static const String _tokenKey = 'tokenKey';
  static const String _loginKey = 'loginToken';

  UserPreference() {
    initPreference();
  }

  Future<void> initPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? get token => prefs.getString(_tokenKey);
  bool? get isLoggedIn => prefs.getBool(_loginKey);

  set token(String? value) {
    prefs.setString(Constants.tokenKey, value ?? '');
  }

  set isLoggedIn(bool? value) {
    prefs.setBool(Constants.loginKey, value ?? false);
  }
}
