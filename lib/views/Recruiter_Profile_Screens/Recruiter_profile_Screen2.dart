import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/views/user_profile/presentation/views/User_Notifications_Screen.dart';
import 'package:job_portal/views/user_profile/presentation/views/User_messages_screen.dart';

import '../../ui_helper/ui_helper.dart';

class RecruiterProfileScreen2 extends StatelessWidget {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                height: 88,
                width: 64,
                child: SvgPicture.asset("assets/Icons/profile_icon.svg"),
              ),
            ),
            Text(
              "Anjali Sharma",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Text("AnjaliSharma@gmail.com",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About",
                    style: mTextStyle12(mColor: Color(0xff544C4C)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text("Lead Recruiter, Flipkart, Bangalore, India",
                      style: mTextStyle12(
                        mColor: Color(0xff9095A0),
                      )),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Text(
                            "View/",
                            style:
                                mTextStyle12(mColor: AppColors.blueTextColor),
                          )),
                      InkWell(
                          onTap: () {},
                          child: Text("Edit About",
                              style: mTextStyle12(
                                  mColor: AppColors.blueTextColor))),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Contact Information",
                    style: mTextStyle12(mColor: Color(0xff544C4C)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text("+91XXXXXXXXX, email:",
                      style: mTextStyle12(
                        mColor: Color(0xff9095A0),
                      )),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Text(
                            "View/",
                            style:
                                mTextStyle12(mColor: AppColors.blueTextColor),
                          )),
                      InkWell(
                          onTap: () {},
                          child: Text("Edit ",
                              style: mTextStyle12(
                                  mColor: AppColors.blueTextColor))),
                    ],
                  ),
                  /* SizedBox(height: 15,),
                  Text("Resume", style: mTextStyle12(mColor: Color(0xff544C4C)),),
                  SizedBox(height: 3,),
                  Row(
                    children: [
                      InkWell( onTap:(){}, child: Text("View/", style: mTextStyle12(mColor: AppColors.blueTextColor),)),
                      InkWell( onTap:(){}, child: Text("Edit ",style: mTextStyle12(mColor: AppColors.blueTextColor))),
                    ],
                  ),*/
                  profileSection(
                    title: "Hiring Preferences",
                    items: ["Design", "Tech", "Sales", "SEO"],
                    onEditTap: () {},
                    editText: "Add Hiring Preferences",
                  ),
                  profileSection(
                    title: "Access and Permissions",
                    items: ["Admin"],
                    onEditTap: () {},
                    editText: "Add Team members",
                  ),
                  profileSection(
                    title: "Education",
                    items: ["B.Tech", "Diploma", "M.Tech"],
                    onEditTap: () {},
                    editText: "Add Education",
                  ),
                  profileSection(
                    title: "Languages you know",
                    items: ["English", "Hindi", "Spanish"],
                    onEditTap: () {},
                    editText: "Add Language",
                  ),
                  profileSection(
                    title: "Authentication",
                    items: ["Email", "Phone No.", "Aadhar"],
                    onEditTap: () {},
                    editText: "Get Verified",
                    isGetVerified:
                        true, // Only show "Get Verified" without "Edit/"
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget for common Column

Widget profileSection({
  required String title,
  required List<String> items,
  required VoidCallback onEditTap,
  required String editText,
  bool isGetVerified = false, // for special case like "Get Verified"
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 15),
      Text(title, style: mTextStyle12(mColor: Color(0xff544C4C))),
      SizedBox(height: 3),
      Wrap(
        spacing: 11,
        runSpacing: 8,
        children: items.map((item) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle,
                  color: item == items.first ? Colors.green : Colors.red,
                  size: 6),
              SizedBox(width: 3),
              Text(item, style: mTextStyle12(mColor: Color(0xff9095A0))),
            ],
          );
        }).toList(),
      ),
      SizedBox(height: 3),
      Row(
        children: [
          InkWell(
            onTap: onEditTap,
            child: Text(
              isGetVerified ? editText : "Edit/",
              style: mTextStyle12(mColor: AppColors.blueTextColor),
            ),
          ),
          if (!isGetVerified)
            InkWell(
              onTap: onEditTap,
              child: Text(
                editText,
                style: mTextStyle12(
                    mColor: AppColors.blueTextColor,
                    mFontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
    ],
  );
}
