class User {
  String name;
  String email;
  String password;
  String deviceName;
  String token;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.deviceName,
    required this.token,
  });

  factory User.makeUser(Map<String, dynamic> object, String name, String email,
      String password, String deviceName) {
    return User(
      name: name,
      email: email,
      password: password,
      deviceName: deviceName,
      token: object['token'],
    );
  }
}
