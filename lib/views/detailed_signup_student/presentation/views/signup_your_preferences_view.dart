import 'dart:developer' as developer show log;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/injection_container.dart';
import 'package:job_portal/utils/constants/enums.dart';
import 'package:job_portal/utils/constants/image_string.dart';
import 'package:job_portal/utils/storage/shared_preference.dart';
import 'package:job_portal/views/bottom_nav_bar/student_bottom_nav_bar.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/signup_as_anyone_bloc/detailed_signup_bloc.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/signup_as_anyone_bloc/detailed_signup_event.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/signup_as_anyone_bloc/detailed_signup_state.dart';
import 'package:job_portal/views/job_related/presentation/views/job_search_view.dart';
import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';

class SignupPageYourPreferences extends StatefulWidget {
  Map<String, dynamic> params;
  /* String first_name;
  String surName;
  String gender;
  String DOB;
  String phoneNumber;
  String email;
  String jobPreferenceLocation;
  String currentLocation;
  String ? userCategory;
  String totalWorkExp;
  String current_job_role;
  String current_company;
  String jobStartYear;
  String jobEndYear;
  String ? studentClass;
  String ? course;
  String college_name;
  String Specialization;
  String courseStartYear;
  String courseEndYear;*/
  SignupPageYourPreferences({super.key, required this.params});
  @override
  _SignupPageYourPreferencesState createState() =>
      _SignupPageYourPreferencesState();
}

class _SignupPageYourPreferencesState extends State<SignupPageYourPreferences> {
  final Set<String> selectedPreferences = {};
  final Set<String> selectedwork_modes = {};

  final _prefs = sl<PreferencesManager>();

  void togglePreference(String title) {
    setState(() {
      if (selectedPreferences.contains(title)) {
        selectedPreferences.remove(title);
      } else {
        //selectedPreferences.clear();
        selectedPreferences.add(title);
      }
    });
  }

  void togglework_mode(String title) {
    setState(() {
      if (selectedwork_modes.contains(title)) {
        selectedwork_modes.remove(title);
      } else {
        //selectedwork_modes.clear();
        selectedwork_modes.add(title);
      }
    });
  }

  String cleanString(String input) {
    return input.replaceAll('+', '').trim();
  }

  Future<void> onPressedFindOpportunities() async {
    // add preferences to params
    widget.params.addAll({
      DETAILEDPROFILEPARAMS.currently_looking_for.name:
          cleanString(selectedPreferences.first),
      DETAILEDPROFILEPARAMS.work_mode.name: cleanString(selectedwork_modes.first),
    });

    final dummyMap = {
      "user_id": _prefs.getuser_id() ?? 63,
      "first_name": "Megha",
      "last_name": "Gupta",
      "email": "axxa@gmail.com",
      "phone": "58798598",
      "dob": "1990-01-01",
      "city": "Delhi",
      "gender": "Female",
      "user_type": "Working Professional",
      "jobLocation": "San Francisco",
      "experiences": [
        {
          "user_id": _prefs.getuser_id() ?? 63,
          "company_recruiter_profile_id": "4",
          "jobrole": "Software Engineer",
          "company": "OriginCore",
          "start_date": "2022-01-01",
          "end_date": "2023-01-01",
          "description": "Worked on backend development"
        }
      ],
      "salary_details": "100000",
      "currently_looking_for": "job",
      "work_mode": "Remote"
    };

    // context
    //     .read<DetailedSignupBloc>()
    //     .add(DetailedSingupSubmitUserDetails(widget.params));
    context
        .read<DetailedSignupBloc>()
        .add(DetailedSingupSubmitUserDetails(widget.params));

    developer.log('Params in preferences screen : ${widget.params}');

    Map<String, dynamic> payload = {
      "user_id": 58,
      "first_name": "Megha",
      "last_name": "Gupta",
      "email": "a@gmail.com",
      "phone": "58798598",
      "dob": "1990-01-01",
      "city": "Delhi",
      "gender": "Female",
      "user_type": "Working Professional",
      "jobLocation": "San Francisco",
      "experiences": [
        {
          "user_id": 57,
          "company_recruiter_profile_id": "4",
          "jobrole": "Software Engineer",
          "company": "OriginCore",
          "start_date": "2022-01-01",
          "end_date": "2023-01-01",
          "description": "Worked on backend development"
        }
      ],
      "salary_details": "100000",
      "currently_looking_for": "job",
      "work_mode": "Remote"
    };

    // developer.log('Detailed Profile Payload : $payload');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(""),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Student_Bottom_Nav_bar(),
                ),
              );
            },
            icon: const Icon(Icons.double_arrow),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Logo",
                //     style: mTextStyle15(
                //         mColor: Color(0xff032466), mFontWeight: FontWeight.w700)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SvgPicture.asset(
                    // ImageString.progressBar1,
                    ImageString.jobPortalLogo,
                    height: 30,
                    // width: 40,
                    fit: BoxFit.contain,
                    allowDrawingOutsideViewBox: true, // optional
                  ),
                  // child: Image.asset(ImageString.pngLogo),
                ),
                mSpacer17(),
                Container(
                  height: 42,
                  width: double.infinity,
                  child: Text("Your Preferences",
                      style: mTextStyle32(mColor: Color(0xff1A1C1E))),
                ),
                mSpacer(mHeight: 10.0),
                Text("Help us match you with the best career opportunities",
                    style: mTextStyle12()),
                mSpacer(mHeight: 25.0),
                SvgPicture.asset(ImageString.progressBar3),
                SizedBox(height: 3),
                mSpacer(mHeight: 25.0),

                /// Preferences Section
                Text("Currently looking for:", style: mTextStyle12()),
                mSpacer(mHeight: 8.0),
                Wrap(
                  runSpacing: 12,
                  children: [
                    OptionContainer(
                      title: "Jobs +",
                      isSelected: selectedPreferences.contains("Jobs +"),
                      onTap: () => togglePreference("Jobs +"),
                    ),
                    SizedBox(width: 12),
                    OptionContainer(
                      title: "Internships +",
                      isSelected: selectedPreferences.contains("Internships +"),
                      onTap: () => togglePreference("Internships +"),
                    ),
                    SizedBox(width: 12),
                    OptionContainer(
                      title: "Projects  +",
                      isSelected: selectedPreferences.contains("Projects +"),
                      onTap: () => togglePreference("Projects +"),
                    ),
                  ],
                ),
                mSpacer(mHeight: 25.0),

                // /// Work Mode Section
                Text("Work Mode:", style: mTextStyle12()),
                mSpacer(mHeight: 8.0),
                Wrap(
                  runSpacing: 12,
                  children: [
                    OptionContainer(
                      title: "In-Office  +",
                      isSelected: selectedwork_modes.contains("In-Office  +"),
                      onTap: () => togglework_mode("In-Office  +"),
                    ),
                    const SizedBox(width: 12),
                    OptionContainer(
                      title: "Hybrid  +",
                      isSelected: selectedwork_modes.contains("Hybrid  +"),
                      onTap: () => togglework_mode("Hybrid  +"),
                    ),
                    const SizedBox(width: 12),
                    OptionContainer(
                      title: "Work From Home  +",
                      isSelected:
                          selectedwork_modes.contains("Work From Home  +"),
                      onTap: () => togglework_mode("Work From Home  +"),
                    ),
                  ],
                ),
                mSpacer(mHeight: 25.0),

                BlocListener<DetailedSignupBloc, DetailedSignupState>(
                  listener: (context, state) {
                    if (state is DetailedSingupSubmitUserDetailsLoaded) {
                      final data = state.submitDetailedUserProfile;

                      if (data.message ==
                          'User details and experiences added successfully.') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const Student_Bottom_Nav_bar(),
                          ),
                        );
                      } else {
                        showSnackbar(data.message, context);
                      }
                    } else if (state is DetailedSingupSubmitUserDetailsError) {
                      showSnackbar(
                          'We encountered some error submiting your profile.',
                          context);
                    }
                  },
                  child: Center(
                    child: SizedBox(
                      width: 160,
                      child: nextButton(
                        title: "Find opportunities",
                        onTap: () async {
                          await onPressedFindOpportunities();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const Student_Bottom_Nav_bar(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                /// Button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
