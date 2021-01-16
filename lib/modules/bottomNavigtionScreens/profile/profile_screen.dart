import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:softagirevisiontask/modules/bottomNavigtionScreens/profile/cubit/states.dart';
import 'package:softagirevisiontask/shared/componads.dart';

import 'cubit/cubit.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ProfileCubit(),
      child: BlocConsumer<ProfileCubit,ProfileStates>(
        listener: (context, state){},
        builder: (context, state){
          return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [defaultAppBarIcons()],
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 72,
                          foregroundColor: Colors.deepPurple,
                          backgroundColor: Colors.deepPurple,
                          child: CircleAvatar(
                              backgroundImage: ProfileCubit.images != null
                                  ? FileImage(ProfileCubit.images)
                                  : AssetImage('assets/images/jemy.jpeg'),
                              radius: 70.0,
                              backgroundColor: Colors.white),
                        ),
                        // RaisedButton(
                        //   color: Colors.deepPurple,
                        //   onPressed: () {
                        //     ProfileCubit.get(context).pickImage();
                        //   },
                        //   child: Text('Pick Image',style: TextStyle(color: Colors.white),),
                        // ),
                        defaultHeadText('Jemy'),
                        defaultCaptionText('Muhamed@gmail.com'),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 21.0),
                      child: Row(
                        children: [
                          defaultContainerLogo(
                              text: 'My Courses', ico: Icon(Ionicons.reorder_four)),
                          SizedBox(
                            width: 18.0,
                          ),
                          defaultContainerLogo(
                              text: 'My Favourites', ico: Icon(Icons.favorite_border)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 19.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 21.0),
                      child: Row(
                        children: [
                          defaultContainerLogo(text: 'My Cart', ico: Icon(Ionicons.cart)),
                          SizedBox(
                            width: 18.0,
                          ),
                          defaultContainerLogo(
                              text: 'My Reviews', ico: Icon(Icons.star_half)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 19.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 21.0),
                      child: Row(
                        children: [
                          defaultContainerLogo(
                              text: 'Invite a friend', ico: Icon(Ionicons.share)),
                          SizedBox(
                            width: 18.0,
                          ),
                          defaultContainerLogo(
                              text: 'Help & Support', ico: Icon(Icons.help_outline)),
                          SizedBox(height: 20.0,)
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
