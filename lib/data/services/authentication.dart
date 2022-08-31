import 'package:hive/hive.dart';

import '../../constants/enums.dart';
import '../model/user.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('userBox');
    print('HIVE==============================');
    print(_users.isNotEmpty.toString());
    if (!_users.isNotEmpty) {
      await _users.add(User('user1', 'test'));
      await _users.add(User('user2', 'test'));
    }
  }

  Future<String?> authenticateUser(
      final String username, final String password) async {
    final success = await _users.values.any((element) =>
        element.username == username && element.password == password);
    if (success) {
      return username;
    } else {
      return null;
    }
  }

  Future<UserCreationResult> createUser(
      final String username, final String password) async {
    final alreadyExists = _users.values.any(
        (element) => element.username.toLowerCase() == username.toLowerCase());
    if (alreadyExists) {
      return UserCreationResult.alreadyExists;
    }

    try {
      _users.add(User(username, password));
      return UserCreationResult.success;
    } on Exception catch (ex) {
      return UserCreationResult.failure;
    }
  }
}
