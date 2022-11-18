import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/paypal/choosepaypackage.dart';
import 'package:fanchat/presentation/screens/profile_area/add_profile_image.dart';
import 'package:fanchat/presentation/screens/profile_area/add_profile_video.dart';
import 'package:fanchat/presentation/widgets/profile_area_widget.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is PickProfilePostImageSuccessState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddProfileImage()));
        }
        if (state is PickProfilePostVideoSuccessState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddProfileVideo()));
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
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${cubit.userModel!.cover}'),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 57,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        '${cubit.userModel!.image}'),
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
                          children: [
                            Text(
                              '${cubit.userModel!.username}',
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
                          height: 7,
                        ),
                        if (cubit.userModel!.bio != 'Enter your bio')
                          Text(
                            '${cubit.userModel!.bio}',
                            style: TextStyle(
                                color: AppColors.myWhite,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppStrings.appFont),
                            textAlign: TextAlign.center,
                          ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                cubit.toFacebook(
                                    facebookLink: cubit
                                        .changeFacebookLinkController.text);
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
                                    instagramLink: cubit
                                        .changeInstagramLinkController.text);
                              },
                              child: const Image(
                                height: 30,
                                width: 30,
                                image:
                                    AssetImage('assets/images/instagram.png'),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                cubit.toTwitter(
                                    twitterLink:
                                        cubit.changeTwitterLinkController.text);
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
                                    youtubeLink:
                                        cubit.changeYoutubeLinkController.text);
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
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            defaultButton(
                                textColor: Colors.white,
                                buttonText: 'Edit Profile',
                                buttonColor: const Color(0Xffd32330),
                                height: size.height * .06,
                                width: size.width * .68,
                                function: () {
                                  cubit.getUserWithId(context, AppStrings.uId!);
                                  Navigator.pushNamed(context, 'edit_profile');
                                }),
                            const Spacer(),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // cubit.toPayPal();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ChoosePayPackage()));
                                  },
                                  child: const CircleAvatar(
                                    radius: 29,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          'assets/images/usedpay.png'),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Buy a Package',
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
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
                                    AppCubit.get(context).profileImages.length,
                                    (index) => ProfileAreaWidget(
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
            floatingActionButton: SpeedDial(
              backgroundColor: AppColors.navBarActiveIcon,
              animatedIcon: AnimatedIcons.menu_close,
              elevation: 1,
              overlayColor: AppColors.myWhite,
              overlayOpacity: 0.0001,
              children: [
                SpeedDialChild(
                    onTap: () {
                      AppCubit.get(context).pickProfilePostVideo();
                    },
                    child:
                        const Icon(Icons.video_camera_back, color: Colors.red),
                    backgroundColor: AppColors.myWhite),
                SpeedDialChild(
                  onTap: () {
                    AppCubit.get(context).pickProfilePostImage();
                  },
                  child: const Icon(
                    Icons.image,
                    color: Colors.green,
                  ),
                  backgroundColor: AppColors.myWhite,
                ),
              ],
            ));
      },
    );
  }
}
