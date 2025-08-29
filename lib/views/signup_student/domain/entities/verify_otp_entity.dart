class VerifyOtpEntity {
  final String message;
  final String? token;
  final bool emailVerified;
  final User user;

  const VerifyOtpEntity({
    required this.message,
    required this.token,
    required this.emailVerified,
    required this.user,
  });
}

class User {
  final int id;
  final String email;
  final String role;

  const User({
    required this.id,
    required this.email,
    required this.role,
  });
}
