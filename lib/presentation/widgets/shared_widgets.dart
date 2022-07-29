import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  height:MediaQuery.of(context).size.height*.07,
      child: TextFormField(
  style: TextStyle(
        color:AppColors.primaryColor
  ),
  keyboardType: inputType,
  controller: controller,
  decoration: InputDecoration(
      focusColor: AppColors.primaryColor,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color:AppColors.primaryColor),
        borderRadius: BorderRadius.circular(15),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color:AppColors.primaryColor),
        borderRadius: BorderRadius.circular(15),
      ),
      label: Text('${labelText}',style: TextStyle(
        color: AppColors.primaryColor
        //fontFamily: AppStrings.appFont,
      ),),
      prefixIcon: Icon(prefixIcon,color:AppColors.primaryColor),
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
  required VoidCallback function
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
          fontSize: 18
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
      border: Border.all(color: AppColors.primaryColor)
    ),
    child:TextButton(
      onPressed:function,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${buttonText}',style: TextStyle(
              color: AppColors.primaryColor,
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
        color: AppColors.primaryColor
    ),
    backgroundColor: AppColors.myWhite,
    title: Text(title,style: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryColor
    ),),
    titleSpacing: 0,
    // centerTitle: true,
    elevation: 0.0,
  );



}


printMessage(String title){

  debugPrint(title);

}


