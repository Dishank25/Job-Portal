import 'package:flutter/material.dart';
import 'package:job_portal/views/signup_recruiter/presentation/views/Recruiter_Applications_Screen.dart';
import 'package:job_portal/widgets/widgets.dart';

import '../../../../ui_helper/ui_helper.dart';

class Recruiter_View_Full_Application_screen extends StatelessWidget {
  const Recruiter_View_Full_Application_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildCustomAppBar(titleText: "Logo"),
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.only(right: 24.0, top: 7.0, left: 24.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Applications",
                        style: mTextStyle32(mColor: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Graphic Design internship",
                        style: mTextStyle14(mColor: Color(0xff6C7278)),
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      /// Applicant intro container
                      introContainer(
                          Name: "Saloni",
                          status: " Moderate",
                          bgColor: Color(0xffFFF6E4),
                          tColor: Color(0xffFFAD29),
                          location: "New Delhi",
                          TWX: "Fresher",
                          appliedDate: " 03/05/2025",
                          Skills: " Designing, SEO",
                          languages: "Hindi, English"),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      /// Screening Questions Container
                      ScreeningQuestionsContainer(
                          Availability: "Immediately available"),
                      SizedBox(
                        height: 10,
                      ),
                      ApplicantResumeContainer(),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(Icons.more_horiz),
                          Spacer(),
                          Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Color(0xff1DB32F), width: 1.0),
                                color: Color(0xffC0F0D8)),
                            child: Center(
                                child: Text(
                              "Hire",
                              style: mTextStyle12(mColor: Color(0xff1DB32F)),
                            )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Color(0xffF03729), width: 1.0),
                                color: Color(0xffFFD7CA)),
                            child: Center(
                                child: Text(
                              "Not Interested",
                              style: mTextStyle12(mColor: Color(0xffF03729)),
                            )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Color(0xff1D61E7), width: 1.0),
                                color: Color(0xffD2DFFA)),
                            child: Center(
                                child: Text(
                              "Shortlisted",
                              style: mTextStyle12(mColor: Color(0xff1D61E7)),
                            )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ]))));
  }
}

/// APPLICANT INTRO CONTAINER
Widget introContainer(
    {required String Name,
    required String status,
    required Color bgColor,
    required Color tColor,
    required String location,
    required String TWX,
    required String appliedDate,
    required String Skills,
    required String languages}) {
  return Container(
    height: 125,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(width: 1, color: Colors.grey.shade300),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                Name,
                style: mTextStyle15(
                    mColor: Colors.black, mFontWeight: FontWeight.w600),
              ),
              Spacer(),
              colorContainer(
                  resumeMatch: status, bgColor: bgColor, tColor: tColor)
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            location,
            style: TextStyle(fontSize: 10),
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text("Total work experience:$TWX ",
                  style: TextStyle(fontSize: 10)),
              Spacer(),
              Text("Applied on:$appliedDate ", style: TextStyle(fontSize: 10))
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "skills: $Skills ",
            style: mTextStyle12(
                mColor: Color(0xff544C4C), mFontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "Languages: $languages",
            style: mTextStyle12(
                mColor: Color(0xff544C4C), mFontWeight: FontWeight.w400),
          ),
        ],
      ),
    ),
  );
}

/// Screening Questions Container

Widget ScreeningQuestionsContainer({required String Availability}) {
  return Container(
    height: 115,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(width: 1, color: Colors.grey.shade300),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Screening Questions",
              style: mTextStyle15(
                  mColor: Colors.black, mFontWeight: FontWeight.w600)),
          SizedBox(
            height: 6,
          ),
          Text("Availability",
              style: mTextStyle12(
                  mColor: Color(0xff544C4C), mFontWeight: FontWeight.w400)),
          SizedBox(
            height: 6,
          ),
          Text(Availability,
              style: mTextStyle12(
                  mColor: Color(0xff544C4C), mFontWeight: FontWeight.w400))
        ],
      ),
    ),
  );
}

Widget ApplicantResumeContainer() {
  return Container(
    height: 550,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(width: 1, color: Colors.grey.shade300),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Resume",
              style: mTextStyle15(
                  mColor: Colors.black, mFontWeight: FontWeight.w600)),
          SizedBox(
            height: 6,
          ),
          Text("Education",
              style: mTextStyle12(
                  mColor: AppColors.blueTextColor,
                  mFontWeight: FontWeight.w400)),
          SizedBox(
            height: 20,
          ),
          Text("Internships",
              style: mTextStyle12(
                  mColor: AppColors.blueTextColor,
                  mFontWeight: FontWeight.w400)),
          SizedBox(
            height: 20,
          ),
          Text("Projects",
              style: mTextStyle12(
                  mColor: AppColors.blueTextColor,
                  mFontWeight: FontWeight.w400)),
          SizedBox(
            height: 20,
          ),
          Text("Additional Details",
              style: mTextStyle12(
                  mColor: AppColors.blueTextColor,
                  mFontWeight: FontWeight.w400)),
          SizedBox(
            height: 20,
          ),
          Text("Uploaded Resume",
              style: mTextStyle12(
                  mColor: AppColors.blueTextColor,
                  mFontWeight: FontWeight.w400)),
          SizedBox(
            height: 20,
          ),
          Text("Contacts",
              style: mTextStyle12(
                  mColor: AppColors.blueTextColor,
                  mFontWeight: FontWeight.w400)),
        ],
      ),
    ),
  );
}
