import 'package:user_validator/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceSource {
  Future<void> saveData(User user) async {
    // save user data to shared preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.userId);
    await prefs.setString('userName', user.userName);
    await prefs.setBool('isReview', user.isReview);
  }

  Future<User?> getData() async {
    // get user data from shared preference
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final userName = prefs.getString('userName');
    final isReview = prefs.getBool('isReview');
    if (userId != null && userName != null && isReview != null) {
      return User(userId: userId, userName: userName, isReview: isReview);
    }
    return null;
  }

  Future<void> clearData() async {
    // clear user data from shared preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('userName');
    await prefs.remove('isReview');
  }
}
