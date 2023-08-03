import 'package:hackstorage/feature/posts/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<bool> createPost(Post post);
  Future<List<Post>> getPost();
  Future<Post> getPostById(String id);
  Future<bool> updatePost(Post post);
  Future<bool> deletePost(String id);
}
