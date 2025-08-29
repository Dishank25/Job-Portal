import 'dart:developer' as developer show log;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_portal/utils/constants/enums.dart';
import 'package:job_portal/views/signup_recruiter/presentation/bloc/recruiter_signup_bloc/recruiter_signup_bloc.dart';
import 'package:job_portal/views/signup_recruiter/presentation/bloc/recruiter_signup_bloc/recruiter_signup_state.dart';
import 'package:job_portal/views/signup_recruiter/presentation/bloc/recruiter_signup_bloc/recruiter_singup_event.dart';
import 'package:job_portal/views/signup_recruiter/presentation/views/recruiter_verify_email_view.dart';
import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';
import '../../../login/presentation/views/login_page_first_view.dart';

class RecruiterSignupPage extends StatefulWidget {
  const RecruiterSignupPage({super.key});

  @override
  State<RecruiterSignupPage> createState() => _RecruiterSignupPageState();
}

class _RecruiterSignupPageState extends State<RecruiterSignupPage> {
  // Move controllers inside the State class to avoid pre-filled values
  final TextEditingController eController = TextEditingController();
  final TextEditingController pController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController recruiterNameController = TextEditingController();
  final TextEditingController recruiter_SurNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  Map<String, dynamic> createSignupParams() {
    Map<String, dynamic> registerationMap = {
      "first_name": recruiterNameController.text.trim(),
      "last_name": recruiter_SurNameController.text.trim(),
      "email": eController.text.trim(),
      "phone": phoneController.text.trim(),
      "password": pController.text.trim(),
      "user_role": user_type.COMPANY.name
    };

    developer.log('Registration params: $registerationMap');
    return registerationMap;
  }

  void _navigateToVerifyEmail(BuildContext context) {
    developer.log('Navigating to verify email screen with email: ${eController.text.trim()}');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RecruiterVerifyEmailScreen(eController.text.trim()),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    eController.dispose();
    pController.dispose();
    phoneController.dispose();
    recruiterNameController.dispose();
    recruiter_SurNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(""),
        actions: [
          // Test navigation arrow - directly navigate without API calls
          IconButton(
              onPressed: () {
                if (eController.text.trim().isEmpty) {
                  showSnackbar('Please enter email first', context);
                } else {
                  _navigateToVerifyEmail(context);
                }
              },
              icon: const Icon(Icons.double_arrow)
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mSpacer(mHeight: 20.0),
                Text(
                  "Sign Up",
                  style: mTextStyle32(mColor: const Color(0xff1A1C1E)),
                ),
                mSpacer(),
                Text(
                  "Create an account to continue!",
                  style: mTextStyle12(),
                ),
                mSpacer(mHeight: 16.0),
                Text(
                  "Official Email",
                  style: mTextStyle12(),
                ),
                CustomTextField(
                  controller: eController,
                  hintText: "abc@gmail.com",
                  fillColor: Colors.white,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                mSpacer(mHeight: 16.0),
                Text("Password", style: mTextStyle12()),
                CustomTextField(
                  controller: pController,
                  hintText: "*******",
                  isPasswordField: true,
                  suffixIcon: Icons.visibility_off_outlined,
                  fillColor: Colors.white,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                mSpacer(mHeight: 24.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "First Name",
                        style: mTextStyle12(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Last Name",
                          style: mTextStyle12(),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: CustomTextField(
                          controller: recruiterNameController,
                          hintText: "Aman",
                          fillColor: Colors.white,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'First name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SizedBox(
                        child: CustomTextField(
                          controller: recruiter_SurNameController,
                          hintText: "Gupta",
                          fillColor: Colors.white,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Last name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                mSpacer(),
                Text("Phone Number", style: mTextStyle12()),
                CustomPhoneField(controller: phoneController),
                mSpacer(),
                BlocConsumer<RecruiterSignupBloc, RecruiterSignupState>(
                  listener: (context, state) {
                    developer.log('Current state: $state');

                    if (state is RecruiterSignupLoaded) {
                      final data = state.signUpUserEntity;
                      developer.log('Registration response: ${data.message}');

                      if (data.message == "User registered") {
                        developer.log('Registration successful, sending OTP email.');

                        // Send OTP email after successful registration
                        Map<String, dynamic> emailMap = {
                          "email": eController.text.trim()

                        };
                        context
                            .read<RecruiterSignupBloc>()
                            .add(RecruiterSignupSendOtpEmail(emailMap));

                      } else if (data.message == "Email already exists") {
                        showSnackbar('Email already exists', context);
                        // For testing, still allow navigation even if email exists
                        _navigateToVerifyEmail(context);
                      } else {
                        showSnackbar('Unknown response: ${data.message}', context);
                        // For testing, navigate anyway
                        _navigateToVerifyEmail(context);
                      }
                    } else if (state is RecruiterSignupSendOtpLoaded) {
                      // Navigate to verify email screen after OTP is sent
                      developer.log('OTP sent successfully, navigating to verify email.');
                      _navigateToVerifyEmail(context);
                    }
                    // Handle connection errors and other Dio exceptions
                    else if (state is RecruiterSignupError) {
                      // developer.log('Registration error state encountered: ${state.}');
                      showSnackbar('Server connection failed. Using test mode.', context);
                      // Direct navigation for testing since APIs are down
                      _navigateToVerifyEmail(context);
                    }
                    else if (state is RecruiterSignupSendOtpError) {
                      // developer.log('OTP send error state encountered: ${state.error}');
                      showSnackbar('OTP service unavailable. Using test mode.', context);
                      // Direct navigation for testing since OTP API is down
                      _navigateToVerifyEmail(context);
                    }

                  },
                  builder: (context, state) {
                    // Show loading indicator when processing
                    if (state is RecruiterSignupLoading || state is RecruiterSignupSendOtpLoading) {
                      _isProcessing = true;
                    } else {
                      _isProcessing = false;
                    }

                    return _isProcessing
                        ? const Center(child: CircularProgressIndicator())
                        : commonRedContainer(
                      text: "Register",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final registerationMap = createSignupParams();
                          developer.log('Recruiter params: $registerationMap');

                          // Check if server is reachable first
                          showSnackbar('Attempting registration...', context);

                          context
                              .read<RecruiterSignupBloc>()
                              .add(RecruiterSignupData(registerationMap));
                        } else {
                          showSnackbar('Please fill all the details correctly.', context);
                        }
                      },
                    );
                  },
                ),
                mSpacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "By signing up, you agree to our",
                      style: mTextStyle12(),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        " Terms and Conditions",
                        style: mTextStyle12(
                            mFontWeight: FontWeight.w700,
                            mColor: Color.fromARGB(255, 17, 24, 39)),
                      ),
                    ),
                  ],
                ),
                mSpacer(mHeight: 26.0),
                mSpacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: mTextStyle12(),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogInPage1(),
                          ),
                        );
                      },
                      child: Text(
                        " Login",
                        style: mTextStyle12(
                            mColor: AppColors.blueTextColor,
                            mFontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}