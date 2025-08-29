import 'dart:developer' as developer show log;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_portal/views/bottom_nav_bar/recruiter_bottom_nav_bar.dart';
import 'package:job_portal/views/post_opportunities/presentation/views/post_opportunity_screen.dart';
import 'package:job_portal/views/signup_recruiter/presentation/bloc/verify_otp_recruiter_bloc/verify_otp_recruiter_bloc.dart';
import 'package:job_portal/views/signup_recruiter/presentation/bloc/verify_otp_recruiter_bloc/verify_otp_recruiter_event.dart';
import 'package:job_portal/views/signup_recruiter/presentation/bloc/verify_otp_recruiter_bloc/verify_otp_recruiter_state.dart';
import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';
import '../../../login/presentation/views/login_page_first_view.dart';
import 'Recruiter_View_Full_Application_screen.dart';

class RecruiterVerifyEmailScreen extends StatelessWidget {
  final String email;
  RecruiterVerifyEmailScreen(this.email, {super.key});

  TextEditingController timePassController = TextEditingController();

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
                  builder: (context) => const RecruiterBottomNavBar(),
                ),
              );
            },
            icon: const Icon(
              Icons.double_arrow,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mSpacer(mHeight: 20.0),
            Text(
              "Verify your email",
              style: mTextStyle32(
                mColor: const Color(0xff1A1C1E),
              ),
            ),
            mSpacer(),
            Text(
              "One Time Password (OTP) has been sent on $email",
              style: mTextStyle12(),
            ),
            mSpacer(mHeight: 26.0),
            Text(
              "Enter OTP to verify your email",
              style: mTextStyle12(),
            ),
            const SizedBox(
              height: 2,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomTextField(
                controller: timePassController,
                hintText: "Enter OTP",
                fillColor: Colors.white,
              ),
            ),
            mSpacer(),
            BlocListener<VerifyOtpRecruiterBloc, VerifyOtpRecruiterState>(
                listener: (context, state) {
                  if (state is VerifyOtpRecruiterLoaded) {
                    final data = state.verifyOtpEntity;

                    if (data.message == "OTP verified successfully") {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => PostInternshipsScreen(),
                      //   ),
                      // );
                    }
                  } else if (state is VerifyOtpRecruiterLoading) {
                    developer.log('Verify recruiter otp is loading.');
                  } else if (state is VerifyOtpRecruiterError) {
                    developer
                        .log('Verify recruiter otp ended up in some error.');
                  }
                },
                child: SizedBox()),
            SizedBox(
              width: double.infinity,
              child: commonRedContainer(
                text: "Verify Email",
                onTap: () {
                  developer.log('Printing email : $email');

                  Map<String, dynamic> emailOtpMap = {
                    "email": email,
                    "otp": timePassController.text.trim()
                  };

                  context
                      .read<VerifyOtpRecruiterBloc>()
                      .add(LoadVerifyRecruiterOtp(emailOtpMap));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => PostInternshipsScreen()));
                },
              ),
            ),
            mSpacer(),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {},
                      child: Text(
                        "Resend code",
                        style: mTextStyle12(mColor: AppColors.blueTextColor),
                      )),
                  Text(
                    " in 15 seconds",
                    style: mTextStyle12(),
                  )
                ],
              ),
            ),
            mSpacer(mHeight: 44.0),
            Center(
              child: SizedBox(
                height: 36,
                width: 313,
                child: Text(
                  "Can't find our mail? Check your spam folder or promotions tab too!",
                  style: mTextStyle12(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            mSpacer(mHeight: 243.0),
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
                              builder: (context) => LogInPage1()));
                    },
                    child: Text(
                      " Login",
                      style: mTextStyle12(
                          mColor: AppColors.blueTextColor,
                          mFontWeight: FontWeight.w600),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
