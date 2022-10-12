import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/screens/more_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/app_strings.dart';

Widget textFormFieldWidget(
    {
      context,
      required TextEditingController controller,
      required TextInputType inputType,
      required String labelText,
      required String errorMessage,
       Widget ?prefixIcon,
      Function ?function,
      int ?maxLines,
    }
    )=> Container(
  // height:MediaQuery.of(context).size.height*.07,
  child: TextFormField(

    style: TextStyle(
      color:AppColors.myGrey,
      fontFamily: AppStrings.appFont,
    ),
    keyboardType: inputType,
    controller: controller,
    onChanged: (value){
      function!;
    },
    decoration: InputDecoration(
      focusColor: AppColors.myGrey,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color:AppColors.myGrey),
        borderRadius: BorderRadius.circular(15),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color:AppColors.myGrey),
        borderRadius: BorderRadius.circular(15),
      ),
      hintText: '$labelText',
      hintStyle: TextStyle(
        color: AppColors.myGrey,
        fontFamily: AppStrings.appFont,
      ),
      prefixIcon: prefixIcon,
    ),
    maxLines: maxLines,
    validator: (value){
      if(value!.isEmpty){
        return'${errorMessage}';
      }
    },
  ),
);




Widget defaultButton({
  required double width,
  required double height,
  required Color buttonColor,
  required Color textColor,
  required String buttonText,
  required VoidCallback function,
   double raduis = 25,
  double fontSize=18,
})=>Container(

    height: height,
    width: width,
    decoration: BoxDecoration(
      color:buttonColor ,
      borderRadius: BorderRadius.circular(raduis),
    ),
    child:TextButton(
      onPressed:function,
      child:  Text('${buttonText}',style: TextStyle(
          color:textColor,
          fontFamily: AppStrings.appFont,
          fontWeight: FontWeight.w600,
          fontSize: fontSize
      ),
      ),
    )
);


Widget defaultSocialMediaButton({
  context,
  required Size size,
  required Color buttonColor,
  required String buttonText,
  required VoidCallback function,
  required String imagePath
})=>Container(

    height: size.height*(.05),
    width: size.width*(.4),
    decoration: BoxDecoration(
      color:buttonColor ,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppColors.myGrey)
    ),
    child:TextButton(
      onPressed:function,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${buttonText}',style: TextStyle(
              color: AppColors.myGrey,
             fontFamily: AppStrings.appFont,
              fontWeight: FontWeight.w700,
              fontSize: 14
          ),),
          SizedBox(width: MediaQuery.of(context).size.width*.02,),
         Image.asset('${imagePath}',width: 45,height: 45,),
        ],
      ),
    )
);


customAppbar(String title,context){

  return AppBar(
    systemOverlayStyle:  SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: AppColors.primaryColor1,
    ),
    iconTheme: IconThemeData(
        color: AppColors.myWhite
    ),
    backgroundColor: AppColors.primaryColor1,
    leading: IconButton(
      onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (_){
                return MoreScreen();
             }));
      },
      icon:Icon(Icons.menu,size: 30,color: AppColors.myGrey,)
    ),
    title: GestureDetector(
      onTap: (){
        AppCubit.get(context).currentIndex=0;
        Navigator.push(context, MaterialPageRoute(builder: (_){
          return HomeLayout();
        }));
      },
      child: Container(
        height: MediaQuery.of(context).size.height*1,
        width: MediaQuery.of(context).size.width*.25,
        child: Image(
          image: AssetImage('assets/images/ncolors.png'),
          height: 100,
          width: 100,

        ),
      ),
    ),
    centerTitle: true,
    elevation: 0.0,
    actions: [

    ],
  );
}

printMessage(String title){

  debugPrint(title);

}

customToast(
   {
     required String title,
     required Color color
   }
    ){

  Fluttertoast.showToast(
      msg: title,
      textColor: AppColors.myWhite,
      backgroundColor: color,
      gravity: ToastGravity.BOTTOM
  );

}

