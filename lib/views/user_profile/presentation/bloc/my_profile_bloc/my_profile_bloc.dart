import 'dart:developer' as developer;

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_portal/views/user_profile/domain/usecases/profile_usecases.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/my_profile_bloc/my_profile_event.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/my_profile_bloc/my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  Map<String, dynamic> skillCertificates = {};

  final UserDetailUsecase _userDetailUsecase;
  final UpdateUserProfileUsecase _updateUserProfileUsecase;

  MyProfileBloc(this._userDetailUsecase, this._updateUserProfileUsecase)
      : super(const MyProfileInitial()) {
    // on<PickResume>(_onLoadCertificate);
    // on<RemoveCertificate>(_onRemoveCertificate);
    on<LoadMyProfileDetails>(_onLoadProfileDetails);
    on<LoadUpdateProfile>(_onUpdateUserProfile);
  }

  // Future<void> _onLoadCertificate(
  //     PickResume event, Emitter<MyProfileState> emit) async {
  //   try {
  //     emit(const ResumeLoading());
  //     final file = await FilePicker.platform.pickFiles();

  //     // if (file != null && event.skillName != null) {
  //     // skillCertificates[event.skillName!] = file;
  //     // developer.log(file.files.first.path ?? 'null path');
  //     // }
  //     emit(const ResumeLoaded());
  //   } catch (e) {
  //     developer.log('Error while picking resume: ${e.toString()}');
  //     emit(const ResumeLoadError());
  //   }
  // }

  Future<void> _onLoadProfileDetails(
      LoadMyProfileDetails event, Emitter<MyProfileState> emit) async {
    try {
      emit(const MyProfileDetailsLoading());
      final map = {'id': event.id};
      final respones = await _userDetailUsecase(params: map);
      // developer.log('checking in bloc : ${respones.data!.first_name}');
      emit(MyProfileDetailsLoaded(respones.data!));
    } catch (e) {
      developer.log('checking error in bloc : ${e}');

      emit(const MyProfileDetailsError());
    }
  }

  Future<void> _onUpdateUserProfile(
      LoadUpdateProfile event, Emitter<MyProfileState> emit) async {
    try {
      emit(const UpdateProfileLoading());
      final map = {'id': event.id, 'params': event.params};
      final respones = await _updateUserProfileUsecase(params: map);
      // developer.log('checking in bloc : ${respones.data!.first_name}');
      emit(UpdateProfileLoaded(respones.data!));
    } catch (e) {
      developer.log('checking error in bloc : ${e}');

      emit(const UpdateProfileError());
    }
  }

  // Future<void> _onRemoveCertificate(
  //     RemoveCertificate event, Emitter<SkillState> emit) async {
  //   emit(const SkillCertificateLoading());
  //   try {
  //     if (event.skillName != null) {
  //       skillCertificates.remove(event.skillName);
  //     }
  //     emit(SkillCertificatesLoaded(skillCertificates));
  //   } catch (e) {
  //     developer.log('Error removing certificate');
  //   }
  // }
}
