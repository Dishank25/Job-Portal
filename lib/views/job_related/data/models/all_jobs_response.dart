import 'package:job_portal/views/job_related/domain/entities/all_jobs_entity.dart';

class AllJobsResponse {
  final List<JobModel> data;

  AllJobsResponse({required this.data});

  factory AllJobsResponse.fromJson(Map<String, dynamic> json) {
    return AllJobsResponse(
      data: List<JobModel>.from(
          json['data'].map((item) => JobModel.fromJson(item))),
    );
  }
}

class JobModel extends AllJobsEntity {
  JobModel({
    required super.job_id, //
    required super.company_recruiter_profile_id,
    required super.jobProfile, //could be jobRole
    required super.company_name, //
    required super.logo_url, //
    required super.hiringStatus,
    required super.postedDaysAgo,
    required super.matchPercentage, //
    required super.experience, //
    required super.salary, //
    required super.cityChoice,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      job_id: json['job_id'] ?? 0,
      company_recruiter_profile_id: json['company_recruiter_profile_id'] ?? 0,
      jobProfile: json['jobRole'] ?? '', //changed for getting data from backend
      company_name: json['company_name'] ?? "origincore",
      logo_url: json['logo_url'],
      hiringStatus: json['hiringStatus'] ?? 'open default',
      // postedDaysAgo: json['postedDaysAgo'] ?? 0,
      postedDaysAgo: json['postedDaysAgo'] is String
          ? json['postedDaysAgo'] as String
          : json['postedDaysAgo'].toString(),
      matchPercentage: json['matchPercentage'] ?? 0,
      experience: json['experience'] ?? "",
      salary: json['salary'] ?? 0,
      cityChoice: json['cityChoice'] ?? 'no city given',
    );
  }
}

// class AllJobsResponse extends AllJobsEntity {
//   const AllJobsResponse({
//     required super.job_id,
//     required super.company_recruiter_profile_id,
//     required super.opportunity_type,
//     required super.skillsRequired,
//     required super.skill_required_note,
//     required super.job_type,
//     super.job_time,
//     super.days_in_office,
//     super.cityChoice,
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
//     super.internship_from_date,
//     super.internship_to_date,
//     required super.is_custom_internship_date,
//     required super.college_name,
//     required super.course,
//     required super.alternate_phone_number,
//     required super.views,
//     super.user_id,
//     required super.jobProfile,
//     required super.company_name,
//     required super.logo_url,
//     required super.hiringStatus,
//     required super.postedDaysAgo,
//     required super.matchPercentage,
//     required super.experience,
//     required super.salary,
//   });

//   factory AllJobsResponse.fromJson(Map<String, dynamic> json) {
//     return AllJobsResponse(
//       job_id: json['job_id'],
//       company_recruiter_profile_id: json['company_recruiter_profile_id'],
//       opportunity_type: json['opportunity_type'],
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
//       stipend_type: json['stipend_type'],
//       stipend_min: json['stipend_min'],
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
//       views: json['views'],
//       user_id: json['user_id'],
//       jobProfile: json['jobProfile'],
//       company_name: json['company_name'],
//       logo_url: json['logo_url'],
//       hiringStatus: json['hiringStatus'],
//       postedDaysAgo: json['postedDaysAgo'],
//       matchPercentage: json['matchPercentage'],
//       experience: json['experience'],
//       salary: json['salary'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'job_id': job_id,
//       'company_recruiter_profile_id': company_recruiter_profile_id,
//       'opportunity_type': opportunity_type,
//       'skillsRequired': skillsRequired,
//       'skill_required_note': skill_required_note,
//       'job_type': job_type,
//       'job_time': job_time,
//       'days_in_office': days_in_office,
//       'cityChoice': cityChoice,
//       'number_of_openings': number_of_openings,
//       'job_description': job_description,
//       'candidate_preferences': candidate_preferences,
//       'women_preferred': women_preferred,
//       'stipend_type': stipend_type,
//       'stipend_min': stipend_min,
//       'stipend_max': stipend_max,
//       'incentive_per_year': incentive_per_year,
//       'perks': perks,
//       'screening_questions': screening_questions,
//       'phone_contact': phone_contact,
//       'internshipDuration': internshipDuration,
//       'internship_start_date': internship_start_date,
//       'internship_from_date': internship_from_date,
//       'internship_to_date': internship_to_date,
//       'is_custom_internship_date': is_custom_internship_date,
//       'college_name': college_name,
//       'course': course,
//       'alternate_phone_number': alternate_phone_number,
//       'views': views,
//       'user_id': user_id,
//       'jobProfile': jobProfile,
//       'company_name': company_name,
//       'logo_url': logo_url,
//       'hiringStatus': hiringStatus,
//       'postedDaysAgo': postedDaysAgo,
//       'matchPercentage': matchPercentage,
//       'experience': experience,
//       'salary': salary,
//     };
//   }
// }
