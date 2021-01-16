import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:softagirevisiontask/modules/bottomNavigtionScreens/profile/cubit/states.dart';

class ProfileCubit extends Cubit<ProfileStates>{
  ProfileCubit() : super(ProfileInitial());

 static ProfileCubit get(context) => BlocProvider.of(context);

  static File images;

  void pickImage() async{
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    images = image;
    emit(ProfileLoading());

  }

}