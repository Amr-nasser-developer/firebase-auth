import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagirevisiontask/modules/bottomNavigtionScreens/search/cubit/states.dart';
import 'package:softagirevisiontask/shared/componads.dart';
import 'package:softagirevisiontask/shared/remote/dio.dart';

class SearchCubit extends Cubit<SearchStates> {

  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);


  List search = [];
  int totalPages = 0;
  int currentPages = 2;

  searchCourse(String q) {
    emit(SearchLoading());
    DioHelper.postData(
      path: 'lms/api/v1/search',
      data: {
        'q': q,
        'type': 1,
      },
      query: {
        'page': 1
      },
      token: getToken(),
    ).then((value) {
      emit(SearchSuccess());
      print(value.data.toString());
      search = value.data['result']['data'] as List;
      currentPages++;
      totalPages = value.data['result']['last_page'];
    }).catchError((e) {
      emit(SearchError(e.toString()));
      print(e.toString());
    });
  }


  searchCourseMore(String q) {
    emit(SearchLoadingMore());
    DioHelper.postData(
      path: 'lms/api/v1/search',
      data: {
        'q': q,
        'type': 1,
      },
      query: {
        'page': 1
      },
      token: getToken(),
    ).then((value) {
      emit(SearchSuccess());
      print(value.data.toString());
      search.addAll(value.data['result']['data'] as List);
      currentPages++;
    }).catchError((e) {
      emit(SearchError(e.toString()));
      print(e.toString());
    });
  }
}


