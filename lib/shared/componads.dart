import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softagirevisiontask/shared/Style/style.dart';
import 'package:softagirevisiontask/shared/color.dart';
class CategoryModel {
  String title;
  IconData icon;

  CategoryModel(this.title, this.icon);
}

List<CategoryModel> cat = [
  CategoryModel(
    'Mobile App',
    Icons.lightbulb_outline,
  ),
  CategoryModel(
    'UI & UX',
    Icons.lightbulb_outline,
  ),
  CategoryModel(
    'Front End',
    Icons.lightbulb_outline,
  ),
  CategoryModel(
    'Back End',
    Icons.lightbulb_outline,
  ),
  CategoryModel(
    'ML',
    Icons.lightbulb_outline,
  ),
  CategoryModel(
    'AI',
    Icons.lightbulb_outline,
  ),
  CategoryModel(
    'IOT',
    Icons.lightbulb_outline,
  ),
];

SharedPreferences pref;

Future<void> initPref()async{
  pref = await SharedPreferences.getInstance();
}
Future<bool> setToken(token)=> pref.setString('token',token);

String getToken()=> pref.getString('token');

Future<bool> deleteToken()=> pref.remove('token');

Widget defaultHeadText(String text)=>
  Text(text,style: TextStyle(fontSize: 30,));

Widget defaultButtomText(String text) =>
    Text(text,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),);


Widget defaultCaptionText(String text)=>
  Text(text , style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),);

Widget defaultDetailsText(String text)=>
    Text(text , style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),);

Widget defaultDetailsContainerText(String text)=>
    Text(text , style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),);

Widget defaultImage(String imageSourse)=>
  Image(image: AssetImage(imageSourse),color: Colors.white,height: 20.0,);

void navigateTo(context , widget) =>
  Navigator.push(context, MaterialPageRoute(builder: (context)=> widget));

void finishNavigate(context , widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget),
          (Route<dynamic> route) => false);
}


Widget defaultContainerLogo({String text , Icon ico,})=>
  Container(
    height: 150,
    width: 150,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Icon(ico.icon, color: Colors.white,),
          radius: 20.0,
        ),
        SizedBox(height: 7.0,),
        defaultCaptionText(text),
      ],
    ),
  );

Widget defaultAppBarIcons()=>
    Row(
      children: [
        Container(
          padding: EdgeInsets.only(top: 50),
          alignment: Alignment.topLeft,
          child: Icon(Icons.arrow_back_ios),
        ),
        Container(
          padding: EdgeInsets.only(top: 48, left: 280),
          alignment: Alignment.centerRight,
          child: Icon(Icons.notifications_none),
        ),
      ],
    );



Widget defaultBottomForm({String text, Function function}){
  return InkWell(
    onTap: function,
    child: Container(
      width: 320,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
          color: Colors.white
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0),
          child :Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              defaultButtomText(text),
            ],
          ),
    ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          )

        ],
      ),
    ),
  );
}

Widget defaultFlatButton({
  Function function,
  bool Uppar = true,
  String text,
  Color background = defaultColor,
  double radius = 5.0,
}){
 return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
    ),
    child: FlatButton(
        onPressed: function,
        color: background,
        child: Text(Uppar? text.toUpperCase() : text , style: TextStyle(color: Colors.white, fontSize: 15.0),)),
  );
}

Widget defaultFormText({
  @required String text,
  @required String hint,
  @required TextEditingController controller,
  @required TextInputType type,
  bool obscure =false,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.white,
      ),
      padding: EdgeInsetsDirectional.only(
        top: 10,
        end: 10,
        start: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(text != null) defaultDetailsText(text),
          TextFormField(
            controller: controller,
            keyboardType: type,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
            ),
            obscureText: obscure,
          )
        ],
      ),
    );

void buildProgress({
  context,
  text,
  bool error = false,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
               if(!error) CircularProgressIndicator(),
                if(!error)
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Text(
                    text,
                  ),
                ),
              ],
            ),
            if(error)
            SizedBox(height: 15.0,),
            if(error)
            defaultFlatButton(
              text: 'cancel',
              function: (){Navigator.pop(context);},
            ),
          ],
        ),
      ),
    );

void showToast({@required text , @required error})=>
    Fluttertoast.showToast(
        msg: text.toString() ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: error? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );

Widget buildCourseItem(Course) => Padding(
  padding: EdgeInsets.symmetric(horizontal: 20.0,),
  child: Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0,),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 10,
        ),
      ],
    ),
    padding: EdgeInsets.symmetric(vertical: 5.0,),
    child: ExpansionTileCard(
      baseColor: Colors.white,
      expandedColor: Colors.white,
      elevation: 0.0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(Course['image']),
            radius: 25.0,
            backgroundColor: Colors.deepPurple,
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        Course['title'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: black16Bold(),
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: 4.5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 10.0,
                      ignoreGestures: true,
                      itemPadding: EdgeInsets.zero,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating)
                      {
                        print(rating);
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${Course['description']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: grey14(),
                ),
              ],
            ),
          ),
        ],
      ),
      onExpansionChanged: (value)
      {

      },
      children: <Widget>[
        Text('test'),
      ],
    ),
  ),
);


Widget buildSearchItem(CategoryModel model , context)=> GestureDetector(
  child:   Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Icon(model.icon, color: Colors.white,),
          radius: 20.0,
        ),
        SizedBox(height: 7.0,),
        defaultCaptionText(model.title),
      ],
    ),
  ),
);
