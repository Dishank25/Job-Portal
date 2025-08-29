import 'package:dio/dio.dart';
import 'package:job_portal/utils/constants/urls.dart';
import 'package:job_portal/views/post_opportunities/data/models/internship_metadata_response.dart';
import 'package:retrofit/retrofit.dart';

part 'opportunities_api_service.g.dart';

@RestApi(baseUrl: Urls.baseUrl)
abstract class OpportunitiesApiService {
  factory OpportunitiesApiService(Dio dio, {String? baseUrl}) =
      _OpportunitiesApiService;

  @GET(Urls.getInternshipFormMetadata)
  Future<HttpResponse<InternshipMetadataResponseModel>>
      getOpportunityFormMetadata();

  @POST(Urls.createJobPost)
  Future<HttpResponse<InternshipMetadataResponseModel>> createJobPost(
      @Body() Map<String, dynamic> params);
}
