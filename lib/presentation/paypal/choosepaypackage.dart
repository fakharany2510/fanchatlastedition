import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/paypal/advertise.dart';
import 'package:fanchat/presentation/paypal/googlepay/advertise_google_pay.dart';
import 'package:fanchat/presentation/paypal/googlepay/premium_google_pay.dart';
import 'package:fanchat/presentation/paypal/premiumpackage.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';

class ChoosePayPackage extends StatefulWidget {
  const ChoosePayPackage({Key? key}) : super(key: key);

  @override
  State<ChoosePayPackage> createState() => _ChoosePayPackageState();
}

class _ChoosePayPackageState extends State<ChoosePayPackage> {
  int _value=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor1,
      appBar: customAppbar('Profile',context),
      body: Padding(
        padding: EdgeInsets.only(bottom: 15,left: 10,top: 25),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15,bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Please select your package',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: AppStrings.appFont,
                    color: AppColors.myGrey
                  ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 10),
                  child: Container(
                    height: 20,
                    width:20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child:Radio(
                        value: 1,
                        groupValue: _value,
                        onChanged: (value){
                          setState((){
                            _value=1;
                          });
                        }),
                  ),
                ),
                const Image(image: AssetImage('assets/images/premium.webp'),
                  height: 50,
                  width: 50,
                ),
                SizedBox(width: 20,),
                Column(
                  children: [
                    Text('Premium Package',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: AppStrings.appFont,
                          color: AppColors.myWhite
                      ),
                    ),
                    SizedBox(height:5,),
                    Text('20 \$ for 1 year',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppStrings.appFont,
                          color: AppColors.myGrey
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 10),
                  child: Container(
                    height: 20,
                    width:20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child:Radio(

                        value: 2,
                        groupValue: _value,
                        onChanged: (value){
                          setState((){
                            _value=2;
                          });
                        }),
                  ),
                ),
                const Image(image: AssetImage('assets/images/business.png'),
                  height: 50,
                  width: 50,
                ),
                SizedBox(width: 20,),
                Column(
                  children: [
                    Text('Advertising Package',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: AppStrings.appFont,
                          color: AppColors.myWhite
                      ),
                    ),
                    SizedBox(height:5,),
                    Text('200 \$ forever',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppStrings.appFont,
                          color: AppColors.myGrey
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Center(

              child: defaultButton(width: MediaQuery.of(context).size.width*.7,
                  height: MediaQuery.of(context).size.height*.05,
                  buttonColor: AppColors.myGrey,
                  textColor:AppColors.primaryColor1,
                  buttonText: 'Pay',
                  function: (){
                    if(_value==1){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PremiumGooglePay()));
                    }
                    if(_value==2){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AdvertiseGooglePay()));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
