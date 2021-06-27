class MyUser {
  String? id;
  String? email;
  String? password;
  String? userName;

  MyUser({this.id, this.email, this.userName, this.password});

  Map<String, dynamic> toMap() {
    return {
      'userID': id,
      'email': email,
      'userName': userName,
      'password': password
    };
  }
}
