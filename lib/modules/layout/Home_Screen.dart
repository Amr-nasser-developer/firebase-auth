import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:softagirevisiontask/modules/layout/cubit/cubit.dart';
import 'package:softagirevisiontask/modules/layout/cubit/states.dart';
import 'package:softagirevisiontask/shared/color.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> HomeCubit(),
      child: BlocConsumer<HomeCubit , HomeStates>(
          listener: (context , state){},
          builder: (context , state){
            var currentIndex = HomeCubit.get(context).currentIndex;
            return Scaffold(
              body: HomeCubit.get(context).widgets[currentIndex],
              bottomNavigationBar: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0) ,
                    topRight: Radius.circular(25.0)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 15,
                    ),
                  ],
                ),

                child: BottomNavigationBar(
                  selectedItemColor: defaultColor,
                  unselectedItemColor: Colors.black,
                  currentIndex: currentIndex,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Ionicons.documents),
                        title: Text('Cousrse')
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(OMIcons.search),
                      title: Text('Search')
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Ionicons.person),
                        title: Text('Profile')
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Ionicons.settings),
                        title: Text('Settings')
                    ),
                  ],
                  onTap: (index){
                    HomeCubit.get(context).changeIndex(index);
                  },
                ),
              ),
            );
          },
          ),
    );
  }
}
