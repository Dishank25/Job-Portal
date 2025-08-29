import 'package:job_portal/views/job_related/domain/entities/job_details_entity.dart';

// class JobDetailsResponseModel extends JobDetailsEntity {
//   JobDetailsResponseModel({
//     required super.job_id,
//     required super.company_recruiter_profile_id,
//     required super.opportunity_type,
//     required super.jobProfile,
//     required super.skillsRequired,
//     required super.skill_required_note,
//     required super.job_type,
//     required super.job_time,
//     required super.days_in_office,
//     required super.cityChoice,
//     required super.number_of_openings,
//     required super.job_description,
//     required super.candidate_preferences,
//     required super.women_preferred,
//     required super.stipend_type,
//     required super.stipend_min,
//     required super.stipend_max,
//     required super.incentive_per_year,
//     required super.perks,
//     required super.screening_questions,
//     required super.phone_contact,
//     required super.internshipDuration,
//     required super.internship_start_date,
//     required super.internship_from_date,
//     required super.internship_to_date,
//     required super.is_custom_internship_date,
//     required super.college_name,
//     required super.course,
//     required super.alternate_phone_number,
//     required super.views,
//     required super.created_at,
//     required super.updated_at,
//     required super.user_id,
//     required super.companyRecruiterProfile,
//   });

//   factory JobDetailsResponseModel.fromJson(Map<String, dynamic> json) {
//     return JobDetailsResponseModel(
//       job_id: json['job_id'],
//       company_recruiter_profile_id: json['company_recruiter_profile_id'],
//       opportunity_type: json['opportunity_type'],
//       jobProfile: json['jobProfile'],
//       skillsRequired: json['skillsRequired'],
//       skill_required_note: json['skill_required_note'],
//       job_type: json['job_type'],
//       job_time: json['job_time'],
//       days_in_office: json['days_in_office'],
//       cityChoice: json['cityChoice'],
//       number_of_openings: json['number_of_openings'],
//       job_description: json['job_description'],
//       candidate_preferences: json['candidate_preferences'],
//       women_preferred: json['women_preferred'],
//       stipend_type: json['stipend_type'] ?? 0,
//       stipend_min: json['stipend_min'] ?? 0,
//       stipend_max: json['stipend_max'],
//       incentive_per_year: json['incentive_per_year'],
//       perks: json['perks'],
//       screening_questions: json['screening_questions'],
//       phone_contact: json['phone_contact'],
//       internshipDuration: json['internshipDuration'],
//       internship_start_date: json['internship_start_date'],
//       internship_from_date: json['internship_from_date'],
//       internship_to_date: json['internship_to_date'],
//       is_custom_internship_date: json['is_custom_internship_date'],
//       college_name: json['college_name'],
//       course: json['course'],
//       alternate_phone_number: json['alternate_phone_number'],
//       views: json['views'] ?? 0,
//       created_at: DateTime.parse(json['created_at']),
//       updated_at: DateTime.parse(json['updated_at']),
//       user_id: json['user_id'] ?? 0,
//       companyRecruiterProfile: CompanyRecruiterProfileModel.fromJson(
//           json['CompanyRecruiterProfile']),
//     );
//   }
// }

// class CompanyRecruiterProfileModel extends CompanyRecruiterProfileEntity {
//   CompanyRecruiterProfileModel({
//     required super.company_name,
//     required super.logo_url,
//     required super.about,
//   });

//   factory CompanyRecruiterProfileModel.fromJson(Map<String, dynamic> json) {
//     return CompanyRecruiterProfileModel(
//       company_name: json['company_name'],
//       logo_url: json['logo_url'],
//       about: json['about'],
//     );
//   }
// }

class JobDetailsResponseModel extends JobDetailsEntity {
  JobDetailsResponseModel.fromJson(Map<String, dynamic> json)
      : super(
          job_id: json['job_id'],
          opportunity_type: json['opportunity_type'],
          job_type: json['job_type'],
          jobProfile: json['jobProfile'],
          job_description: json['job_description'],
          job_time: json['job_time'],
          days_in_office: json['days_in_office'],
          cityChoice: json['cityChoice'],
          skillsRequired: List<String>.from(json['skillsRequired'] ?? []),
          skill_required_note: json['skill_required_note'],
          candidate_preferences: json['candidate_preferences'],
          women_preferred: json['women_preferred'],
          company_name: json['company_name'],
          logo_url: json['logo_url'],
          aboutCompany: json['aboutCompany'],
          companyIndustry: json['companyIndustry'],
          companyLocation: json['companyLocation'],
          recruiter_name: json['recruiter_name'],
          recruiter_email: json['recruiter_email'],
          recruiter_phone: json['recruiter_phone'],
          recruiterDesignation: json['recruiterDesignation'],
          recruiterprofile_pic: json['recruiterprofile_pic'],
          is_email_verified: json['is_email_verified'],
          isphone_verified: json['isphone_verified'],
          is_gst_verified: json['is_gst_verified'],
          number_of_openings: json['number_of_openings'],
          hiringStatus: json['hiringStatus'],
          hiring_preferences: json['hiring_preferences'],
          languages_known: json['languages_known'],
          salary: json['salary'],
          stipend_type: json['stipend_type'],
          incentive_per_year: json['incentive_per_year'],
          perks: List<String>.from(json['perks'] ?? []),
          internshipDuration: json['internshipDuration'],
          internship_start_date: json['internship_start_date'],
          internship_from_date: json['internship_from_date'],
          internship_to_date: json['internship_to_date'],
          is_custom_internship_date: json['is_custom_internship_date'],
          college_name: json['college_name'],
          course: json['course'],
          phone_contact: json['phone_contact'],
          alternate_phone_number: json['alternate_phone_number'],
          screening_questions:
              List<String>.from(json['screening_questions'] ?? []),
          numberOfApplicants: json['numberOfApplicants'],
          postedDaysAgo: json['postedDaysAgo'],
        );
}
