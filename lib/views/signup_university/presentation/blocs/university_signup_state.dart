import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/courses_response.dart';

@immutable
abstract class UniversitySignupState extends Equatable {
  const UniversitySignupState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UniversitySignupInitial extends UniversitySignupState {
  const UniversitySignupInitial();
}

class CoursesLoading extends UniversitySignupState {
  const CoursesLoading();
}

class CoursesLoaded extends UniversitySignupState {
  // change the returns data type
  final CoursesListResponse coursesListResponse;

  const CoursesLoaded(this.coursesListResponse);
}

class CoursesError extends UniversitySignupState {
  const CoursesError();
}
