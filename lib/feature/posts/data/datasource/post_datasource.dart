import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackstorage/feature/posts/domain/entities/post_entity.dart';

abstract class PostRemoteDataSource {
  Future<bool> createPost(Post post);
  Future<List<Post>> getPost();
  Future<Post> getPostById(String id);
  Future<bool> updatePost(Post post);
  Future<bool> deletePost(String id);
}

class PostRemoteDataSourceImp implements PostRemoteDataSource {
  final db = FirebaseFirestore.instance;

  @override
  Future<bool> createPost(Post post) async {
    try {
      await db.collection('posts').add({
        'idUser': post.idUser,
        'user': post.user,
        'password': post.password,
        'description': post.description,
      });
      return true;
    } catch (e) {
      throw Exception('ERROR: $e');
    }
  }

  @override
  Future<bool> deletePost(String id) async {
    try {
      await db.collection('posts').doc(id).delete();
      return true;
    } catch (e) {
      throw Exception('ERROR: $e');
    }
  }

  @override
  Future<List<Post>> getPost() async {
    try {
      QuerySnapshot querySnapshot = await db.collection('posts').get();
      return querySnapshot.docs.map((doc) {
        return Post(
          id: doc.id,
          idUser: doc['idUser'],
          user: doc['user'],
          description: doc['description'],
          password: doc['password'],
        );
      }).toList();
    } catch (e) {
      throw Exception('ERROR: $e');
    }
  }

  @override
  Future<Post> getPostById(String id) async {
    try {
      DocumentSnapshot doc = await db.collection('posts').doc(id).get();
      return Post(
        id: doc.id,
        idUser: doc['idUser'],
        user: doc['user'],
        description: doc['description'],
        password: doc['password'],
      );
    } catch (e) {
      throw Exception('ERROR: $e');
    }
  }

  @override
  Future<bool> updatePost(Post post) async {
    try {
      await db.collection('posts').doc(post.id).update({
        'idUser': post.idUser,
        'user': post.user,
        'password': post.password,
        'description': post.description,
      });
      return true;
    } catch (e) {
      throw Exception('ERROR: $e');
    }
  }
}
