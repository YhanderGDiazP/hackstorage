import 'package:hackstorage/feature/users/domain/entities/user_entity.dart';
import 'package:hackstorage/feature/users/domain/repository/user_repository.dart';

class GetUserUsecase {
  final UserRepository userRepository;
  GetUserUsecase(this.userRepository);

  Future<List<UserLogin>> execute() async {
    return await userRepository.getUsers();
  }
}
