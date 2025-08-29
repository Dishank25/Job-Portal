import 'dart:developer' as developer show log;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/injection_container.dart';
import 'package:job_portal/ui_helper/ui_helper.dart';
import 'package:job_portal/utils/storage/shared_preference.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/manage_account_bloc/manage_account_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/manage_account_bloc/manage_account_event.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/manage_account_bloc/manage_account_state.dart';
import 'package:job_portal/widgets/widgets.dart';

class ChangeEmailView extends StatelessWidget {
  TextEditingController changedEmailController = TextEditingController();
  TextEditingController ChangedEmail_PasswordController =
      TextEditingController();

  ChangeEmailView({super.key});

  Map<String, dynamic> onPressedSaveChanges() {
    final _prefs = sl<PreferencesManager>();

    final user_id = _prefs.getuser_id();
    final map = {
      'user_id': user_id ?? '2',
      'newEmail': changedEmailController.text.trim()
    };

    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset("assets/Icons/message_icon.svg"),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset("assets/Icons/notifications_icon.svg"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Change Email",
              style: mTextStyle32(mColor: Colors.black),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
                height: 51,
                width: 300,
                child: Text(
                  "Please note that all the data associated with your account will be linked to your new email address after this change.",
                  style: mTextStyle12(),
                )),
            const SizedBox(
              height: 15,
            ),
            const Text("New Email ID"),
            CustomTextField(
                controller: changedEmailController,
                hintText: "agupta@gmail.com"),
            const SizedBox(
              height: 15,
            ),
            const Text("Password"),
            CustomTextField(
              controller: ChangedEmail_PasswordController,
              isPasswordField: true,
              hintText: "*******",
              suffixIcon: Icons.visibility_off_outlined,
            ),
            const SizedBox(
              height: 15,
            ),
            BlocListener<ManageAccountBloc, ManageAccountState>(
              listener: (context, state) {
                if (state is ChangeEmailLoading) {
                  developer.log('Change email Loading');
                } else if (state is ChangeEmailLoaded) {
                  developer.log(
                      'Change email Loaded : ${state.updateUserEmailEntity.message}');
                  Navigator.pop(context);
                } else if (state is ChangeEmailError) {
                  developer.log('Change email error.');
                }
              },
              child: const SizedBox(),
            ),
            Center(
                child: nextButton(
                    title: "Save Changes",
                    onTap: () {
                      // final map = onPressedSaveChanges();
                      final _prefs = sl<PreferencesManager>();

                      final user_id = _prefs.getuser_id();
                      final map = {
                        'user_id': user_id ?? '2',
                        'newEmail': changedEmailController.text.trim()
                      };
                      context
                          .read<ManageAccountBloc>()
                          .add(LoadChangeEmail(map));
                    })),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
