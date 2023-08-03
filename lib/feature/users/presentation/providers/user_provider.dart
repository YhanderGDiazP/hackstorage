import 'package:flutter/material.dart';
import 'package:hackstorage/feature/users/domain/entities/user_entity.dart';
import 'package:hackstorage/feature/users/domain/usecase/get_users_usecase.dart';
import 'package:hackstorage/feature/users/domain/usecase/register_user_usecase.dart';

class UserProvider with ChangeNotifier {
  final RegisterUserUsecase registerUserUsecase;
  final GetUserUsecase getUserUsecasel;

  UserProvider(this.registerUserUsecase, this.getUserUsecasel);

  UserLogin? _userLogged;
  UserLogin? get userLogged => _userLogged;

  Future<bool> registerUser(String name, String user, String password) async {
    try {
      UserRegister newUser =
          UserRegister(name: name, user: user, password: password);
      bool userRegistered = await registerUserUsecase.execute(newUser);

      return userRegistered;
    } catch (e) {
      throw Exception('Error al crear User: $e');
    }
  }

  Future<bool> login(String user, String password) async {
    try {
      List<UserLogin> allUser = [];
      allUser = await getUserUsecasel.execute();

      for (var allUsers in allUser) {
        if (allUsers.user == user && allUsers.password == password) {
          _userLogged = allUsers;
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      throw Exception('Error al loggear al User: $e');
    }
  }
}
