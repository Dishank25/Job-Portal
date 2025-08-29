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

class RecruiterSignupPage extends StatelessWidget {
  TextEditingController eController = TextEditingController();
  TextEditingController pController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  RecruiterSignupPage({super.key});

  Map<String, dynamic> createSignupParams() {
    Map<String, dynamic> registerationMap = {
      "first_name": recruiterNameController.text.trim(),
      "last_name": recruiter_SurNameController.text.trim(),
      "email": eController.text.trim(),
      "phone": phoneController.text.trim(),
      "password": pController.text.trim(),
      "user_role": user_type.COMPANY.name
    };

    return registerationMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(""),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RecruiterVerifyEmailScreen(eController.text.trim()),
                  ),
                );
              },
              icon: const Icon(Icons.double_arrow))
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        // height: 710,
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
                    // Spacer(),
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
                    // Spacer(),
                    const SizedBox(
                      width: 20,
                    ),
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
                // CustomTextField(
                //   controller: phoneController,
                //   hintText: "7895674320",
                //   keyboardType: TextInputType.number,
                //   suffixIcon: Icons.call,
                //   fillColor: Color(0xffFFF7FB),
                //   validator: (value) {
                //     if (value == null || value.isEmpty)
                //       return 'Phone Number required';
                //     if (value.length < 10 || value.length > 10)
                //       return 'Phone Number must be 10 digits';
                //     return null;
                //   },
                // ),
                CustomPhoneField(controller: phoneController),
                mSpacer(),
                BlocListener<RecruiterSignupBloc, RecruiterSignupState>(
                  listener: (context, state) {
                    if (state is RecruiterSignupLoaded) {
                      final data = state.signUpUserEntity;

                      if (data.message == "User registered") {
                        developer.log('Navigating on successful signup.');
                        Map<String, dynamic> emailMap = {
                          "email": eController.text.trim()
                        };
                        context
                            .read<RecruiterSignupBloc>()
                            .add(RecruiterSignupSendOtpEmail(emailMap));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => RecruiterVerifyEmailScreen(
                        //         eController.text.trim()),
                        //   ),
                        // );
                      } else if (data.message == "Email already exists") {
                        showSnackbar('Email already exists', context);
                        // navigating only for testing purpose (remove this later)
                        // Map<String, dynamic> emailMap = {
                        //   "email": eController.text.trim()
                        // };
                        // context
                        //     .read<RecruiterSignupBloc>()
                        //     .add(RecruiterSignupSendOtpEmail(emailMap));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => RecruiterVerifyEmailScreen(),
                        //   ),
                        // );
                      } else {
                        showSnackbar(
                            'Unknown error while recruiter signup.', context);
                      }
                    } else if (state is RecruiterSignupSendOtpLoaded) {
                      final data = state.sendOtpEmail;

                      if (data.message == 'OTP sent successfully') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RecruiterVerifyEmailScreen(
                                eController.text.trim()),
                          ),
                        );
                      }
                    }
                  },
                  child: commonRedContainer(
                    text: "Register",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final registerationMap = createSignupParams();
                        developer
                            .log('Recruiter params log : $registerationMap');
                        context
                            .read<RecruiterSignupBloc>()
                            .add(RecruiterSignupData(registerationMap));
                      } else {
                        showSnackbar('Please fill all the details.', context);
                      }
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => RecruiterVerifyEmailScreen(),
                      //   ),
                      // );
                    },
                  ),
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
                // dividerLine(),
                mSpacer(),
                // belowBars(
                //     text: "Continue with Google",
                //     imgUrl: "assets/Icons/google.svg"),
                mSpacer(mHeight: 120.0),
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
