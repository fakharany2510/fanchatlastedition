import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/presentation/paypal/choosepaymentmethod.dart';
import 'package:fanchat/presentation/paypal/choosepaypackage.dart';
import 'package:fanchat/presentation/paypal/businesspackage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../widgets/shared_widgets.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
      builder: (context,state){
          var cubit=AppCubit.get(context);
          return Scaffold(
            appBar: customAppbar('Profile',context),
            backgroundColor: AppColors.primaryColor1,
            body: cubit.userModel !=null?SingleChildScrollView(
              child: Column(
                children: [
                  //profile
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      child: Stack(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  image: DecorationImage(
                                      image: NetworkImage('${cubit.userModel!.cover}'),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 57,
                            child: CircleAvatar(
                              backgroundImage:NetworkImage('${cubit.userModel!.image}'),
                              radius: 55,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),
                  //name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text('${cubit.userModel!.username}',
                        style:  TextStyle(
                            color: AppColors.myWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppStrings.appFont
                        ),
                      ),
                      const SizedBox(width: 5,),
                      const Icon(Icons.check_circle,color: Colors.blue,size:15,),
                    ],
                  ),
                  const SizedBox(height:7,),
                  Text('${cubit.userModel!.bio}',
                    style:  TextStyle(
                        color: AppColors.myWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppStrings.appFont
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      GestureDetector(
                        onTap: (){
                          cubit.toFacebook(facebookLink: cubit.changeFacebookLinkController.text);
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Image(
                            height: 35,
                            width: 35,
                            image: AssetImage('assets/images/facebook.png'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          cubit.toInstagram(instagramLink: cubit.changeInstagramLinkController.text);
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Image(
                            height: 30,
                            width: 30,
                            image: AssetImage('assets/images/instagram.png'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          cubit.toTwitter(twitterLink: cubit.changeTwitterLinkController.text);

                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Image(
                            height: 35,
                            width: 35,
                            image: AssetImage('assets/images/twitter.png'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          cubit.toYoutube(youtubeLink: cubit.changeYoutubeLinkController.text);

                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Image(
                            height: 35,
                            width: 35,
                            image: AssetImage('assets/images/youtube.png'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                    ],
                  ),

                  const SizedBox(height:10,),

                  Row(
                    children: [
                      const SizedBox(width: 20,),
                      defaultButton(
                          textColor: AppColors.primaryColor1,
                          buttonText: 'Edit Profile',
                          buttonColor: AppColors.myGrey,
                          height: size.height*.06,
                          width: size.width*.68,
                          function: (){
                            cubit.getUser();
                            Navigator.pushNamed(context, 'edit_profile');
                          }
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: (){
                         // cubit.toPayPal();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChoosePaymentMethod()));
                        },
                        child: const CircleAvatar(
                          radius: 29,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: AssetImage('assets/images/pay.png'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15,)
                    ],
                  ),
                  const SizedBox(height: 15,),
                  GridView.count(
                    shrinkWrap: true,
                    childAspectRatio: 1/1.3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    crossAxisCount: 3,
                    children: List.generate(
                        cubit.fanImages.length, (index) => Column(
                      children: [
                        Stack(
                          children: [
                            Image(
                              height: MediaQuery.of(context).size.height*.2,
                              fit: BoxFit.cover,
                              image: NetworkImage('${cubit.fanImages[index]}'),
                            ),

                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                  onPressed: (){
                                  },
                                  icon:Icon(Icons.image,color: AppColors.myWhite,)
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                  ),
                ],
              ),
            ):const Center(
              child: CircularProgressIndicator(),
            ),
          );
      },
    );
  }
}
