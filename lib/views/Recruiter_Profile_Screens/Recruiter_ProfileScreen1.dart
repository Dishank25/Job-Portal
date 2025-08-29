import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/injection_container.dart';
import 'package:job_portal/utils/storage/shared_preference.dart';
import 'package:job_portal/utils/theme/custom_themes/color_theme.dart';
import 'package:job_portal/views/login/presentation/views/login_page_first_view.dart';

import '../../ui_helper/ui_helper.dart';
import '../user_profile/presentation/views/User_Notifications_Screen.dart';
import '../user_profile/presentation/views/User_messages_screen.dart';

class RecruiterProfilescreen1 extends StatefulWidget {
  const RecruiterProfilescreen1({super.key});

  @override
  State<RecruiterProfilescreen1> createState() =>
      _RecruiterProfilescreen1State();
}

class _RecruiterProfilescreen1State extends State<RecruiterProfilescreen1> {
  bool _isHelpSupportOpened = false;
  bool _isManageAccountOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {},
          child: Icon(Icons.arrow_back),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MessagesScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset("assets/Icons/message_icon.svg"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset("assets/Icons/notifications_icon.svg"),
            ),
          ),
        ],
      ),

      /// BODY PART
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              /// Profile Container
              Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: TColors.primary),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: SvgPicture.asset("assets/Icons/profile_icon.svg"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Anjali Sharma",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Text("AnjaliSharma@gmail.com",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white))
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 580,
                width: 383,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      UserProfileEnteries(
                        mIcon: "assets/Icons/profile_in_circle.svg",
                        title: "My Profile",
                        desc: "Make Changes to my Profile",
                        mArrow: Icons.keyboard_arrow_right_outlined,
                        onTap: () {
                          /*if(widget.onCallBackFromProfileScreen2!=null){
                              widget.onCallBackFromProfileScreen2!();*/
                        },
                      ),
                      UserProfileEnteries(
                          mIcon: "assets/Icons/application_icon.svg",
                          title: "Activity Feed",
                          desc: "Your recent activity",
                          mArrow: Icons.keyboard_arrow_right_outlined,
                          onTap: () {
                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>student_job_applications()));
                          }),
                      UserProfileEnteries(
                        mIcon: "assets/Icons/terms_permission_icon.svg",
                        title: "Terms and Permissions",
                        mArrow: Icons.keyboard_arrow_right_outlined,
                      ),
                      UserProfileEnteries(
                          mIcon: "assets/Icons/notification_in_circle.svg",
                          title: "Terms and Conditions",
                          mArrow: Icons.keyboard_arrow_right_outlined,
                          onTap: () {
                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserTermsConditionsScreen()));
                          }),
                      UserProfileEnteries(
                          mIcon: "",
                          title: "Help & Support",
                          mArrow: Icons.keyboard_arrow_right_outlined,
                          onTap: () {
                            setState(() {
                              _isHelpSupportOpened = !_isHelpSupportOpened;
                            });
                            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                          }),
                      if (_isHelpSupportOpened) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Column(
                            children: [
                              UserProfileEnteries(
                                  mIcon:
                                      "assets/Icons/Manage_account_icons.svg",
                                  title: "Raise your ticket"),
                              UserProfileEnteries(
                                  mIcon:
                                      "assets/Icons/Manage_account_icons.svg",
                                  title: "Chat with us!"),
                            ],
                          ),
                        )
                      ],
                      UserProfileEnteries(
                          mIcon: "assets/Icons/Manage_account_icons.svg",
                          title: "Manage Account",
                          mArrow: Icons.keyboard_arrow_right_outlined,
                          onTap: () {
                            setState(() {
                              _isManageAccountOpened = !_isManageAccountOpened;
                            });
                          }),
                      if (_isManageAccountOpened) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Column(
                            children: [
                              UserProfileEnteries(
                                  mIcon:
                                      "assets/Icons/Manage_account_icons.svg",
                                  title: "Change email",
                                  onTap: () {
                                    //  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserChangeEmailPage()));
                                  }),
                              UserProfileEnteries(
                                  mIcon:
                                      "assets/Icons/Manage_account_icons.svg",
                                  title: "Change password",
                                  onTap: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>UserChangePasswordScreen()));
                                  }),
                              UserProfileEnteries(
                                  mIcon:
                                      "assets/Icons/Manage_account_icons.svg",
                                  title: "Delete my account")
                            ],
                          ),
                        )
                      ],
                      UserProfileEnteries(
                        mIcon: "assets/Icons/Log_out_icon.svg",
                        title: "Log Out",
                        desc: "Further secure your account for safety",
                        mArrow: Icons.keyboard_arrow_right_outlined,
                        onTap: () {
                          final prefs = sl<PreferencesManager>();

                          prefs.clear(PreferencesManager.USER_TYPE);
                          prefs.clear(PreferencesManager.TOKEN);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LogInPage1()),
                              (_) => false);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget for entries of the profile column
Widget UserProfileEnteries(
    {required String mIcon,
    required String title,
    String? desc,
    IconData? mArrow,
    VoidCallback? onTap}) {
  return Row(
    children: [
      Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SvgPicture.asset(
          mIcon,
          height: 20,
          width: 20,
        ),
      ),
      SizedBox(
        width: 16,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: mTextStyle14(),
            ),
            Text(
              desc ?? "",
              style: mTextStyle12(),
            )
          ],
        ),
      ),
      IconButton(
        onPressed: onTap,
        icon: Icon(mArrow),
        color: Colors.black,
      )
    ],
  );
}
