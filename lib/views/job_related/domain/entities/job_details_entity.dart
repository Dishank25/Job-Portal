// class JobDetailsEntity {
//   final int job_id;
//   final int company_recruiter_profile_id;
//   final String opportunity_type;
//   final String jobProfile;
//   final String skillsRequired;
//   final String skill_required_note;
//   final String job_type;
//   final String? job_time;
//   final int? days_in_office;
//   final String? cityChoice;
//   final int number_of_openings;
//   final String job_description;
//   final String candidate_preferences;
//   final bool women_preferred;
//   final String stipend_type;
//   final int? stipend_min;
//   final int? stipend_max;
//   final String incentive_per_year;
//   final String perks;
//   final String screening_questions;
//   final String phone_contact;
//   final String internshipDuration;
//   final String internship_start_date;
//   final String? internship_from_date;
//   final String? internship_to_date;
//   final bool is_custom_internship_date;
//   final String college_name;
//   final String course;
//   final String? alternate_phone_number;
//   final int? views;
//   final DateTime created_at;
//   final DateTime updated_at;
//   final int? user_id;
//   final CompanyRecruiterProfileEntity companyRecruiterProfile;

//   const JobDetailsEntity({
//     required this.job_id,
//     required this.company_recruiter_profile_id,
//     required this.opportunity_type,
//     required this.jobProfile,
//     required this.skillsRequired,
//     required this.skill_required_note,
//     required this.job_type,
//     required this.job_time,
//     required this.days_in_office,
//     required this.cityChoice,
//     required this.number_of_openings,
//     required this.job_description,
//     required this.candidate_preferences,
//     required this.women_preferred,
//     required this.stipend_type,
//     required this.stipend_min,
//     required this.stipend_max,
//     required this.incentive_per_year,
//     required this.perks,
//     required this.screening_questions,
//     required this.phone_contact,
//     required this.internshipDuration,
//     required this.internship_start_date,
//     required this.internship_from_date,
//     required this.internship_to_date,
//     required this.is_custom_internship_date,
//     required this.college_name,
//     required this.course,
//     required this.alternate_phone_number,
//     required this.views,
//     required this.created_at,
//     required this.updated_at,
//     required this.user_id,
//     required this.companyRecruiterProfile,
//   });
// }

// class CompanyRecruiterProfileEntity {
//   final String company_name;
//   final String logo_url;
//   final String about;

//   const CompanyRecruiterProfileEntity({
//     required this.company_name,
//     required this.logo_url,
//     required this.about,
//   });
// }

class JobDetailsEntity {
  final int job_id;
  final String opportunity_type;
  final String? job_type;
  final String jobProfile;
  final String? job_description;
  final String? job_time;
  final int? days_in_office;
  final String? cityChoice;
  final List<String> skillsRequired;
  final String? skill_required_note;
  final String? candidate_preferences;
  final bool? women_preferred;
  final String company_name;
  final String logo_url;
  final String aboutCompany;
  final String companyIndustry;
  final String companyLocation;
  final String recruiter_name;
  final String recruiter_email;
  final String recruiter_phone;
  final String recruiterDesignation;
  final String recruiterprofile_pic;
  final bool is_email_verified;
  final bool is_phone_verified;
  final bool is_gst_verified;
  final int? number_of_openings;
  final String hiringStatus;
  final String hiring_preferences;
  final String languages_known;
  final String salary;
  final String stipend_type;
  final String incentive_per_year;
  final List<String> perks;
  final String internshipDuration;
  final String internship_start_date;
  final String internship_from_date;
  final String internship_to_date;
  final bool is_custom_internship_date;
  final String? college_name;
  final String? course;
  final String? phone_contact;
  final String? alternate_phone_number;
  final List<String> screening_questions;
  final int numberOfApplicants;
  final String postedDaysAgo;

  JobDetailsEntity({
    required this.job_id,
    required this.opportunity_type,
    required this.job_type,
    required this.jobProfile,
    required this.job_description,
    required this.job_time,
    required this.days_in_office,
    required this.cityChoice,
    required this.skillsRequired,
    required this.skill_required_note,
    required this.candidate_preferences,
    required this.women_preferred,
    required this.company_name,
    required this.logo_url,
    required this.aboutCompany,
    required this.companyIndustry,
    required this.companyLocation,
    required this.recruiter_name,
    required this.recruiter_email,
    required this.recruiter_phone,
    required this.recruiterDesignation,
    required this.recruiterprofile_pic,
    required this.is_email_verified,
    required this.is_phone_verified,
    required this.is_gst_verified,
    required this.number_of_openings,
    required this.hiringStatus,
    required this.hiring_preferences,
    required this.languages_known,
    required this.salary,
    required this.stipend_type,
    required this.incentive_per_year,
    required this.perks,
    required this.internshipDuration,
    required this.internship_start_date,
    required this.internship_from_date,
    required this.internship_to_date,
    required this.is_custom_internship_date,
    required this.college_name,
    required this.course,
    required this.phone_contact,
    required this.alternate_phone_number,
    required this.screening_questions,
    required this.numberOfApplicants,
    required this.postedDaysAgo,
  });
}
