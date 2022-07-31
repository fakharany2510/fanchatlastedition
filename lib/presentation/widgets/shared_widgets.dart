import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget textFormFieldWidget(
{
  context,
 required TextEditingController controller,
 required TextInputType inputType,
 required String labelText,
 required String errorMessage,
 required IconData prefixIcon
}
    )=>Container(
  // height:MediaQuery.of(context).size.height*.07,
      child: TextFormField(
    style: TextStyle(
        color:AppColors.primaryColor1
  ),
  keyboardType: inputType,
  controller: controller,
  decoration: InputDecoration(
      focusColor: AppColors.primaryColor1,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color:AppColors.primaryColor1),
        borderRadius: BorderRadius.circular(25),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color:AppColors.primaryColor1),
        borderRadius: BorderRadius.circular(15),
      ),
      hintText: '$labelText',
      hintStyle: TextStyle(
      color: AppColors.primaryColor1
    //fontFamily: AppStrings.appFont,
       ),
      prefixIcon: Icon(prefixIcon,color:AppColors.primaryColor1),
  ),
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
  required String buttonText,
  required VoidCallback function,
  double fontSize=18,
})=>Container(

    height: height,
    width: width,
    decoration: BoxDecoration(
      color:buttonColor ,
      borderRadius: BorderRadius.circular(25),
    ),
    child:TextButton(
      onPressed:function,
      child:  Text('${buttonText}',style: TextStyle(
          color: AppColors.myWhite,
          //fontFamily: AppStrings.appFont,
          fontWeight: FontWeight.w500,
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
      border: Border.all(color: AppColors.primaryColor1)
    ),
    child:TextButton(
      onPressed:function,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${buttonText}',style: TextStyle(
              color: AppColors.primaryColor1,
             // fontFamily: AppStrings.appFont,
              fontWeight: FontWeight.w700,
              fontSize: 14
          ),),
          SizedBox(width: MediaQuery.of(context).size.width*.02,),
         Image.asset('${imagePath}',width: 45,height: 45,),
        ],
      ),
    )
);


customAppbar(String title){

  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ),
    iconTheme: IconThemeData(
        color: AppColors.primaryColor1
    ),
    backgroundColor: AppColors.myWhite,
    title: Text(title,style: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryColor1
    ),),
    // centerTitle: true,
    elevation: 0.0,
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


