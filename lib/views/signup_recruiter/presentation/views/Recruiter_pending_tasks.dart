import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/utils/theme/custom_themes/color_theme.dart';
import 'package:job_portal/views/job_related/presentation/views/job_details_view.dart';

import 'package:job_portal/views/recruiter_application/presentation/view/Recruiter_Applications_Screen.dart';

import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';
import 'package:job_portal/views/recruiter_job_post/presentation/view/Recruiter_total_job_posts.dart';

class RecruiterPendingTasks extends StatelessWidget {
  TextEditingController findController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /// App bar
        appBar: buildCustomAppBar(titleText: "LOGO"),
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pending Tasks",
                        style: mTextStyle32(mColor: Colors.black),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                            controller: findController,
                            hintText: "Search by name, role or keyword...",
                            fillColor: Colors.white,
                            suffixIcon: Icons.search,
                            onSuffixTap: () {},
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                  "assets/Icons/settings-sliders 1.svg")),
                        ],
                      ),
                      SizedBox(height: 25),
                      reviewResumeContainer(
                          title: "Resumes to review",
                          nApplications: "4",
                          title_inside_greyContainer: "Resumes",
                          onTap: () {},
                          viewContainer_text: "Review Now",
                          buttonTap: () {}),
                      SizedBox(height: 25),
                      reviewResumeContainer(
                          title: "Interviews to Schedule",
                          nApplications: "1",
                          title_inside_greyContainer: "Interview",
                          onTap: () {},
                          viewContainer_text: "Schedule Now",
                          buttonTap: () {}),
                      SizedBox(height: 25),
                      reviewResumeContainer(
                          title: "Pending Offers",
                          nApplications: "1",
                          title_inside_greyContainer: "Interview",
                          onTap: () {},
                          viewContainer_text: "Send Offer",
                          buttonTap: () {}),
                    ]))));
  }
}

Widget reviewResumeContainer(
    {required String title,
    required String nApplications,
    required String title_inside_greyContainer,
    required String viewContainer_text,
    required VoidCallback onTap,
    required VoidCallback buttonTap}) {
  return Container(
    height: 90,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1.0, color: Colors.grey.shade300)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
              ),
              Spacer(),
              SizedBox(
                height: 22,
                child: greyContainer(
                  text: nApplications + " " + title_inside_greyContainer,
                  bgColor: Colors.grey.shade600,
                ),
              ),
              //  colorContainer(resumeMatch: resumeMatch, bgColor: bgColor, tColor: tColor),
              InkWell(onTap: buttonTap, child: Icon((Icons.more_vert)))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ViewAppContainer(
            title: viewContainer_text,
            onTap: onTap,
            bgColor: TColors.secondary,
            textColor: Colors.white,
          ),
        ],
      ),
    ),
  );
}
