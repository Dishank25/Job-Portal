class AllJobApplicationsEntity {
  final List<JobApplicationEntity> applications;

  AllJobApplicationsEntity({required this.applications});
}

class JobApplicationEntity {
  final int application_id;
  final String company_name;
  final String jobProfile;
  final String skillsRequired;
  final int? number_of_openings;
  final String status;
  final int applicantCount;
  final DateTime applyTime;
  final ApplicationDetailsEntity applicationDetails;

  JobApplicationEntity({
    required this.application_id,
    required this.company_name,
    required this.jobProfile,
    required this.skillsRequired,
    required this.number_of_openings,
    required this.status,
    required this.applicantCount,
    required this.applyTime,
    required this.applicationDetails,
  });
}

class ApplicationDetailsEntity {
  final String why_should_we_hire_you;
  final String confirm_availability;
  final String project;
  final String github_link;
  final String portfolio_link;
  final String education;
  final String name;
  final String location;
  final String experience;
  final String skills;
  final String language;
  final String resume;
  final String email;
  final String phoneNumber;

  ApplicationDetailsEntity({
    required this.why_should_we_hire_you,
    required this.confirm_availability,
    required this.project,
    required this.github_link,
    required this.portfolio_link,
    required this.education,
    required this.name,
    required this.location,
    required this.experience,
    required this.skills,
    required this.language,
    required this.resume,
    required this.email,
    required this.phoneNumber,
  });
}
