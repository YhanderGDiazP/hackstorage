import 'package:hackstorage/feature/posts/domain/entities/post_entity.dart';
import 'package:hackstorage/feature/posts/domain/repository/post_repository.dart';

class GetPostUsecase {
  final PostRepository postRepository;
  GetPostUsecase(this.postRepository);

  Future<List<Post>> execute() async {
    return await postRepository.getPost();
  }
}
