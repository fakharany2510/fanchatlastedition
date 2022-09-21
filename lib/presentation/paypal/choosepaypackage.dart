import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/paypal/businesspackage.dart';
import 'package:fanchat/presentation/paypal/premiumpackage.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';

class ChoosePayPackage extends StatefulWidget {
  const ChoosePayPackage({Key? key}) : super(key: key);

  @override
  State<ChoosePayPackage> createState() => _ChoosePayPackageState();
}

class _ChoosePayPackageState extends State<ChoosePayPackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor1,
      appBar: customAppbar('Profile',context),
      body: Padding(
        padding: EdgeInsets.only(top: 30,left: 10,right: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Please Choose Your Package',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: AppStrings.appFont,
                  color: AppColors.myGrey
                ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.1,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessPackage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  const Image(image: AssetImage('assets/images/premium.webp'),
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(width: 20,),
                  Column(
                    children: [
                      Text('Premium Package',
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: AppStrings.appFont,
                            color: AppColors.myWhite
                        ),
                      ),
                      SizedBox(height:5,),
                      Text('20 \$ for 1 year',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppStrings.appFont,
                            color: AppColors.myGrey
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*.4,
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(width: 3,),
                Text("or",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18
                ),
                ),
                SizedBox(width: 3,),
                Container(
                  width: MediaQuery.of(context).size.width*.4,
                  height: 1,
                  color: Colors.grey,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.1,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessPackage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  const Image(image: AssetImage('assets/images/business.png'),
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(width: 20,),
                  Column(
                    children: [
                      Text('Business Package',
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: AppStrings.appFont,
                            color: AppColors.myWhite
                        ),
                      ),
                      SizedBox(height:5,),
                      Text('200 \$ forever',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppStrings.appFont,
                            color: AppColors.myGrey
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
  }
}
