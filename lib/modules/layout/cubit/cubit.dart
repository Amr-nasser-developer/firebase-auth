import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagirevisiontask/modules/bottomNavigtionScreens/courses/course_screen.dart';
import 'package:softagirevisiontask/modules/bottomNavigtionScreens/profile/profile_screen.dart';
import 'package:softagirevisiontask/modules/bottomNavigtionScreens/search/search_screen.dart';
import 'package:softagirevisiontask/modules/bottomNavigtionScreens/settings/setting_screen.dart';
import 'package:softagirevisiontask/modules/layout/cubit/states.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  var widgets = [
    CourseScreen(),
    SearchScreen(),
    ProfileScreen(),
    SettingScreen(),
  ];

  var titles = [
    'Courses',
    'Search',
    'Profile',
    'Setting'
  ];

  int currentIndex = 0;

  void changeIndex(index){
    currentIndex = index;
    emit(HomeIndex());
  }

}