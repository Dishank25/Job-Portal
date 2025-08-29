// ignore_for_file: prefer_const_constructors

import 'dart:developer' as developer show log;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:job_portal/utils/constants/image_string.dart';
import 'package:job_portal/utils/theme/custom_themes/color_theme.dart';
import 'package:job_portal/views/user_profile/presentation/views/User_Notifications_Screen.dart';
import 'package:job_portal/views/job_related/domain/entities/all_jobs_entity.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_bloc/job_bloc.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_bloc/job_event.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_bloc/job_state.dart';
import '../../../../widgets/widgets.dart';
import '../../../user_profile/presentation/views/User_messages_screen.dart';
import 'Job_filters_Screen.dart';
import '../../../../ui_helper/ui_helper.dart';
import 'job_details_view.dart';

class JobSearchScreen extends StatefulWidget {
  final VoidCallback? onCallBackFromJobDetailsPage;
  const JobSearchScreen({super.key, this.onCallBackFromJobDetailsPage});

  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  TextEditingController jSearchController = TextEditingController();

  List<Map<String, dynamic>> mList = [
    {
      "job_title": "Digital Marketing Executive",
      "company_name": "Uber",
      "image":
          // "https://static-00.iconduck.com/assets.00/uber-icon-1024x1024-4icncyyo.png",
          "https://picsum.photos/200",
      "location": "Mumbai",
      "experience": "1-2 years",
      "salary": "INR 3,00,000",
      "status": "Actively Hiring",
      "posted": "2 weeks ago",
      "match": "92% match"
    },
    {
      "job_title": "Web Developer",
      "company_name": "GitHub",
      "image":
          "https://seekvectors.com/files/download/e58196130297806acd58a2bf536ac0bc.jpg",
      "location": "Remote",
      "experience": "2-4 years",
      "salary": "INR 6,00,000",
      "status": "Actively Hiring",
      "posted": "1 week ago",
      "match": "88% match"
    },
  ];

  List<AllJobsEntity> allJobsList = [];

  String formatSalaryRangeToINR(String salaryRange) {
    final format =
        NumberFormat.decimalPattern('en_IN'); // Just number formatting
    final parts = salaryRange.split('-').map((e) => e.trim()).toList();

    if (parts.length == 2) {
      final start = int.tryParse(parts[0]);
      final end = int.tryParse(parts[1]);
      if (start != null && end != null) {
        // developer.log(
        //     "Salary range : INR ${format.format(start)} - ${format.format(end)}");
        return 'INR ${format.format(start)} - ${format.format(end)}';
      }
    }

    // Fallback
    return salaryRange;
  }

  String formatDaysAgoFromString(String daysStr) {
    final days = int.tryParse(daysStr.trim());

    if (days == null) return 'Recently posted';
    if (days < 0) return 'In the future';

    if (days == 0) return 'Today';
    if (days == 1) return '1 day ago';
    if (days < 7) return '$days days ago';

    if (days < 30) {
      final weeks = (days / 7).round();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    }

    if (days < 365) {
      final months = (days / 30).round();
      return months == 1 ? '1 month ago' : '$months months ago';
    }

    final years = (days / 365).round();
    return years == 1 ? '1 year ago' : '$years years ago';
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final bloc = context.read<JobBloc>();
    bloc.add(const LoadJobs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          ImageString.jobPortalLogo,
          height: 30,
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MessagesScreen()));
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocListener<JobBloc, JobState>(
                listener: (context, state) {
                  if (state is JobsLoaded) {
                    final data = state.allJobsEntity;
                    developer.log("All jobs list length : ${data.length}");
                    setState(() {
                      allJobsList = data;
                    });
                  } else if (state is JobsError) {
                    developer.log("Error loading jobs list.");
                  } else if (state is JobsLoading) {
                    developer.log(" loading jobs list.");
                  }
                },
                child: const SizedBox(),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jobs",
                      style: mTextStyle32(mColor: Colors.black),
                    ),
                    Text(
                        "Start applying to the latest job vacancies at the\nleading companies in India below.",
                        style: mTextStyle14(mColor: Color(0xff6C7278))),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 11.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: SearchTextField(
                              onTextChanged: (value) {
                                // Call your API here
                                print("API call for: $value");
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const JobFiltersScreen(),
                                    ),
                                  );
                                },
                                child: SvgPicture.asset(
                                    "assets/Icons/settings-sliders 1.svg")),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: allJobsList.length,
                        itemBuilder: (context, index) {
                          // final job = mList[index];
                          final job = allJobsList[index];

                          return JobCard(
                            onTap: () {
                              setState(() {
                                // if (widget.onCallBackFromJobDetailsPage !=
                                //     null) {
                                //   widget.onCallBackFromJobDetailsPage!();
                                // }
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobDetailsScreen(
                                    job_id: job.job_id,
                                  ),
                                ),
                              );
                            },
                            // imageUrl: job['image'],
                            // jobTitle: job['job_title'],
                            // company: job['company_name'],
                            // location: job['location'],
                            // experience: job['experience'],
                            // salary: job['salary'],
                            // status: job['status'],
                            // posted: job['posted'],
                            // match: job['match'],
                            // imageUrl: job.logo_url,
                            imageUrl: ImageString.dummyImageUrl,
                            jobTitle: job.jobProfile,
                            company: job.company_name,
                            location: job.cityChoice ?? 'City Choice',
                            experience: job.experience,
                            salary: formatSalaryRangeToINR(job.salary),
                            status: job.hiringStatus,
                            posted: formatDaysAgoFromString(
                                job.postedDaysAgo.toString()),
                            match: '${job.matchPercentage.toString()}% match',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String imageUrl,
      jobTitle,
      company,
      location,
      experience,
      salary,
      status,
      posted,
      match;
  VoidCallback onTap;

  JobCard({
    super.key,
    required this.imageUrl,
    required this.jobTitle,
    required this.company,
    required this.location,
    required this.experience,
    required this.salary,
    required this.status,
    required this.posted,
    required this.match,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Row - Icon + Title + Company + Right Tags
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  // child: SvgPicture.asset(
                  //   ImageString.logoipsum,
                  //   // height: 38,
                  //   width: 48,
                  //   // fit: BoxFit.cover,
                  // )
                  child: Image.asset(
                    ImageString.placeHolderImage,
                    height: 48,
                    color: Colors.grey[300],
                  ),
                  // child: Image.network(imageUrl,
                  //     height: 48, width: 48, fit: BoxFit.cover),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(jobTitle,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(company, style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    greyContainer(text: status, bgColor: TColors.secondary),
                    const SizedBox(height: 6),
                    greyContainer(
                        text: posted, bgColor: const Color(0xffEFF0F6)),
                    const SizedBox(height: 6),
                    greyContainer(
                        text: match, bgColor: const Color(0xff00B34B)),
                  ],
                )
              ],
            ),
            SizedBox(height: 12),
            // Second Row - Grey Containers aligned Left under the Icon
            Row(
              children: [
                greyContainer(
                    text: location,
                    bgColor: Colors.white,
                    txtClr: const Color(0xff6C7278),
                    border: true),
                const Spacer(),
                greyContainer(
                    text: experience,
                    bgColor: Colors.white,
                    txtClr: const Color(0xff6C7278),
                    border: true),
                const Spacer(),
                greyContainer(
                    text: salary,
                    bgColor: Colors.white,
                    txtClr: const Color(0xff6C7278),
                    border: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
