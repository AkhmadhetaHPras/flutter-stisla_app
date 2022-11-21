class Auth {
  String email;
  String password;
  String deviceName;
  String token;

  Auth({
    required this.email,
    required this.password,
    required this.deviceName,
    required this.token,
  });

  factory Auth.makelogin(Map<String, dynamic> object, String email,
      String password, String deviceName) {
    return Auth(
      email: email,
      password: password,
      deviceName: deviceName,
      token: object['token'],
    );
  }
}
