import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackstorage/feature/users/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProviderOffline with ChangeNotifier {
  UserLogin? _userLogged;
  UserLogin? get userLogged => _userLogged;

  Future<bool> registerUser(String name, String user, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Map<String, dynamic> newUser = {
        'id': generateRandomId(),
        'name': name,
        'user': user,
        'password': password,
      };

      String jsonString = jsonEncode(newUser);
      await prefs.setString('user_${newUser['id']}', jsonString);

      return true;
    } catch (e) {
      throw Exception('Error al crear User: $e');
    }
  }

  Future<List<UserLogin>> getUsers() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Set<String> keys = prefs.getKeys();
      List<UserLogin> users = [];

      for (String key in keys) {
        if (key.startsWith('user_')) {
          String? jsonString = prefs.getString(key);
          if (jsonString != null) {
            Map<String, dynamic> user = jsonDecode(jsonString);
            UserLogin userLogin = UserLogin(
              id: user['id'],
              user: user['user'],
              password: user['password'],
            );
            users.add(userLogin);
          }
        }
      }

      return users;
    } catch (e) {
      throw Exception('Error al obtener a los Users: $e');
    }
  }

  Future<bool> loginUser(String userL, String passwordL) async {
    try {
      List<UserLogin> users = [];
      users = await getUsers();

      for (var user in users) {
        if (user.user == userL && user.password == passwordL) {
          _userLogged = user;
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      throw Exception('Error al loggear al User: $e');
    }
  }

  String generateRandomId() {
    const allowedChars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    const length = 5;
    final random = Random();
    final id = List.generate(length, (index) {
      int randomIndex = random.nextInt(allowedChars.length);
      return allowedChars[randomIndex];
    });
    return id.join();
  }
}
