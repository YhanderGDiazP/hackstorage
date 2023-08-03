import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hackstorage/feature/posts/domain/entities/post_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostProviderOffline with ChangeNotifier {
  final List<Post> _listPruebaPost = [];
  List<Post> get listPruebaPost => _listPruebaPost;

  Future<void> getPosts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Set<String> keys = prefs.getKeys();
      List<Post> posts = [];

      for (String key in keys) {
        if (key.startsWith('post_')) {
          String? jsonString = prefs.getString(key);
          if (jsonString != null) {
            Map<String, dynamic> post = jsonDecode(jsonString);
            Post postA = Post(
              id: post['id'],
              idUser: post['idUser'],
              user: post['user'],
              description: post['description'],
              password: post['password'],
            );
            posts.add(postA);
          }
        }
      }

      for (var post in posts) {
        _listPruebaPost.add(post);
      }
      notifyListeners();
    } catch (e) {
      throw Exception('Error al obtener a los Posts: $e');
    }
  }

  Future<bool> createPost(
      String idUser, String user, String password, String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Map<String, dynamic> newPost = {
        'id': generateRandomId(),
        'idUser': idUser,
        'user': user,
        'description': description,
        'password': password,
      };

      String jsonString = jsonEncode(newPost);
      await prefs.setString('post_${newPost['id']}', jsonString);

      getPosts();
      notifyListeners();

      return true;
    } catch (e) {
      throw Exception('Erro al crear la contraseña $e');
    }
  }

  Future<bool> updatePost(Post post) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String jsonString = jsonEncode(post.toMap());
      await prefs.setString('post_${post.id}', jsonString);

      getPosts();
      notifyListeners();

      return true;
    } catch (e) {
      throw Exception('Error al actualizar el post: $e');
    }
  }

  Future<bool> deletePost(String postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove('post_$postId');

      getPosts();
      notifyListeners();

      return true;
    } catch (e) {
      throw Exception('Error al eliminar el post: $e');
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
