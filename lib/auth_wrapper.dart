import 'dart:developer' as developer show log;

import 'package:flutter/material.dart';
import 'package:job_portal/injection_container.dart';
import 'package:job_portal/utils/storage/shared_preference.dart';
import 'package:job_portal/views/bottom_nav_bar/recruiter_bottom_nav_bar.dart';
import 'package:job_portal/views/bottom_nav_bar/student_bottom_nav_bar.dart';
import 'package:job_portal/views/login/presentation/views/login_page_first_view.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = sl<PreferencesManager>();

    developer.log(
        "Saved Token : ${prefs.getToken()}\nSaved User Type : ${prefs.getuser_type()}");
    if (prefs.getToken() != null &&
        prefs.getuser_type()?.toLowerCase() == 'student') {
      return const Student_Bottom_Nav_bar();
    } else if (prefs.getToken() != null &&
        prefs.getuser_type()?.toLowerCase() == 'company') {
      return RecruiterBottomNavBar();
    } else {
      return LogInPage1();
    }
  }
}
