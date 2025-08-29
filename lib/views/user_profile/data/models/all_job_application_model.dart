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
    required int application_id,
    required String company_name,
    required String jobProfile,
    required String skillsRequired,
    required int? number_of_openings,
    required String status,
    required int applicantCount,
    required DateTime applyTime,
    required ApplicationDetailsModel applicationDetails,
  }) : super(
          application_id: application_id,
          company_name: company_name,
          jobProfile: jobProfile,
          skillsRequired: skillsRequired,
          number_of_openings: number_of_openings,
          status: status,
          applicantCount: applicantCount,
          applyTime: applyTime,
          applicationDetails: applicationDetails,
        );

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
    required String why_should_we_hire_you,
    required String confirm_availability,
    required String project,
    required String github_link,
    required String portfolio_link,
    required String education,
    required String name,
    required String location,
    required String experience,
    required String skills,
    required String language,
    required String resume,
    required String email,
    required String phoneNumber,
  }) : super(
          why_should_we_hire_you: why_should_we_hire_you,
          confirm_availability: confirm_availability,
          project: project,
          github_link: github_link,
          portfolio_link: portfolio_link,
          education: education,
          name: name,
          location: location,
          experience: experience,
          skills: skills,
          language: language,
          resume: resume,
          email: email,
          phoneNumber: phoneNumber,
        );

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
