import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

 navigateAndFinish(context,Widget)=>Navigator.pushAndRemoveUntil(
context, MaterialPageRoute(builder: (context) => Widget),
(route) {
return false;
});

 navigateTo(context,Widget)=>Navigator.push(context,
MaterialPageRoute(builder:(context)=>Widget));

 defaultFormField({
  TextStyle ? style,
  required String ? labeltext,
  TextStyle ? labelstyle,
 required IconData ? prefixicon,
  IconData ? suffixicon,
   VoidCallback? suffixpressed,
  Color ? fillcolor,
  bool ? filled,
   required TextEditingController ? controller,
  required  TextInputType ? keyboardtype,
   required bool  obscuretext,
   ValueChanged<String> ? onSubmit,
   required FormFieldValidator<String> ? validate,
   required BorderRadius borderradius,
   required BorderSide borderside,

})=>TextFormField(
  style:style,
  decoration:InputDecoration(
    enabledBorder:OutlineInputBorder(
      borderRadius:borderradius ,
      borderSide:borderside
),
   labelText:labeltext,
   labelStyle:labelstyle,
   prefixIcon:Icon(prefixicon),
   suffixIcon: suffixicon!=null?IconButton(
       onPressed:suffixpressed, icon:Icon(suffixicon)):null,
   fillColor:fillcolor,
   filled:filled,
  ),

  controller:controller,
  keyboardType:keyboardtype,
  obscureText:obscuretext,
  onFieldSubmitted:onSubmit,
  validator:validate ,
 );

 defaultMaterialButton({
  required VoidCallback? onpressed,
   String? text,
   TextStyle? style,
   ShapeBorder?shape,
   Color? color,
   double?minwidth,
   double? height,
})=>MaterialButton(
   onPressed:onpressed,
   child:Text(
     text!.toUpperCase(),
   style:style ,
   ),
   shape:shape,
   color:color,
   minWidth:minwidth ,
   height:height,


 );


void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}



Widget buildListProduct(
    model,
    context, {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 14.0,
                          backgroundColor:
                          ShopCubit.get(context).favorites[model.id]
                              ? defaultColor
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );