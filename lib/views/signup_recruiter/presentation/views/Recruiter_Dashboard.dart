import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/utils/constants/image_string.dart';
import 'package:job_portal/utils/theme/custom_themes/color_theme.dart';
import 'package:job_portal/views/signup_recruiter/presentation/views/Recruiter_Analytics_Reports.dart';
import 'package:job_portal/views/signup_recruiter/presentation/views/Recruiter_Setting_Panel.dart';
import 'package:job_portal/views/signup_recruiter/presentation/views/Recruiter_Upcoming_Interviews.dart';
import 'package:job_portal/views/signup_recruiter/presentation/views/Recruiter_pending_tasks.dart';
import 'package:job_portal/views/signup_recruiter/presentation/views/Recruiter_pipeline_candidates.dart';
import 'package:job_portal/views/user_profile/presentation/views/User_messages_screen.dart';
import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';
import '../../../user_profile/presentation/views/User_Notifications_Screen.dart';
import 'Recruiter_total_job_posts.dart';

class RecruiterDashboard extends StatefulWidget {
  const RecruiterDashboard({super.key});

  @override
  State<RecruiterDashboard> createState() => _RecruiterDashboardState();
}

class _RecruiterDashboardState extends State<RecruiterDashboard> {
  TextEditingController findingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
        //   child: Text(
        //     "LOGO",
        //     style: TextStyle(
        //         fontSize: 20,
        //         fontFamily: "Inter",
        //         fontWeight: FontWeight.w700,
        //         color: TColors.primary),
        //   ),
        // ),
        title: SvgPicture.asset(
          ImageString.jobPortalLogo,
          height: 30,
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
          padding: const EdgeInsets.only(right: 24.0, top: 7.0, left: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADING OF THE SCREEN
              Text(
                "DashBoard",
                style: mTextStyle32(mColor: Colors.black),
              ),
              const SizedBox(
                height: 15,
              ),

              /// SEARCH BAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Row(
                  children: [
                    // SizedBox(
                    //   width: 320,
                    //   child: customSearchBar(
                    //       controller: findingController, hint: "Search "),
                    // ),
                    Expanded(
                      child: SizedBox(
                        height: 80,
                        child: SearchTextField(onTextChanged: (value) {
                          print("API call for: $value");
                        }),
                      ),
                    ),
                    // Spacer(),
                    SizedBox(
                      width: 18,
                    ),
                    InkWell(
                        onTap: () {
                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>JobFiltersScreen()));
                        },
                        child: SvgPicture.asset(
                            "assets/Icons/settings-sliders 1.svg"))
                  ],
                ),
              ),

              /// DASHBOARD CONTAINERS
              SizedBox(
                height: 25,
              ),
              DashBoardConatiner(
                  Heading: "Total Job Post",
                  SubHeading:
                      "Track and manage all your open roles in one place.",
                  redButtonTitle: "Manage postings",
                  notificationNum: "(3)",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecruiterTotalJobPosts()));
                  }),
              SizedBox(
                height: 20,
              ),
              DashBoardConatiner(
                  Heading: "Pipeline candidates",
                  SubHeading:
                      "Monitor every candidate’s journey through your hiring funnel.",
                  redButtonTitle: "Manage pipelines",
                  notificationNum: "(2)",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RecruiterPipelineCandidates()));
                  }),
              SizedBox(
                height: 20,
              ),
              DashBoardConatiner(
                  Heading: "Upcoming interviews",
                  SubHeading: "You have 3 interviews scheduled for today..",
                  redButtonTitle: "Review interviews",
                  notificationNum: "(3)",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RecruiterUpcomingInterviews()));
                  }),
              SizedBox(
                height: 20,
              ),
              DashBoardConatiner(
                  Heading: "Pending tasks",
                  SubHeading: "You have 5 tasks waiting for your attention..",
                  redButtonTitle: "Manage tasks",
                  notificationNum: "(5)",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecruiterPendingTasks()));
                  }),
              SizedBox(
                height: 20,
              ),
              DashBoardConatiner(
                  Heading: "Analytics and Report",
                  SubHeading:
                      "Track hiring progress and performance in real time.",
                  redButtonTitle: "view Details",
                  notificationNum: "",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecruiterAnalyticsReports()));
                  }),
              SizedBox(
                height: 20,
              ),
              DashBoardConatiner(
                  Heading: "Settings and access panel",
                  SubHeading: "Manage your personal info and app preferences.",
                  redButtonTitle: "view Details",
                  notificationNum: "",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecruiterSettingPanel()));
                  }),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// WIDGET FOR DASHBOARD CONTAINERS
Widget DashBoardConatiner(
    {required String Heading,
    required String SubHeading,
    required String redButtonTitle,
    required String notificationNum,
    required VoidCallback onTap}) {
  return Container(
    height: 110,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1.0)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                Heading,
                style: mTextStyle14(mFontWeight: FontWeight.w600),
              ),
              Spacer(),
              InkWell(onTap: () {}, child: Icon(Icons.more_horiz))
            ],
          ),
          SizedBox(
            height: 9,
          ),
          Text(
            SubHeading,
            style: TextStyle(
                fontSize: 12,
                color: AppColors.blueTextColor,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 26,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: TColors.secondary),
            child: InkWell(
              onTap: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    redButtonTitle,
                    style: mTextStyle12(mColor: Colors.white),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    notificationNum,
                    style: mTextStyle12(mColor: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
