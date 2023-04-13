import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  bool savedUsername = false;

  Future<SharedPreferences> _getPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  Future<String> getUsername() async {
    var preferences = await _getPreferences();
    String username = preferences.getString('username') ?? 'no_username_set';

    return username;
  }

  Future<void> setUsername(String username) async {
    var preferences = await _getPreferences();
    await preferences.setString('username', username);
  }

  Future<bool> checkUserExists() async {
    String username = await getUsername();
    DocumentSnapshot author = await FirebaseFirestore.instance.collection('users').doc(username).get();
    return author.exists;
  }
}
