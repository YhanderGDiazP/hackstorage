import 'package:hackstorage/feature/users/data/datasource/user_datasource.dart';
import 'package:hackstorage/feature/users/domain/entities/user_entity.dart';
import 'package:hackstorage/feature/users/domain/repository/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImp(this.userRemoteDataSource);

  @override
  Future<List<UserLogin>> getUsers() async {
    return await userRemoteDataSource.getUsers();
  }

  @override
  Future<bool> registerUser(UserRegister user) async {
    return await userRemoteDataSource.registerUser(user);
  }
}
