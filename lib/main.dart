import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_portal/auth_wrapper.dart';
import 'package:job_portal/injection_container.dart';
import 'package:job_portal/utils/theme/theme.dart';
import 'package:job_portal/utils/upload_file_get_url/presentation/bloc/upload_file_bloc.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/signup_as_anyone_bloc/detailed_signup_bloc.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/skill_bloc/skill_bloc.dart';
import 'package:job_portal/views/feed/presentation/bloc/create_feed_post_bloc/create_feed_post_bloc.dart';
import 'package:job_portal/views/feed/presentation/bloc/feed_bloc/feed_bloc.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_apply_bloc/job_apply_bloc.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_bloc/job_bloc.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_details_bloc/job_details_bloc.dart';
import 'package:job_portal/views/login/presentation/bloc/remote_login_bloc.dart';
import 'package:job_portal/views/post_opportunities/presentation/bloc/opportunity_bloc.dart';
import 'package:job_portal/views/recruiter_dashboard/presentation/bloc/recruiter_dashboard_bloc/Recruiter_Dashboard_Bloc.dart';
import 'package:job_portal/views/recruiter_full_view_application/presentation/bloc/recruiter_full_view_application_bloc.dart';
import 'package:job_portal/views/recruiter_job_post/presentation/bloc/recruiter_job_post_bloc/recruiter_job_post_bloc.dart';
import 'package:job_portal/views/signup_recruiter/presentation/bloc/recruiter_signup_bloc/recruiter_signup_bloc.dart';
import 'package:job_portal/views/signup_recruiter/presentation/bloc/verify_otp_recruiter_bloc/verify_otp_recruiter_bloc.dart';
import 'package:job_portal/views/signup_student/presentation/bloc/remote_signup_bloc/remote_signup_bloc.dart';
import 'package:job_portal/views/signup_student/presentation/bloc/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:job_portal/views/signup_university/presentation/blocs/university_signup_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/job_applications_bloc/job_application_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/manage_account_bloc/manage_account_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/my_profile_bloc/my_profile_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/terms_and_conditions_bloc/terms_and_conditions_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/upload_resume_bloc/upload_resume_bloc.dart';
import 'views/login/presentation/views/login_page_first_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<RemoteSignupBloc>()),
        BlocProvider(create: (_) => sl<RemoteLoginBloc>()),
        BlocProvider(create: (_) => sl<DetailedSignupBloc>()),
        BlocProvider(create: (_) => sl<SkillBloc>()),
        BlocProvider(create: (_) => sl<RecruiterSignupBloc>()),
        BlocProvider(create: (_) => sl<RecruiterDashboardBloc>()),
        BlocProvider(create: (_) => sl<OpportunityBloc>()),
        BlocProvider(create: (_) => sl<JobBloc>()),
        BlocProvider(create: (_) => sl<JobDetailsBloc>()),
        BlocProvider(create: (_) => sl<VerifyOtpBloc>()),
        BlocProvider(create: (_) => sl<VerifyOtpRecruiterBloc>()),
        BlocProvider(create: (_) => sl<UniversitySignupBloc>()),
        BlocProvider(create: (_) => sl<FeedBloc>()),
        BlocProvider(create: (_) => sl<ProfileBloc>()),
        BlocProvider(create: (_) => sl<MyProfileBloc>()),
        BlocProvider(create: (_) => sl<TermsAndConditionsBloc>()),
        BlocProvider(create: (_) => sl<ManageAccountBloc>()),
        BlocProvider(create: (_) => sl<JobApplyBloc>()),
        BlocProvider(create: (_) => sl<UploadFileBloc>()),
        BlocProvider(create: (_) => sl<CreateFeedPostBloc>()),
        BlocProvider(create: (_) => sl<UploadResumeBloc>()),
        BlocProvider(create: (_) => sl<JobApplicationBloc>()),
        BlocProvider(create: (_) => sl<RecruiterJobPostBloc>()),
        BlocProvider(create: (_) => sl<RecruiterFullViewApplicationBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.light,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        // home: LogInPage1(),
        home: const AuthWrapper(),
      ),
    );
  }
}
