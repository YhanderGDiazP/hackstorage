import 'package:hackstorage/feature/posts/domain/entities/post_entity.dart';
import 'package:hackstorage/feature/posts/domain/repository/post_repository.dart';

class GetPostByIdUsecase {
  final PostRepository postRepository;
  GetPostByIdUsecase(this.postRepository);

  Future<Post> execute(String id) async {
    return await postRepository.getPostById(id);
  }
}
