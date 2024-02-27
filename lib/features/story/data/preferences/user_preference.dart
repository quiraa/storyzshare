import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  late SharedPreferences prefs;

  static const _tokenKey = 'tokenKey';
  static const _loginKey = 'loginToken';

  UserPreference() {
    initPreference();
  }

  Future<void> initPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? get token => prefs.getString(_tokenKey);
  bool? get isLoggedIn => prefs.getBool(_loginKey);

  set token(String? value) {
    prefs.setString(_tokenKey, value ?? '');
  }

  set isLoggedIn(bool? value) {
    prefs.setBool(_loginKey, value ?? false);
  }
}
