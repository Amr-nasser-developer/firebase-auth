import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagirevisiontask/modules/bottomNavigtionScreens/courses/cubit/cubit.dart';
import 'package:softagirevisiontask/modules/bottomNavigtionScreens/courses/cubit/states.dart';
import 'package:softagirevisiontask/shared/Style/style.dart';
import 'package:softagirevisiontask/shared/color.dart';
import 'package:softagirevisiontask/shared/componads.dart';

class CourseScreen extends StatefulWidget
{
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  ScrollController controller = ScrollController();
  BuildContext blocContext;

  @override
  void initState()
  {
    super.initState();

    controller.addListener(()
    {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        print('bottom bottom');

        if(CourseCubit.get(blocContext).currentPage <= CourseCubit.get(blocContext).totalPages)
          CourseCubit.get(blocContext).getMoreCourse();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> CourseCubit()..getCourse(),
      child: BlocConsumer<CourseCubit , CourseStates>(
        listener: (context, state){},
        builder: (context, state){
          blocContext = context;
          var Courses = CourseCubit.get(context).Courses;
          return ConditionalBuilder(
            condition: state is! CourseLoading,
            builder: (context)=> ConditionalBuilder(
                condition: state is! CourseError,
                builder: (context) => ConditionalBuilder(
                    condition: Courses.length != 0,
                    builder: (context) => Scaffold(
                        body: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    defaultAppBarIcons(),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15.0,top: 15.0),
                                alignment: Alignment.topLeft,
                                child: defaultHeadText('Courses'),
                              ),
                              SizedBox(height:10.0),
                              Container(
                                height: 100,
                                child: ListView.separated(
                                  itemBuilder: (context,index)=>buildSearchItem(cat[index], context),
                                  separatorBuilder: (context,index)=>SizedBox(width: 10.0,),
                                  itemCount: cat.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                ),
                              ),

                              Expanded(
                                child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  controller: controller,
                                  padding: EdgeInsets.only(top: 20.0,),
                                  itemBuilder: (context, index) => buildCourseItem(Courses[index]),
                                  separatorBuilder: (context, index) => SizedBox(
                                    height: 20.0,
                                  ),
                                  itemCount: Courses.length,
                                ),
                              ),
                              SizedBox(height: 15.0,),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(),
                                  // if(state is! CourseLoadingMore && CourseCubit.get(context).currentPage <= CourseCubit.get(context).totalPages )
                                  // MaterialButton(
                                  //   color: defaultColor,
                                  //     child: Row(
                                  //       mainAxisSize: MainAxisSize.min,
                                  //       children: [
                                  //         Text('Load More', style: TextStyle(color: Colors.white),),
                                  //         Icon(Icons.arrow_downward_sharp),
                                  //       ],
                                  //     ),
                                  //     onPressed: (){
                                  //        if(CourseCubit.get(context).currentPage <= CourseCubit.get(context).totalPages)
                                  //        CourseCubit.get(context).getMoreCourse();
                                  //    },
                                  //  ),
                                  if(state is CourseLoadingMore)
                                  CircularProgressIndicator()
                                ],
                              )
                            ]
                        )),
                  fallback: (context)=> Center(child: Text('No Courses Yet', style: black20Bold(),),),
                ),
              fallback: (context)=> Center(child: Text('Error', style: black20Bold(),),),
            ),
            fallback: (context)=> Center(child: CircularProgressIndicator(),),
          );
        },
      ),
    );
  }
}

