import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_portal/views/user_profile/domain/usecases/profile_usecases.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/manage_account_bloc/manage_account_event.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/manage_account_bloc/manage_account_state.dart';

class ManageAccountBloc extends Bloc<ManageAccountEvent, ManageAccountState> {
  final UpdateUserEmailUsecase _updateUserEmailUsecase;

  ManageAccountBloc(this._updateUserEmailUsecase)
      : super(const ManageAccountInitial()) {
    on<LoadChangeEmail>(_onChangeEmail);
  }

  Future<void> _onChangeEmail(
      LoadChangeEmail event, Emitter<ManageAccountState> emit) async {
    try {
      emit(const ChangeEmailLoading());
      final response = await _updateUserEmailUsecase(params: event.params);
      emit(ChangeEmailLoaded(response.data!));
    } catch (e) {
      emit(const ChangeEmailError());
    }
  }
}
