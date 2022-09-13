import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/presentation/screens/another_match_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../widgets/shared_widgets.dart';
class UserProfile extends StatelessWidget {

  String userId;
  String userImage;
  String userName;
  UserProfile({Key? key,
    required this.userId,
    required this.userImage,
    required this.userName
  }) : super(key: key);

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
                                image: const DecorationImage(
                                    image: NetworkImage('https://img.freepik.com/free-vector/football-player-with-ball-stadium-with-france-flags-background-vector-illustration_1284-16438.jpg?w=740&t=st=1659099057~exp=1659099657~hmac=a0bb3dcd21329344cdeb6394401b201a4062c653f424a245c7d32e2358df63e4'),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 57,
                          child: CircleAvatar(
                            backgroundImage:NetworkImage(userImage),
                            radius: 55,
                          ),
                        ),
                        Positioned(
                          right: 100,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_){
                                return AntherChatDetails(userId: userId, userImage: userImage, userName: userName);
                              }));
                            },
                            child: CircleAvatar(
                              radius: 19,
                              backgroundColor: AppColors.myWhite,

                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: AppColors.primaryColor1,
                                child: Icon(
                                  Icons.message,
                                  color: AppColors.myWhite,
                                  size: 22,
                                ),
                              ),
                            ),
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
                    Text(userName,
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

                const SizedBox(height:10,),

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
                )
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