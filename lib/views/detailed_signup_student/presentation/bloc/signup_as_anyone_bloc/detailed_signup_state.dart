import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/basic_user_data_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/colleges_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/courses_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/job_roles_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/specialization_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/submit_detailed_user_profile.dart';

@immutable
abstract class DetailedSignupState extends Equatable {
  const DetailedSignupState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DetailedSignupInitial extends DetailedSignupState {
  const DetailedSignupInitial();
}

class DetailedSignupGetBasicUserInfoLoading extends DetailedSignupState {
  const DetailedSignupGetBasicUserInfoLoading();
}

class DetailedSignupGetBasicUserInfoLoaded extends DetailedSignupState {
  final BasicUserInfoResponse basicUserInfoResponse;
  final LocationsListResponse locations;

  const DetailedSignupGetBasicUserInfoLoaded(
      this.basicUserInfoResponse, this.locations);
}

class DetailedSignupGetBasicUserInfoError extends DetailedSignupState {
  const DetailedSignupGetBasicUserInfoError();
}

class DetailedSignupGetCollegeDetailsLoading extends DetailedSignupState {
  const DetailedSignupGetCollegeDetailsLoading();
}

class DetailedSignupGetCollegeDetailsLoaded extends DetailedSignupState {
  final CollegesListResponse collegesListResponse;
  final SpecializationListResponse specializationListResponse;
  final CoursesListResponse coursesListResponse;
  final JobrolesListResponse jobrolesListResponse;

  const DetailedSignupGetCollegeDetailsLoaded(
      this.collegesListResponse,
      this.specializationListResponse,
      this.coursesListResponse,
      this.jobrolesListResponse);
  @override
  List<Object?> get props => [
        collegesListResponse,
        specializationListResponse,
        coursesListResponse,
        jobrolesListResponse
      ];
}

class DetailedSignupGetCollegeDetailsError extends DetailedSignupState {
  const DetailedSignupGetCollegeDetailsError();
}

class DetailedSingupSubmitUserDetailsLoading extends DetailedSignupState {
  const DetailedSingupSubmitUserDetailsLoading();
}

class DetailedSingupSubmitUserDetailsLoaded extends DetailedSignupState {
  final SubmitDetailedUserProfile submitDetailedUserProfile;

  const DetailedSingupSubmitUserDetailsLoaded(this.submitDetailedUserProfile);
}

class DetailedSingupSubmitUserDetailsError extends DetailedSignupState {
  const DetailedSingupSubmitUserDetailsError();
}

// class DetailedSignupGetCollegesLoading extends DetailedSignupState {
//   const DetailedSignupGetCollegesLoading();
// }
// class DetailedSignupGetCollegesLoaded extends DetailedSignupState {
//   final CollegesListResponse collegesListResponse;
//   const DetailedSignupGetCollegesLoaded(this.collegesListResponse);
// }
// class DetailedSignupGetCollegesError extends DetailedSignupState {
//   const DetailedSignupGetCollegesError();
// }
// class DetailedSignupGetSpecializationLoading extends DetailedSignupState {
//   const DetailedSignupGetSpecializationLoading();
// }
// class DetailedSignupGetSpecializationLoaded extends DetailedSignupState {
//   final SpecializationListResponse specializationListResponse;
//   const DetailedSignupGetSpecializationLoaded(this.specializationListResponse);
// }
// class DetailedSignupGetSpecializationError extends DetailedSignupState {
//   const DetailedSignupGetSpecializationError();
// }
// class DetailedSignupGetCoursesLoading extends DetailedSignupState {
//   const DetailedSignupGetCoursesLoading();
// }
// class DetailedSignupGetCoursesLoaded extends DetailedSignupState {
//   final CoursesListResponse coursesListResponse;
//   const DetailedSignupGetCoursesLoaded(this.coursesListResponse);
// }
// class DetailedSignupGetCoursesError extends DetailedSignupState {
//   const DetailedSignupGetCoursesError();
// }
// class DetailedSignupJobrolesLoading extends DetailedSignupState {
//   const DetailedSignupJobrolesLoading();
// }
// class DetailedSignupJobrolesLoaded extends DetailedSignupState {
//   final JobrolesListResponse jobrolesListResponse;
//   const DetailedSignupJobrolesLoaded(this.jobrolesListResponse);
// }
// class DetailedSignupJobrolesError extends DetailedSignupState {
//   const DetailedSignupJobrolesError();
// }
