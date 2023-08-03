class Post {
  String id;
  String idUser;
  String user;
  String description;
  String password;

  Post({
    required this.id,
    required this.idUser,
    required this.user,
    required this.description,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idUser': idUser,
      'user': user,
      'description': description,
      'password': password,
    };
  }

  // Método fromMap
  static Post fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      idUser: map['idUser'],
      user: map['user'],
      description: map['description'],
      password: map['password'],
    );
  }
}
