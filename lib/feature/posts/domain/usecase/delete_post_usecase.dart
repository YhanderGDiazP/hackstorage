import 'package:hackstorage/feature/posts/domain/repository/post_repository.dart';

class DeletePostUsecase {
  final PostRepository postRepository;
  DeletePostUsecase(this.postRepository);

  Future<bool> execute(String id) async {
    return await postRepository.deletePost(id);
  }
}
