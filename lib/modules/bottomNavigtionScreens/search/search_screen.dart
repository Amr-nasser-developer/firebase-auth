import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagirevisiontask/modules/bottomNavigtionScreens/search/cubit/cubit.dart';
import 'package:softagirevisiontask/modules/bottomNavigtionScreens/search/cubit/states.dart';
import 'package:softagirevisiontask/shared/color.dart';
import 'package:softagirevisiontask/shared/componads.dart';

class SearchScreen extends StatefulWidget
{
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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

        if(SearchCubit.get(blocContext).currentPages <= SearchCubit.get(blocContext).totalPages)
          SearchCubit.get(blocContext).searchCourseMore(searchController.text);
      }
    });
  }
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
            return BlocProvider(
              create: (BuildContext context)=> SearchCubit(),
              child: BlocConsumer< SearchCubit , SearchStates >(
                listener: (context , state){},
                builder: (context , state){
                  blocContext = context;
                  var Searchs = SearchCubit.get(context).search;
                  return Column(
                      children : [
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
                          child: defaultHeadText('Searchs'),
                        ),
                        SizedBox(height:10.0),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                              color: Colors.white,
                            ),
                            padding: EdgeInsetsDirectional.only(
                              start: 20.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search ...',
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Container(
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      15.0,
                                    ),
                                    color: defaultColor,
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: MaterialButton(
                                    height: 50.0,
                                    onPressed: () {
                                      SearchCubit.get(context).searchCourse(searchController.text);
                                    },
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 100.0,
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: 20.0,
                        //   ),
                        //   child: ListView.separated(
                        //     physics: BouncingScrollPhysics(),
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (context, index) => buildSearchItem(cat[index], context),
                        //     separatorBuilder: (context, index) => SizedBox(
                        //       width: 10.0,
                        //     ),
                        //     itemCount: cat.length,
                        //   ),
                        // ),
                        SizedBox(height: 35.0,),
                        Expanded(
                          child: ConditionalBuilder(
                                  condition: state is! SearchLoading,
                                  builder: (context)=> ConditionalBuilder(
                                      condition: Searchs.length > 0,
                                      builder: (context)=> Column(
                                        children: [
                                          Expanded(
                                            child: ListView.separated(
                                              controller: controller,
                                              padding: EdgeInsets.only(top: 20.0,),
                                              itemBuilder: (context, index) => buildCourseItem(Searchs[index]),
                                              separatorBuilder: (context, index) => SizedBox(
                                                height: 20.0,
                                              ),
                                              itemCount: Searchs.length,
                                            ),
                                          ),
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(),
                                              if(state is SearchLoadingMore)
                                                CircularProgressIndicator(),
                                            ],
                                          )
                                        ],
                                      ),
                                      fallback: (context)=> Center(child: Text('Search'),),
                                    ),
                                  fallback: (context)=> Center(child: CircularProgressIndicator(),),
                                ),
                        )
                      ]
                  );
                },
              ),
            );
  }
}

