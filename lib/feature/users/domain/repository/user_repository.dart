import 'package:hackstorage/feature/users/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<bool> registerUser(UserRegister user);
  Future<List<UserLogin>> getUsers();
}