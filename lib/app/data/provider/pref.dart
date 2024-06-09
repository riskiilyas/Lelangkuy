import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  static const mEmail = 'Email';

  static Future<String?> getEmail() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(mEmail);
  }

  static Future<void> setEmail(String value) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(mEmail, value);
  }

  static const mPassword = 'Password';

  static Future<String?> getPassword() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(mPassword);
  }

  static Future<void> setPassword(String value) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(mPassword, value);
  }

  static const mName = 'Name';

  static Future<String?> getName() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(mName);
  }

  static Future<void> setName(String value) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(mName, value);
  }


  static const mUid = 'Uid';

  static Future<int?> getUid() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(mUid);
  }

  static Future<void> setUid(int value) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(mUid, value);
  }

}