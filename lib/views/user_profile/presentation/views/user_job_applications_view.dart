import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/views/job_related/presentation/views/job_details_view.dart';
import 'package:job_portal/ui_helper/ui_helper.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/job_applications_bloc/job_application_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/job_applications_bloc/job_applications_event.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/job_applications_bloc/job_applications_state.dart';

class StudentJobApplications extends StatefulWidget {
  const StudentJobApplications({super.key});

  @override
  State<StudentJobApplications> createState() => _StudentJobApplicationsState();
}

class _StudentJobApplicationsState extends State<StudentJobApplications> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final bloc = context.read<JobApplicationBloc>();
    bloc.add(const LoadAllApplications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset("assets/Icons/message_icon.svg"),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset("assets/Icons/notifications_icon.svg"),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Text(
              "My Applications",
              style: mTextStyle32(mColor: Colors.black),
            ),
          ),
          BlocBuilder<JobApplicationBloc, JobApplicationsState>(
              builder: (context, state) {
            if (state is JobApplicationsLoaded) {
              final data = state.applications;
              return Expanded(
                child: ListView.builder(
                  itemCount: data.applications.length,
                  itemBuilder: (context, index) {
                    final item = data.applications[index];
                    return AppStatusCard(
                      comName: item.company_name,
                      nApplicants: item.applicantCount.toString(),
                      mDate: item.applyTime.toString(),
                      statusText: item.status,
                    );
                  },
                ),
              );
            } else if (state is JobApplicationsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is JobApplicationsError) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })

          // AppStatusCard(
          //   comName: "Company Name",
          //   nApplicants: "160",
          //   mDate: "30 April",
          //   statusText: "Hired",
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // AppStatusCard(
          //     comName: "Company Name",
          //     nApplicants: "230",
          //     mDate: "27 April",
          //     statusText: "Skills Missing"),
          // SizedBox(
          //   height: 20,
          // ),
          // AppStatusCard(
          //     comName: "Company Name",
          //     nApplicants: "230",
          //     mDate: "25 April",
          //     statusText: "Application Sent"),
        ],
      ),
    );
  }
}

/// Widget for Application status cards

class AppStatusCard extends StatelessWidget {
  final String comName, nApplicants, mDate, statusText;

  const AppStatusCard(
      {super.key,
      required this.comName,
      required this.nApplicants,
      required this.mDate,
      required this.statusText});

  Color getBackgroundColor() {
    switch (statusText) {
      case "Hired":
        return Color(0xffDFF7EA);
      case "Application Sent":
        return Color(0xffFFF6E4);
      case "Skills Missing":
        return Color(0xffFFE7E0);
      default:
        return Color(0xffEFF0F6);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = getBackgroundColor();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comName,
                style: mTextStyle14(),
              ),
              SizedBox(
                height: 6,
              ),
              greyContainer(text: statusText, bgColor: Color(0xffEFF0F6)),
              SizedBox(
                height: 6,
              ),
              Text(
                "$nApplicants applied, Applied on $mDate",
                style: mTextStyle12(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
