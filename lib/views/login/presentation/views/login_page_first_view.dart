import 'dart:developer' as developer show log;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/injection_container.dart';
import 'package:job_portal/utils/constants/enums.dart';
import 'package:job_portal/utils/constants/image_string.dart';
import 'package:job_portal/utils/storage/shared_preference.dart';
import 'package:job_portal/utils/theme/custom_themes/color_theme.dart';
import 'package:job_portal/views/bottom_nav_bar/student_bottom_nav_bar.dart';
import 'package:job_portal/views/common_screens/forgot_password_screen.dart';
import 'package:job_portal/views/login/presentation/bloc/remote_login_bloc.dart';
import 'package:job_portal/views/login/presentation/bloc/remote_login_event.dart';
import 'package:job_portal/views/login/presentation/bloc/remote_login_state.dart';
import 'package:job_portal/views/signup_recruiter/presentation/views/Recruiter_Dashboard.dart';
import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';
import 'login_with_email_otp_view.dart';
import '../../../signup_student/presentation/views/create_account.dart';
import '../../../post_opportunities/presentation/views/post_opportunity_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:job_portal/utils/storage/shared_preference.dart';

class LogInPage1 extends StatefulWidget {
  const LogInPage1({super.key});

  @override
  State<LogInPage1> createState() => _SignInPage_1State();
}

class _SignInPage_1State extends State<LogInPage1> {
  String token = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Form key

  bool rememberMeValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // foregroundColor: Colors.transparent,
        // surfaceTintColor: Colors.transparent,
        // shadowColor: Colors.transparent,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SvgPicture.asset(
            ImageString.jobPortalLogo,
            height: 30,
            // width: 40,
            fit: BoxFit.contain,
            allowDrawingOutsideViewBox: true, // optional
          ),
        ),
        backgroundColor: TColors.primary,
        // backgroundColor: TColors.primary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              signInHeader(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateAccount(),
                    ),
                  );
                },
              ),
              mSpacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email", style: mTextStyle14()),
                      CustomTextField(
                        controller: emailController,
                        hintText: "abc@gmail.com",
                        fillColor: Colors.white,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      mSpacer(mHeight: 16.0),
                      Text("Password", style: mTextStyle14()),
                      CustomTextField(
                        controller: passwordController,
                        hintText: "*******",
                        suffixIcon: Icons.visibility_off_outlined,
                        fillColor: Colors.white,
                        isPasswordField: true,
                        // isObscure: true,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      mSpacer(mHeight: 16.0),
                      RememberMeRow(
                        onForgotPasswordTap: () {
                          // Navigate to Forgot Password screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        onRememberMeChanged: (value) {
                          rememberMeValue = value;
                          print("Remember me: $rememberMeValue");
                        },
                      ),
                      mSpacer(mHeight: 30.0),
                      BlocListener<RemoteLoginBloc, RemoteLoginState>(
                        listener: (context, state) {
                          if (state is RemoteLoginError) {
                            showSnackbar(
                                'There was an error logging in.', context);
                          } else if (state is RemoteLoginLoaded) {
                            final data = state.loginUserResponse;
                            final prefs = sl<PreferencesManager>();
                            prefs.setToken(data.token);
                            prefs.setuser_id(data.user.id.toString());

                            if (rememberMeValue) {
                              prefs.setuser_type(data.user.user_role);
                            }

                            if (data.message == 'Login successful') {
                              showSnackbar('Login successful', context);
                              developer.log('Login data : ${data.toString()}');
                              developer.log(
                                  'User Type on login : ${data.user.user_role.toString()}');
                              developer.log(
                                  "this is login page user id${data.user.id}");
                              if (data.user.user_role ==
                                  user_type.STUDENT.name) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const Student_Bottom_Nav_bar(),
                                  ),
                                );
                              } else if (data.user.user_role ==
                                  user_type.COMPANY.name) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostInternshipsScreen(
                                      user_id: data.user.id,
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        },
                        child: commonRedContainer(
                          text: "Log In",
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final loginMap = {
                                "email": emailController.text.trim(),
                                "password": passwordController.text.trim(),
                              };

                              developer
                                  .log('Login Map : ${loginMap.toString()}');

                              context
                                  .read<RemoteLoginBloc>()
                                  .add(RemoteLoginData(loginMap));
                            }
                          },
                        ),
                      ),
                      mSpacer(mHeight: 30.0),
                      dividerLine(),
                      mSpacer(),
                      belowBars(
                        text: "Continue with Google",
                        imgUrl: "assets/Icons/google.svg",
                        onTap: () {},
                      ),
                      mSpacer(),
                      belowBars(
                        text: "Login with OTP",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginWithEmailOtpScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 200),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
