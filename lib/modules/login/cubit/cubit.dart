import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagirevisiontask/modules/login/cubit/states.dart';
import 'package:softagirevisiontask/shared/remote/dio.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  Login({email , password}){
    emit(LoginLoading());
    DioHelper.postData(
        path: 'lms/oauth/token',
        data: {
          'grant_type':'password',
          'client_id':'1',
          'client_secret':'UFj2FJ7X2jQfSjtptUIadua4rb0yeZjKvVaS55T9',
          'username':'$email',
          'password':'$password',
        }
    ).then((value){
      emit(LoginSuccess(value.data['access_token']));
    }).catchError((e){
      emit(LoginError(e.toString()));
    });
  }

}