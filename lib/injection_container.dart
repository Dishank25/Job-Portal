import 'package:get_it/get_it.dart';
import 'package:job_portal/utils/constants/urls.dart';
import 'package:job_portal/utils/network/dio_client.dart';
import 'package:job_portal/utils/storage/shared_preference.dart';
import 'package:job_portal/utils/upload_file_get_url/data/data_source/upload_file_api_service.dart';
import 'package:job_portal/utils/upload_file_get_url/data/repository/upload_file_repository_impl.dart';
import 'package:job_portal/utils/upload_file_get_url/domain/repository/upload_file_repository.dart';
import 'package:job_portal/utils/upload_file_get_url/domain/usecases/upload_file_usecase.dart';
import 'package:job_portal/utils/upload_file_get_url/presentation/bloc/upload_file_bloc.dart';
import 'package:job_portal/views/detailed_signup_student/data/data_source/detailed_api_service.dart';
import 'package:job_portal/views/detailed_signup_student/data/repository/skill_repository_impl.dart';
import 'package:job_portal/views/detailed_signup_student/domain/repository/skill_repository.dart';
import 'package:job_portal/views/detailed_signup_student/domain/usecases/skill_usecase.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/signup_as_anyone_bloc/detailed_signup_bloc.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/skill_bloc/skill_bloc.dart';
import 'package:job_portal/views/feed/data/data_sources/feed_api_service.dart';
import 'package:job_portal/views/feed/data/repository/feed_repository_impl.dart';
import 'package:job_portal/views/feed/domain/repository/feed_repository.dart';
import 'package:job_portal/views/feed/domain/usecases/feed_usecase.dart';
import 'package:job_portal/views/feed/presentation/bloc/create_feed_post_bloc/create_feed_post_bloc.dart';
import 'package:job_portal/views/feed/presentation/bloc/feed_bloc/feed_bloc.dart';
import 'package:job_portal/views/job_related/data/data_source/job_screens_api_service.dart';
import 'package:job_portal/views/job_related/data/repository/jobs_repository_impl.dart';
import 'package:job_portal/views/job_related/domain/repository/jobs_repository.dart';
import 'package:job_portal/views/job_related/domain/usecases/jobs_usecase.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_apply_bloc/job_apply_bloc.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_bloc/job_bloc.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_details_bloc/job_details_bloc.dart';
import 'package:job_portal/views/login/data/data_source/login_api_service.dart';
import 'package:job_portal/views/login/data/repository/login_repository_impl.dart';
import 'package:job_portal/views/login/domain/repository/login_repository.dart';
import 'package:job_portal/views/login/domain/usecases/login_usecase.dart';
import 'package:job_portal/views/login/presentation/bloc/remote_login_bloc.dart';
import 'package:job_portal/views/post_opportunities/data/data_sources/opportunities_api_service.dart';
import 'package:job_portal/views/post_opportunities/data/repository/opportunities_repository_impl.dart';
import 'package:job_portal/views/post_opportunities/domain/repository/opportunity_repository.dart';
import 'package:job_portal/views/post_opportunities/domain/usecases/metadata_usecase.dart';
import 'package:job_portal/views/post_opportunities/presentation/bloc/opportunity_bloc.dart';
import 'package:job_portal/views/signup_recruiter/data/data_source/recruiter_signup_api_service.dart';
import 'package:job_portal/views/signup_recruiter/data/repository/recruiter_signup_repository_impl.dart';
import 'package:job_portal/views/signup_recruiter/domain/repository/recruiter_signup_repository.dart';
import 'package:job_portal/views/signup_recruiter/domain/usecases/recruiter_signup_usecase.dart';
import 'package:job_portal/views/signup_recruiter/presentation/bloc/recruiter_signup_bloc/recruiter_signup_bloc.dart';
import 'package:job_portal/views/signup_recruiter/presentation/bloc/verify_otp_recruiter_bloc/verify_otp_recruiter_bloc.dart';
import 'package:job_portal/views/signup_student/data/data_source/signup_api_service.dart';
import 'package:job_portal/views/detailed_signup_student/data/repository/detailed_signup_repository_impl.dart';
import 'package:job_portal/views/signup_student/data/repository/signup_repository_impl.dart';
import 'package:job_portal/views/detailed_signup_student/domain/repository/detailed_signup_repository.dart';
import 'package:job_portal/views/signup_student/domain/repository/signup_repository.dart';
import 'package:job_portal/views/detailed_signup_student/domain/usecases/detailed_signup_usecase.dart';
import 'package:job_portal/views/signup_student/domain/usecase/signup_usecase.dart';
import 'package:job_portal/views/signup_student/presentation/bloc/remote_signup_bloc/remote_signup_bloc.dart';
import 'package:job_portal/views/signup_student/presentation/bloc/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:job_portal/views/signup_university/data/data_source/university_signup_api_service.dart';
import 'package:job_portal/views/signup_university/data/repository/university_signup_repository_impl.dart';
import 'package:job_portal/views/signup_university/domain/repository/university_signup_repository.dart';
import 'package:job_portal/views/signup_university/domain/usecase/university_signup_usecase.dart';
import 'package:job_portal/views/signup_university/presentation/blocs/university_signup_bloc.dart';
import 'package:job_portal/views/user_profile/data/data_sources/profile_api_service.dart';
import 'package:job_portal/views/user_profile/data/repository/profile_repository_impl.dart';
import 'package:job_portal/views/user_profile/domain/repository/profile_repository.dart';
import 'package:job_portal/views/user_profile/domain/usecases/profile_usecases.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/job_applications_bloc/job_application_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/manage_account_bloc/manage_account_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/my_profile_bloc/my_profile_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/terms_and_conditions_bloc/terms_and_conditions_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/upload_resume_bloc/upload_resume_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final sharedPreference = await SharedPreferences.getInstance();
  // Register Shared Preference
  sl.registerSingleton<SharedPreferences>(sharedPreference);
  // Register Preference Manager passing the shared preference instance
  sl.registerSingleton<PreferencesManager>(
      await PreferencesManager.create(sharedPreference));

  // Register dio client
  sl.registerSingleton<DioClient>(DioClient(Urls.baseUrl));

  // Dependencies / Api services
  sl.registerSingleton<SignupApiService>(
      SignupApiService(sl<DioClient>().instance));
  sl.registerSingleton<LoginApiService>(
      LoginApiService(sl<DioClient>().instance));
  sl.registerSingleton<DetailedApiService>(
      DetailedApiService(sl<DioClient>().instance));
  sl.registerSingleton<RecruiterSignupApiService>(
      RecruiterSignupApiService(sl<DioClient>().instance));
  sl.registerSingleton<OpportunitiesApiService>(
      OpportunitiesApiService(sl<DioClient>().instance));
  sl.registerSingleton<JobScreensApiService>(
      JobScreensApiService(sl<DioClient>().instance));
  sl.registerSingleton<UniversitySignupApiService>(
      UniversitySignupApiService(sl<DioClient>().instance));
  sl.registerSingleton<FeedApiService>(
      FeedApiService(sl<DioClient>().instance));
  sl.registerSingleton<ProfileApiService>(
      ProfileApiService(sl<DioClient>().instance));
  sl.registerSingleton<UploadFileApiService>(
      UploadFileApiService(sl<DioClient>().instance));

  // Blocs
  sl.registerFactory<RemoteSignupBloc>(() => RemoteSignupBloc(sl(), sl()));
  sl.registerFactory<RemoteLoginBloc>(() => RemoteLoginBloc(sl(), sl(), sl()));
  sl.registerFactory<DetailedSignupBloc>(() => DetailedSignupBloc(sl()));
  sl.registerFactory<SkillBloc>(() => SkillBloc(sl()));
  sl.registerFactory<RecruiterSignupBloc>(
      () => RecruiterSignupBloc(sl(), sl()));
  sl.registerFactory<OpportunityBloc>(() => OpportunityBloc(sl(), sl()));
  sl.registerFactory<JobBloc>(() => JobBloc(sl()));
  sl.registerFactory<JobDetailsBloc>(() => JobDetailsBloc(sl(), sl()));
  sl.registerFactory<VerifyOtpBloc>(() => VerifyOtpBloc(sl()));
  sl.registerFactory<VerifyOtpRecruiterBloc>(
      () => VerifyOtpRecruiterBloc(sl()));
  sl.registerFactory<UniversitySignupBloc>(() => UniversitySignupBloc(sl()));
  sl.registerFactory<FeedBloc>(() => FeedBloc(sl(), sl(), sl()));
  sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl(), sl(), sl()));
  sl.registerFactory<MyProfileBloc>(() => MyProfileBloc(sl(), sl()));
  sl.registerFactory<TermsAndConditionsBloc>(
      () => TermsAndConditionsBloc(sl()));
  sl.registerFactory<ManageAccountBloc>(() => ManageAccountBloc(sl()));
  sl.registerFactory<JobApplyBloc>(() => JobApplyBloc(sl()));
  sl.registerFactory<UploadFileBloc>(() => UploadFileBloc(sl()));
  sl.registerFactory<CreateFeedPostBloc>(() => CreateFeedPostBloc(sl()));
  sl.registerFactory<UploadResumeBloc>(() => UploadResumeBloc());
  sl.registerFactory<JobApplicationBloc>(() => JobApplicationBloc(sl()));

  // Use Cases
  sl.registerLazySingleton<SignupUsecase>(() => SignupUsecase(sl()));
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
  sl.registerLazySingleton<DetailedSignupUsecase>(
      () => DetailedSignupUsecase(sl()));
  sl.registerLazySingleton<SkillUsecase>(() => SkillUsecase(sl()));
  sl.registerLazySingleton<RecruiterSignupUsecase>(
      () => RecruiterSignupUsecase(sl()));
  sl.registerLazySingleton<MetadataUsecase>(() => MetadataUsecase(sl()));
  sl.registerLazySingleton<CreateJobPostUsecase>(
      () => CreateJobPostUsecase(sl()));
  sl.registerLazySingleton<JobsUsecase>(() => JobsUsecase(sl()));
  sl.registerLazySingleton<JobsDetailsUsecase>(() => JobsDetailsUsecase(sl()));
  sl.registerLazySingleton<SendOtpEmailUsecase>(
      () => SendOtpEmailUsecase(sl()));
  sl.registerLazySingleton<VerifyOtpEmailUsecase>(
      () => VerifyOtpEmailUsecase(sl()));
  sl.registerLazySingleton<VerifyOtpEmailRecruiterUsecase>(
      () => VerifyOtpEmailRecruiterUsecase(sl()));
  sl.registerLazySingleton<SendOtpEmailRecruiterUsecase>(
      () => SendOtpEmailRecruiterUsecase(sl()));
  sl.registerLazySingleton<CoursesUsecase>(() => CoursesUsecase(sl()));
  sl.registerLazySingleton<LoginSendOtpEmailUsecase>(
      () => LoginSendOtpEmailUsecase(sl()));
  sl.registerLazySingleton<LoginVerifyOtpEmailUsecase>(
      () => LoginVerifyOtpEmailUsecase(sl()));
  sl.registerLazySingleton<FeedUsecase>(() => FeedUsecase(sl()));
  sl.registerLazySingleton<ProfileUsecase>(() => ProfileUsecase(sl()));
  sl.registerLazySingleton<UserDetailUsecase>(() => UserDetailUsecase(sl()));
  sl.registerLazySingleton<TermsAndConditionsUsecase>(
      () => TermsAndConditionsUsecase(sl()));
  sl.registerLazySingleton<UpdateUserProfileUsecase>(
      () => UpdateUserProfileUsecase(sl()));
  sl.registerLazySingleton<UpdateUserEmailUsecase>(
      () => UpdateUserEmailUsecase(sl()));
  sl.registerLazySingleton<FeedPostLikeUsecase>(
      () => FeedPostLikeUsecase(sl()));
  sl.registerLazySingleton<FeedPostCommentUsecase>(
      () => FeedPostCommentUsecase(sl()));
  sl.registerLazySingleton<JobApplyUsecase>(() => JobApplyUsecase(sl()));
  sl.registerLazySingleton<UploadFileUsecase>(() => UploadFileUsecase(sl()));
  sl.registerLazySingleton<CreateFeedPostUsecase>(
      () => CreateFeedPostUsecase(sl()));
  sl.registerLazySingleton<AllJobApplicationsUsecase>(
      () => AllJobApplicationsUsecase(sl()));
  sl.registerLazySingleton<GetFollowersUsecase>(
      () => GetFollowersUsecase(sl()));
  sl.registerLazySingleton<GetFollowingUsecase>(
      () => GetFollowingUsecase(sl()));

  // Repository
  sl.registerLazySingleton<SignupRepository>(() => SignupRepositoryImpl(sl()));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));
  sl.registerLazySingleton<DetailedSignupRepository>(
      () => DetailedSignupRepositoryImpl(sl()));
  sl.registerLazySingleton<SkillRepository>(() => SkillRepositoryImpl(sl()));
  sl.registerLazySingleton<RecruiterSignupRepository>(
      () => RecruiterSignupRepositoryImpl(sl()));
  sl.registerLazySingleton<OpportunityRepository>(
      () => OpportunitiesRepositoryImpl(sl()));
  sl.registerLazySingleton<JobsRepository>(() => JobsRepositoryImpl(sl()));
  sl.registerLazySingleton<UniversitySignupRepository>(
      () => UniversitySignupRepositoryImpl(sl()));
  sl.registerLazySingleton<FeedRepository>(() => FeedRepositoryImpl(sl()));
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl()));
  sl.registerLazySingleton<UploadFileRepository>(
      () => UploadFileRepositoryImpl(sl()));
}
