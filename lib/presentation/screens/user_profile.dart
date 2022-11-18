// ignore_for_file: must_be_immutable

import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/presentation/screens/another_chat_details.dart';
import 'package:fanchat/presentation/widgets/user_profile_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../widgets/shared_widgets.dart';

class UserProfile extends StatelessWidget {
  String userId;
  String userImage;
  String userName;

  UserProfile({
    super.key,
    required this.userId,
    required this.userImage,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is SendUserReportSuccessState) {
          customToast(
              title: 'Report has been sent to admins',
              color: AppColors.navBarActiveIcon);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: customAppbar('Profile', context),
          backgroundColor: AppColors.primaryColor1,
          body: cubit.userModel != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      //profile
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
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
                                          image: NetworkImage(
                                              'https://img.freepik.com/free-vector/football-player-with-ball-stadium-with-france-flags-background-vector-illustration_1284-16438.jpg?w=740&t=st=1659099057~exp=1659099657~hmac=a0bb3dcd21329344cdeb6394401b201a4062c653f424a245c7d32e2358df63e4'),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 57,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(userImage),
                                  radius: 55,
                                ),
                              ),
                              Positioned(
                                right: MediaQuery.of(context).size.height * .16,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return AntherChatDetails(
                                          userId: userId,
                                          userImage: userImage,
                                          userName: userName);
                                    }));
                                  },
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: AppColors.myWhite,
                                    child: CircleAvatar(
                                      radius: 15,
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
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                                color: AppColors.myWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppStrings.appFont),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 15,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.toFacebook(facebookLink: cubit.profileFace);
                            },
                            child: const Image(
                              height: 35,
                              width: 35,
                              image: AssetImage('assets/images/facebook.png'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              cubit.toInstagram(
                                  instagramLink: cubit.profileInstagram);
                            },
                            child: const Image(
                              height: 30,
                              width: 30,
                              image: AssetImage('assets/images/instagram.png'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              cubit.toTwitter(
                                  twitterLink: cubit.profileTwitter);
                            },
                            child: const Image(
                              height: 35,
                              width: 35,
                              image: AssetImage('assets/images/twitter.png'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              cubit.toYoutube(
                                  youtubeLink: cubit.profileYoutube);
                            },
                            child: const Image(
                              height: 35,
                              width: 35,
                              image: AssetImage('assets/images/youtube.png'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Stack(
                          children: [
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              childAspectRatio: 1 / 1.3,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              crossAxisCount: 3,
                              children: List.generate(
                                  AppCubit.get(context)
                                      .userProfileImages
                                      .length,
                                  (index) => UserProfileAreaWidget(
                                        index: index,
                                      )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.red,
            label: const Text(
              'Report User',
              style: TextStyle(fontFamily: AppStrings.appFont),
            ),
            icon: const Icon(Icons.report),
            onPressed: () {
              AppCubit.get(context).sendUserReport(
                  senderReportId: AppCubit.get(context).userModel!.uId!,
                  senderReportName: AppCubit.get(context).userModel!.username!,
                  senderReportImage: AppCubit.get(context).userModel!.image!,
                  userId: userId,
                  userName: userName,
                  userImage: userImage);
            },
          ),
        );
      },
    );
  }
}
