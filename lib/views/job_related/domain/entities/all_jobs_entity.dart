class AllJobsEntity {
  final int job_id;
  final int company_recruiter_profile_id;
  final String jobProfile;
  final String company_name;
  final String? logo_url;
  final String hiringStatus;
  final String postedDaysAgo;
  final int matchPercentage;
  final String experience;
  final String salary;
  final String? cityChoice;

  const AllJobsEntity({
    required this.job_id,
    required this.company_recruiter_profile_id,
    required this.jobProfile,
    required this.company_name,
    required this.logo_url,
    required this.hiringStatus,
    required this.postedDaysAgo,
    required this.matchPercentage,
    required this.experience,
    required this.salary,
    required this.cityChoice,
  });
}

// "data": [
//         {
//             "job_id": 2,
//             "company_recruiter_profile_id": 1,
//             "opportunity_type": "internship",
//             "skillsRequired": "react.js, Node.js",
//             "skill_required_note": "1 year experience",
//             "job_type": "partime",
//             "job_time": null,
//             "days_in_office": null,
//             "cityChoice": null,
//             "number_of_openings": 2,
//             "job_description": "Exciting internship opportunity",
//             "candidate_preferences": "Motivated learners",
//             "women_preferred": false,
//             "stipend_type": "Paid",
//             "stipend_min": 1000,
//             "stipend_max": 2000,
//             "incentive_per_year": "500",
//             "perks": "Flexible hours",
//             "screening_questions": "Why do you want this internship?",
//             "phone_contact": "1234567890",
//             "internshipDuration": "3 months",
//             "internship_start_date": "2024-07-01",
//             "internship_from_date": null,
//             "internship_to_date": null,
//             "is_custom_internship_date": false,
//             "college_name": "ABC University",
//             "course": "B.Tech",
//             "alternate_phone_number": "",
//             "views": 0,
//             "user_id": null,
//             "jobProfile": "Software Developer",
//             "company_name": "Acme Corp",
//             "logo_url": "https://encrypted-tbn0.gstatic.com/image.jpg",
//             "hiringStatus": "Actively Hiring",
//             "postedDaysAgo": "56",
//             "matchPercentage": 0,
//             "experience": "Motivated learners",
//             "salary": "1000 - 2000"
//         },

// class AllJobsEntity {
//   final int job_id;
//   final int company_recruiter_profile_id;
//   final String opportunity_type;
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
//   final int stipend_min;
//   final int stipend_max;
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
//   final String alternate_phone_number;
//   final int views;
//   final int? user_id;
//   final String jobProfile;
//   final String company_name;
//   final String logo_url;
//   final String hiringStatus;
//   final String postedDaysAgo;
//   final int matchPercentage;
//   final String experience;
//   final String salary;

//   const AllJobsEntity({
//     required this.job_id,
//     required this.company_recruiter_profile_id,
//     required this.opportunity_type,
//     required this.skillsRequired,
//     required this.skill_required_note,
//     required this.job_type,
//     this.job_time,
//     this.days_in_office,
//     this.cityChoice,
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
//     this.internship_from_date,
//     this.internship_to_date,
//     required this.is_custom_internship_date,
//     required this.college_name,
//     required this.course,
//     required this.alternate_phone_number,
//     required this.views,
//     this.user_id,
//     required this.jobProfile,
//     required this.company_name,
//     required this.logo_url,
//     required this.hiringStatus,
//     required this.postedDaysAgo,
//     required this.matchPercentage,
//     required this.experience,
//     required this.salary,
//   });
// }
