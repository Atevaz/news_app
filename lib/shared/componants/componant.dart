
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../modules/news_app/web_view/web_view_Screen.dart';


Widget defualtBottun({
  double width = double.infinity,
  Color background = Colors.blue,
  double height = 50,
  Color textColor = Colors.white,
  required VoidCallback function,
  required String text,
}) => Container(
  width: width,
  color: background,
  height: height,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      '$text',
      style: TextStyle(
        color: textColor,
        fontSize: 20,
      ),
    ) ,
  ),
);

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap ,
  void Function()? suffixPressed,
  bool isPassword = false ,
  required String? Function(String?)? validate ,
  required String label,
  required IconData prefix,
  IconData? suffix,
}) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8),
  child:   TextFormField(
    controller: controller,
    keyboardType: type,
    onFieldSubmitted: onSubmit,
    validator: validate,
    onTap: onTap,
    obscureText: isPassword,
    onChanged: onChange,

    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      prefixIcon: Icon(prefix),
      suffixIcon: IconButton(
          onPressed: suffixPressed,
          icon: Icon(suffix)
      ),

    ),
  ),
);



Widget buildArticleItem (article,context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20),

    child: Row(

      children: [

        Container(

          width: 120,

          height: 120,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),

              image: DecorationImage(

                  image: NetworkImage('${article['urlToImage']}'),

                  fit: BoxFit.cover

              )

          ),

        ),

        SizedBox(width: 20,),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                      fontSize: 16,

                      color: Colors.grey

                  ),

                )

              ],

            ),

          ),

        )

      ],

    ),

  ),
);

Widget MyDivider () => Container(
  height: 1,
  width: double.infinity,
  color: Colors.grey[300],
);

Widget articleBuilder(list,context, {isSearch = false}) =>ConditionalBuilder(
  condition: list.length > 0 ,
  builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context , index) => buildArticleItem(list[index],context),
      separatorBuilder: (context , index) => MyDivider () ,
      itemCount: list.length),
  fallback: (context) => isSearch? Container() : Center(child: CircularProgressIndicator()) ,
);







void navigateTo (context , widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget  ,
    ),(route){
      return false;
}
);

void navigateToAndReplace (context , widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget  ,
    ),
);
