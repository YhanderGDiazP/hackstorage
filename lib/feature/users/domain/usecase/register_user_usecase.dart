import 'package:hackstorage/feature/users/domain/entities/user_entity.dart';
import 'package:hackstorage/feature/users/domain/repository/user_repository.dart';

class RegisterUserUsecase {
  final UserRepository userRepository;
  RegisterUserUsecase(this.userRepository);

  Future<bool> execute(UserRegister user) async {
    return await userRepository.registerUser(user);
  }
}