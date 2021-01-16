import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagirevisiontask/modules/bottomNavigtionScreens/courses/cubit/states.dart';
import 'package:softagirevisiontask/shared/componads.dart';
import 'package:softagirevisiontask/shared/remote/dio.dart';

class CourseCubit extends Cubit<CourseStates>{

  CourseCubit() : super(CourseInitial());

  static CourseCubit get(context) => BlocProvider.of(context);

  List Courses = [];
  int totalPages = 0;
  int currentPage = 1;

  getCourse(){
    emit(CourseLoading());
    DioHelper.postData(
      path: 'lms/api/v1/courses',
      query: {
        'page': currentPage
      },
      token: getToken(),
    ).then((value){
      emit(CourseSuccess());
      print(value.data.toString());
      Courses = value.data['result']['data'] as List;
      currentPage++;
      totalPages = value.data['result']['last_page'];
    }).catchError((e){
      print(e.toString());
      emit(CourseError());
    });
  }

  getMoreCourse(){
    emit(CourseLoadingMore());
    DioHelper.postData(
      path: 'lms/api/v1/courses',
      query: {
        'page': currentPage
      },
      token: getToken(),
    ).then((value){
      emit(CourseSuccess());
      print(value.data.toString());
      Courses.addAll(value.data['result']['data'] as List);
      currentPage++;
    }).catchError((e){
      print(e.toString());
      emit(CourseError());
    });
  }
}