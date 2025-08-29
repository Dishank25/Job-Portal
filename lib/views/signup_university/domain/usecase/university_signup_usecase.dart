import 'package:job_portal/utils/resourses/data_state.dart';
import 'package:job_portal/utils/usecase/usecases.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/courses_response.dart';
import 'package:job_portal/views/signup_university/domain/repository/university_signup_repository.dart';

class CoursesUsecase
    implements UseCase<DataState<CoursesListResponse>, Map<String, dynamic>> {
  final UniversitySignupRepository _repository;
  CoursesUsecase(this._repository);

  @override
  Future<DataState<CoursesListResponse>> call(
      {Map<String, dynamic>? params}) async {
    return _repository.getCourses();
  }
}
