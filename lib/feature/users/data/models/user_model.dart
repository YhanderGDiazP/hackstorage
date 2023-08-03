import 'package:hackstorage/feature/users/domain/entities/user_entity.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String user,
  }) : super(
          id: id,
          name: name,
          user: user,
        );
}
