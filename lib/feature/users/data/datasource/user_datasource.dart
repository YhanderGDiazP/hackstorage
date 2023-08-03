import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackstorage/feature/users/domain/entities/user_entity.dart';

abstract class UserRemoteDataSource {
  Future<bool> registerUser(UserRegister user);
  Future<List<UserLogin>> getUsers();
}

class UserRemoteDataSourceImp implements UserRemoteDataSource {
  final db = FirebaseFirestore.instance;

  @override
  Future<List<UserLogin>> getUsers() async {
    try {
      QuerySnapshot querySnapshot = await db.collection('users').get();
      return querySnapshot.docs.map((doc) {
        return UserLogin(
          id: doc.id,
          user: doc['user'],
          password: doc['password'],
        );
      }).toList();
    } catch (e) {
      throw Exception('ERROR: $e');
    }
  }

  @override
  Future<bool> registerUser(UserRegister user) async {
    try {
      await db.collection('users').add({
        'name': user.name,
        'user': user.user,
        'password': user.password,
      });
      return true;
    } catch (e) {
      throw Exception('ERROR: $e');
    }
  }
}
