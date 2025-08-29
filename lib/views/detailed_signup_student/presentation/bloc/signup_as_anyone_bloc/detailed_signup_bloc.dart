import 'dart:developer' as developer show log;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_portal/views/detailed_signup_student/domain/usecases/detailed_signup_usecase.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/signup_as_anyone_bloc/detailed_signup_event.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/signup_as_anyone_bloc/detailed_signup_state.dart';

class DetailedSignupBloc
    extends Bloc<DetailedSignupEvent, DetailedSignupState> {
  final DetailedSignupUsecase _detailedSignupUsecase;

  DetailedSignupBloc(this._detailedSignupUsecase)
      : super(const DetailedSignupInitial()) {
    on<DetailedSignupGetBasicUserInfo>(_onGetBasicUserInfo);
    on<DetailedSignupGetCollegeDetails>(_onGetCollegeDetails);
    on<DetailedSingupSubmitUserDetails>(_onSubmitUserDetails);
  }

  Future<void> _onGetBasicUserInfo(DetailedSignupGetBasicUserInfo event,
      Emitter<DetailedSignupState> emit) async {
    try {
      emit(const DetailedSignupGetBasicUserInfoLoading());
      final responseUserInfo =
          await _detailedSignupUsecase.getBasicUserInfo(event.emailMap);
      final responseLocations = await _detailedSignupUsecase.getLocations();
      developer.log(
          'Response of get basic user info : ${responseUserInfo.data!.message}');
      emit(DetailedSignupGetBasicUserInfoLoaded(
          responseUserInfo.data!, responseLocations.data!));
    } catch (e) {
      developer.log('Ending up in error get basic user info : $e');
      emit(const DetailedSignupGetBasicUserInfoError());
    }
  }

  Future<void> _onGetCollegeDetails(DetailedSignupGetCollegeDetails event,
      Emitter<DetailedSignupState> emit) async {
    try {
      emit(const DetailedSignupGetCollegeDetailsLoading());

      final colleges = await _detailedSignupUsecase.getColleges(event.emailMap);
      developer.log('Colleges type: ${colleges.runtimeType}');
      developer.log('Colleges type cioebfie : ${colleges.data}');

      final specializations = await _detailedSignupUsecase.getSpecialization();
      developer.log('Specializations type: ${specializations.runtimeType}');

      final courses = await _detailedSignupUsecase.getCourses();
      developer.log('Courses type: ${courses.runtimeType}');

      final jobroles = await _detailedSignupUsecase.getJobroles();
      developer.log('Jobroles type: ${jobroles.runtimeType}');

      // Temporary: Just emit the data without type checking to see if it works
      emit(DetailedSignupGetCollegeDetailsLoaded(
          colleges.data!, // Remove the type check temporarily
          specializations.data!,
          courses.data!,
          jobroles.data!));
    } catch (e) {
      developer.log('Error in _onGetCollegeDetails: $e');
      emit(const DetailedSignupGetCollegeDetailsError());
    }
  }

  Future<void> _onSubmitUserDetails(DetailedSingupSubmitUserDetails event,
      Emitter<DetailedSignupState> emit) async {
    try {
      emit(const DetailedSingupSubmitUserDetailsLoading());
      final response =
          await _detailedSignupUsecase.submitDetailedUserProfile(event.params);
      emit(DetailedSingupSubmitUserDetailsLoaded(response.data!));
    } catch (e) {
      emit(const DetailedSingupSubmitUserDetailsError());
    }
  }
}

// Future<void> _onGetColleges(DetailedSignupGetColleges event,
  //     Emitter<DetailedSignupState> emit) async {
  //   try {
  //     emit(const DetailedSignupGetCollegesLoading());
  //     final response = await _detailedSignupUsecase.getColleges(event.emailMap);
  //     developer.log('Response of get colleges : ${response.data!}');
  //     emit(DetailedSignupGetCollegesLoaded(response.data!));
  //   } catch (e) {
  //     developer.log('Ending up in error of get colleges : $e');
  //     emit(const DetailedSignupGetCollegesError());
  //   }
  // }
  // Future<void> _onGetSpecialization(DetailedSignupGetSpecialization event,
  //     Emitter<DetailedSignupState> emit) async {
  //   try {
  //     emit(const DetailedSignupGetSpecializationLoading());
  //     final response = await _detailedSignupUsecase.getSpecialization();
  //     developer.log('Response of get specializations : ${response.data!}');
  //     emit(DetailedSignupGetSpecializationLoaded(response.data!));
  //   } catch (e) {
  //     developer.log('Ending up in error of get specializations : $e');
  //     emit(const DetailedSignupGetSpecializationError());
  //   }
  // }
  // Future<void> _onGetCourses(
  //     DetailedSignupGetCourses event, Emitter<DetailedSignupState> emit) async {
  //   try {
  //     emit(const DetailedSignupGetCoursesLoading());
  //     final response = await _detailedSignupUsecase.getCourses();
  //     developer.log('Response of get courses : ${response.data!}');
  //     emit(DetailedSignupGetCoursesLoaded(response.data!));
  //   } catch (e) {
  //     developer.log('Ending up in error of get courses : $e');
  //     emit(const DetailedSignupGetCollegesError());
  //   }
  // }
  // Future<void> _onGetJobroles(DetailedSignupGetJobroles event,
  //     Emitter<DetailedSignupState> emit) async {
  //   try {
  //     emit(const DetailedSignupJobrolesLoading());
  //     final response = await _detailedSignupUsecase.getJobroles();
  //     emit(DetailedSignupJobrolesLoaded(response.data!));
  //   } catch (e) {
  //     emit(const DetailedSignupJobrolesError());
  //   }
  // }