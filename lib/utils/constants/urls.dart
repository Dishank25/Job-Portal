// base url and other const data

class Urls {
  static const baseurlIP = "http://212.95.51.83:5000/";
  static const baseUrl = "${baseurlIP}api/";

  static const userRegisteration = "users/register"; //working
  static const userLogin = "users/login"; //working
  static const sendOtpEmail = "otp/send-otp"; //working
  static const verifyOtpEmail = "otp/verify-otp"; //working
  static const getUserBasicInfo = "users/getUserData"; //working
  static const getColleges = "master/school-college"; //working
  static const getSpecialization = "master/specialization"; //working
  static const getCourses = "master/courses"; //working
  static const getDomainAll = "domain/all"; //not-working
  static const getSubSkills = "skills/by-domain"; //working
  static const getJobroles = "master/job-roles"; //working
  static const submitDetailedUserProfile = "user-details/detail"; //
  static const submitSkillsAndCertificates = "upload-skill";
  static const getInternshipFormMetadata = "internship-filters";
  static const createJobPost = "jobpost/create";
  static const opportunities = "opportunities";
  static const jobDetails = "jobdetails/";
  static const getLocations = "master/location";
  static const getFeedPosts = "feed/posts";
  static const getPublicProfile = "user-details/public-profile/";
  static const getUserDetails = "user-details/detail/";
  static const getTermsAndConditions = "user-details/getterms_and_condition";
  static const updateUserDetailsById = "user-details/detail/";
  static const changeUserEmail = "users/changeEmail";
  static const feedPostLike1 = "feed/posts/";
  static const feedPostLike2 = "/like";
  static const feedPostComment1 = "feed/posts/";
  static const feedPostComment2 = "/comment";
  static const applyForJob = "jobpost/apply/{job_id}";
  static const uploadFileGetUrl = "upload-image";
  static const createFeedPost = "feed/feed";
  static const getJobApplications = "user/applications";
  static const getFollowers = "feed/{id}/followers";
  static const getFollowing = "feed/{id}/following";
  static const getMasterAll = "master/all";
}
