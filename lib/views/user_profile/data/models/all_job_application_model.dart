import 'package:job_portal/views/user_profile/domain/entities/all_job_applications_entity.dart';

class AllJobApplicationsModel extends AllJobApplicationsEntity {
  AllJobApplicationsModel({required List<JobApplicationModel> applications})
      : super(applications: applications);

  factory AllJobApplicationsModel.fromJson(Map<String, dynamic> json) {
    return AllJobApplicationsModel(
      applications: (json['applications'] as List)
          .map((e) => JobApplicationModel.fromJson(e))
          .toList(),
    );
  }
}

class JobApplicationModel extends JobApplicationEntity {
  JobApplicationModel({
    required super.application_id,
    required super.company_name,
    required super.jobProfile,
    required super.skillsRequired,
    required super.number_of_openings,
    required super.status,
    required super.applicantCount,
    required super.applyTime,
    required ApplicationDetailsModel super.applicationDetails,
  });

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) {
    return JobApplicationModel(
      application_id: json['application_id'],
      company_name: json['company_name'],
      jobProfile: json['jobProfile'] ?? '',
      skillsRequired: json['skillsRequired'] ?? '',
      number_of_openings: json['number_of_openings'],
      status: json['status'],
      applicantCount: json['applicantCount'],
      applyTime: DateTime.parse(json['applyTime']),
      applicationDetails:
          ApplicationDetailsModel.fromJson(json['applicationDetails']),
    );
  }
}

class ApplicationDetailsModel extends ApplicationDetailsEntity {
  ApplicationDetailsModel({
    required super.why_should_we_hire_you,
    required super.confirm_availability,
    required super.project,
    required super.github_link,
    required super.portfolio_link,
    required super.education,
    required super.name,
    required super.location,
    required super.experience,
    required super.skills,
    required super.language,
    required super.resume,
    required super.email,
    required super.phoneNumber,
  });

  factory ApplicationDetailsModel.fromJson(Map<String, dynamic> json) {
    return ApplicationDetailsModel(
      why_should_we_hire_you: json['why_should_we_hire_you'],
      confirm_availability: json['confirm_availability'],
      project: json['project'],
      github_link: json['github_link'],
      portfolio_link: json['portfolio_link'],
      education: json['education'],
      name: json['name'],
      location: json['location'],
      experience: json['experience'],
      skills: json['skills'],
      language: json['language'],
      resume: json['resume'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
