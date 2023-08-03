import 'package:hackstorage/feature/posts/domain/entities/post_entity.dart';
import 'package:hackstorage/feature/posts/domain/repository/post_repository.dart';

class UpdatePostUsecase {
  final PostRepository postRepository;
  UpdatePostUsecase(this.postRepository);

  Future<bool> execute(Post post) async {
    return await postRepository.updatePost(post);
  }
}
