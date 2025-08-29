// class LoginUserResponse {
//   final String message;
//   final String token;
//   final LoginUser user;

//   LoginUserResponse({
//     required this.message,
//     required this.token,
//     required this.user,
//   });

//   factory LoginUserResponse.fromJson(Map<String, dynamic> json) {
//     return LoginUserResponse(
//       message: json['message'],
//       token: json['token'],
//       user: LoginUser.fromJson(json['user']),
//     );
//   }

//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     'message': message,
//   //     'token': token,
//   //     'user': user.toJson(),
//   //   };
//   // }
// }

// class LoginUser {
//   final int id;
//   final String first_name;
//   final String last_name;
//   final String email;
//   final String phone;
//   final String user_role;

//   LoginUser({
//     required this.id,
//     required this.first_name,
//     required this.last_name,
//     required this.email,
//     required this.phone,
//     required this.user_role,
//   });

//   factory LoginUser.fromJson(Map<String, dynamic> json) {
//     return LoginUser(
//       id: json['id'],
//       first_name: json['first_name'],
//       last_name: json['last_name'],
//       email: json['email'],
//       phone: json['phone'],
//       user_role: json['role'],
//     );
//   }

//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     'id': id,
//   //     'email': email,
//   //     'role': role,
//   //   };
//   // }
// }

class LoginUserResponse {
  final String message;
  final String token;
  final User user;

  LoginUserResponse({
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginUserResponse.fromJson(Map<String, dynamic> json) {
    return LoginUserResponse(
      message: json['message'],
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'user': user.toJson(),
    };
  }
}

class User {
  final int id;
  final String first_name;
  final String last_name;
  final String email;
  final String phone;
  final String user_role;

  User({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phone,
    required this.user_role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      user_role: json['user_role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'phone': phone,
      'user_role': user_role,
    };
  }
}
