class User {
  String id;
  String name;
  String user;

  User({
    required this.id,
    required this.name,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'user': user,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      user: map['user'],
    );
  }
}

class UserLogin {
  String id;
  String user;
  String password;

  UserLogin({
    required this.id,
    required this.user,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'password': password,
    };
  }

  static UserLogin fromMap(Map<String, dynamic> map) {
    return UserLogin(
      id: map['id'],
      user: map['user'],
      password: map['password'],
    );
  }
}

class UserRegister {
  String name;
  String user;
  String password;

  UserRegister({
    required this.name,
    required this.user,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'user': user,
      'password': password,
    };
  }

  static UserRegister fromMap(Map<String, dynamic> map) {
    return UserRegister(
      name: map['name'],
      user: map['user'],
      password: map['password'],
    );
  }
}
