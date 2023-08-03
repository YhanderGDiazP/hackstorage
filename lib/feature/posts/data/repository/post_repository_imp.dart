import 'package:hackstorage/feature/posts/data/datasource/post_datasource.dart';
import 'package:hackstorage/feature/posts/domain/entities/post_entity.dart';
import 'package:hackstorage/feature/posts/domain/repository/post_repository.dart';

class PostRepositoryImp implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;

  PostRepositoryImp(this.postRemoteDataSource);

  @override
  Future<bool> createPost(Post post) async {
    return await postRemoteDataSource.createPost(post);
  }

  @override
  Future<bool> deletePost(String id) async {
    return await postRemoteDataSource.deletePost(id);
  }

  @override
  Future<List<Post>> getPost() async {
    return await postRemoteDataSource.getPost();
  }

  @override
  Future<Post> getPostById(String id) async {
    return await postRemoteDataSource.getPostById(id);
  }

  @override
  Future<bool> updatePost(Post post) async {
    return await postRemoteDataSource.updatePost(post);
  }
}
