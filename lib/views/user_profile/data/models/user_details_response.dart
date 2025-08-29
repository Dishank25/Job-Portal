import 'package:job_portal/views/user_profile/domain/entities/user_details_entity.dart';

class UserDetailModel extends UserDetailEntity {
  UserDetailModel({
    required super.id,
    required super.user_id,
    required super.first_name,
    required super.last_name,
    required super.email,
    required super.phone,
    required super.dob,
    required super.aadhaarNumber,
    required super.aadhaarCardFile,
    required super.isAadhaarVerified,
    required super.currentLocation,
    required super.gender,
    required super.user_type,
    super.standard,
    super.course,
    super.specialization,
    super.college,
    super.start_year,
    super.end_year,
    required super.jobLocation,
    required super.salary_details,
    required super.currently_looking_for,
    required super.work_mode,
    required super.about_us,
    super.career_objective,
    required super.resume,
    required super.language,
    required super.is_email_verified,
    required super.is_phone_verified,
    required super.is_gst_verified,
    super.user_profile_pic,
    required super.terms_and_condition,
    required super.created_at,
    required super.updated_at,
    required super.experiences,
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    final user = json['userDetail'];
    return UserDetailModel(
      id: user['id'],
      user_id: user['user_id'],
      first_name: user['first_name'] ?? '',
      last_name: user['last_name'] ?? '',
      email: user['email'],
      phone: user['phone'],
      dob: user['dob'],
      aadhaarNumber: user['aadhaar_number'], // Now matches JSON
      aadhaarCardFile: user['aadhaar_card_file'], // Now matches JSON
      isAadhaarVerified: user['is_aadhaar_verified'] ?? false,
      currentLocation: user['currentLocation'], // Now matches JSON
      gender: user['gender'],
      user_type: user['user_type'],
      standard: user['Standard'],
      course: user['course'],
      specialization: user['specialization'],
      college: user['college'],
      start_year: user['start_year'],
      end_year: user['end_year'],
      jobLocation: user['jobLocation'], // Now matches JSON
      salary_details: user['salary_details'],
      currently_looking_for: user['currently_looking_for'],
      work_mode: user['work_mode'],
      about_us: user['about_us'],
      career_objective: user['career_objective'],
      resume: user['resume'],
      language: user['language'],
      is_email_verified: user['is_email_verified'] ?? false,
      is_phone_verified: user['is_phone_verified'] ?? false,
      is_gst_verified: user['is_gst_verified'] ?? false,
      user_profile_pic: user['user_profile_pic'], // Still has mismatch!
      terms_and_condition: user['terms_and_condition'] ?? false,
      created_at: DateTime.parse(user['created_at']),
      updated_at: DateTime.parse(user['updated_at']),
      experiences: (user['experiences'] as List<dynamic>?)
              ?.map((e) => UserExperienceModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class UserExperienceModel extends UserExperienceEntity {
  UserExperienceModel({
    required super.id,
    required super.user_detail_id,
    super.company_recruiter_profile_id,
    super.start_date,
    super.end_date,
    super.totalExperience,
    super.current_job_role,
    super.current_company,
    super.status,
    required super.created_at,
    required super.updated_at,
  });

  factory UserExperienceModel.fromJson(Map<String, dynamic> json) {
    return UserExperienceModel(
      id: json['id'],
      user_detail_id: json['user_detail_id'],
      company_recruiter_profile_id: json['company_recruiter_profile_id'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      totalExperience: json['totalExperience'],
      current_job_role: json['current_job_role'],
      current_company: json['current_company'],
      status: json['status'],
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at']),
    );
  }
}
