import 'package:flutter/material.dart';
import 'package:hackstorage/feature/posts/domain/entities/post_entity.dart';
import 'package:hackstorage/feature/posts/domain/usecase/create_post_usecase.dart';
import 'package:hackstorage/feature/posts/domain/usecase/delete_post_usecase.dart';
import 'package:hackstorage/feature/posts/domain/usecase/get_post_usecase.dart';
import 'package:hackstorage/feature/posts/domain/usecase/update_post_usecase.dart';

class PostProvider with ChangeNotifier {
  final GetPostUsecase getPostUsecase;
  final CreatePostUsecase createPostUsecase;
  final UpdatePostUsecase updatePostUsecase;
  final DeletePostUsecase deletePostUsecase;

  PostProvider(this.getPostUsecase, this.createPostUsecase,
      this.updatePostUsecase, this.deletePostUsecase);

  final List<Post> _listPruebaPost = [];

  List<Post> get listPruebaPost => _listPruebaPost;

  Future<void> getAllPost() async {
    try {
      List<Post> allPost = await getPostUsecase.execute();
      for (var post in allPost) {
        _listPruebaPost.add(post);
      }
      notifyListeners();
    } catch (e) {
      throw Exception('Erro al obtener las contraseñas $e');
    }
  }

  Future<bool> createPost(
      String idUser, String user, String password, String description) async {
    try {
      Post newPost = Post(
        id: '',
        idUser: idUser,
        user: user,
        description: description,
        password: password,
      );

      bool postCreated = await createPostUsecase.execute(newPost);
      if (postCreated) {
        getAllPost();
        notifyListeners();
      }

      return postCreated;
    } catch (e) {
      throw Exception('Erro al crear la contraseña $e');
    }
  }

  Future<bool> updatePost(Post post) async {
    try {
      bool postUpdated = await updatePostUsecase.execute(post);

      if (postUpdated) {
        getAllPost();
        notifyListeners();
      }

      return postUpdated;
    } catch (e) {
      throw Exception('Erro al actualizar la contraseña $e');
    }
  }

  Future<bool> deletePost(String id) async {
    try {
      bool postDelete = await deletePostUsecase.execute(id);

      if (postDelete) {
        getAllPost();
        notifyListeners();
      }

      return postDelete;
    } catch (e) {
      throw Exception('Erro al eliminar la contraseña $e');
    }
  }
}
