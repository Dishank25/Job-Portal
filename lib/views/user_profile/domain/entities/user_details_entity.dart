class UserDetailEntity {
  final int id;
  final int user_id;
  final String first_name;
  final String last_name;
  final String email;
  final String phone;
  final String dob;
  final String? aadhaarNumber;
  final String? aadhaarCardFile;
  final bool isAadhaarVerified;
  final String? currentLocation;
  final String gender;
  final String user_type;
  final String? standard;
  final String? course;
  final String? specialization;
  final String? college;
  final String? start_year;
  final String? end_year;
  final String? jobLocation;
  final String? salary_details;
  final String? currently_looking_for;
  final String? work_mode;
  final String? about_us;
  final String? career_objective;
  final String? resume;
  final String? language;
  final bool is_email_verified;
  final bool isphone_verified;
  final bool is_gst_verified;
  final String? userprofile_pic;
  final bool terms_and_condition;
  final DateTime created_at;
  final DateTime updated_at;
  final List<UserExperienceEntity> experiences;

  UserDetailEntity({
    required this.id,
    required this.user_id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.aadhaarNumber,
    required this.aadhaarCardFile,
    required this.isAadhaarVerified,
    required this.currentLocation,
    required this.gender,
    required this.user_type,
    this.standard,
    this.course,
    this.specialization,
    this.college,
    this.start_year,
    this.end_year,
    required this.jobLocation,
    required this.salary_details,
    required this.currently_looking_for,
    required this.work_mode,
    required this.about_us,
    this.career_objective,
    required this.resume,
    required this.language,
    required this.is_email_verified,
    required this.isphone_verified,
    required this.is_gst_verified,
    this.userprofile_pic,
    required this.terms_and_condition,
    required this.created_at,
    required this.updated_at,
    required this.experiences,
  });
}

class UserExperienceEntity {
  final int id;
  final int user_detail_id;
  final int? company_recruiter_profile_id;
  final String? start_date;
  final String? end_date;
  final String? totalExperience;
  final String? current_job_role;
  final String? current_company;
  final String? status;
  final DateTime created_at;
  final DateTime updated_at;

  UserExperienceEntity({
    required this.id,
    required this.user_detail_id,
    this.company_recruiter_profile_id,
    this.start_date,
    this.end_date,
    this.totalExperience,
    this.current_job_role,
    this.current_company,
    this.status,
    required this.created_at,
    required this.updated_at,
  });
}
