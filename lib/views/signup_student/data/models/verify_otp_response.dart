import 'package:job_portal/views/signup_student/domain/entities/verify_otp_entity.dart';

class VerifyOtpResponse extends VerifyOtpEntity {
  const VerifyOtpResponse({
    required super.message,
    required super.token,
    required super.emailVerified,
    required super.user,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      message: json['message'] ?? '',
      token: json['token'],
      emailVerified: json['emailVerified'] ?? false,
      user: User(
        id: json['user']?['id'] ?? 0,
        email: json['user']?['email'] ?? '',
        role: json['user']?['role'] ?? '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'emailVerified': emailVerified,
      'user': {
        'id': user.id,
        'email': user.email,
        'role': user.role,
      },
    };
  }
}
