class AuthParams {
  String? name;
  String? email;
  String? password;
  String? passwordConfirmation;

  AuthParams({this.name, this.email, this.password, this.passwordConfirmation});

  factory AuthParams.fromJson(Map<String, dynamic> json) {
    return AuthParams(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      passwordConfirmation: json['password_confirmation'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }
}

// "name": "Ahmed",
// "email": "sayed8880@gmail.com",
// "password": "12345678",
// "password_confirmation": "12345678",
