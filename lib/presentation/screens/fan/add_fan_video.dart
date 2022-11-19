// ignore_for_file: use_build_context_synchronously

import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../../layouts/home_layout.dart';

class AddFanVideo extends StatelessWidget {
  const AddFanVideo({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is FanCreateVideoPostLoadingState) {
          AppCubit.get(context).getPosts();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeLayout()),
              (route) => false);
          // AppCubit.get(context).videoPlayerController!.dispose();
          //  AppCubit.get(context).videoPlayerController==null;
          //  AppCubit.get(context).videoPlayerController!.pause();
          // AppCubit.get(context).postVideo=null;
          AppCubit.get(context).currentIndex = 2;
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeLayout()), (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.myWhite,
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor1,
              title: Text('Add Video',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: AppColors.myWhite,
                      fontFamily: AppStrings.appFont)),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () async {
                  AppCubit.get(context).postVideo = null;
                  Navigator.pop(context);
                  await AppCubit.get(context).videoPlayerController!.pause();
                },
              ),
              actions: [
                state is BrowiseCreateVideoPostLoadingState ||
                        state is BrowiseGetPostsLoadingState ||
                        state is BrowiseUploadVideoPostLoadingState
                    ? Center(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor1,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (state is FanCreateVideoPostSuccessState) ||
                                (state is FanUploadVideoPostLoadingState) ||
                                (state is FanUploadVideoPostSuccessState)
                            ? CircularProgressIndicator(
                                backgroundColor: AppColors.navBarActiveIcon,
                              )
                            : defaultButton(
                                textColor: AppColors.primaryColor1,
                                width: size.width * .2,
                                height: size.height * .05,
                                raduis: 10,
                                function: () async {
                                  if (AppCubit.get(context).fanPostVideo ==
                                      null) {
                                    // print('fan video null');
                                  } else {
                                    const filesizeLimit =
                                        15000000; // in bytes // 30 Mega
                                    final filesize = await AppCubit.get(context)
                                        .fanPostVideo!
                                        .length(); // in bytes
                                    final isValidFilesize =
                                        filesize < filesizeLimit;
                                    if (isValidFilesize) {
                                      AppCubit.get(context).uploadFanPostVideo(
                                        timeSpam:
                                            DateTime.now().toUtc().toString(),
                                        time: DateFormat.Hm()
                                            .format(DateTime.now()),
                                        dateTime: DateFormat.yMMMd()
                                            .format(DateTime.now()),
                                        text: "",
                                        name: AppCubit.get(context)
                                            .userModel!
                                            .username,
                                      );
                                    } else {
                                      customToast(
                                          title: 'Max Video size is 30 Mb',
                                          color: Colors.red);
                                    }

                                    //AppCubit.get(context).getFanPosts();
                                  }
                                },
                                buttonText: 'add',
                                buttonColor: AppColors.myWhite)),
              ],
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/public_chat_image.jpeg'),
                fit: BoxFit.cover,
              )),
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if (state is CreatePostLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(height: 5),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children:  [
                      //     CircleAvatar(
                      //       backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                      //       radius: 30,
                      //     ),
                      //     SizedBox(width: 10,),
                      //     Expanded(
                      //       child:   Text('${AppCubit.get(context).userModel!.username}',
                      //         style: const TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.w500,
                      //             fontFamily: AppStrings.appFont
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      (AppCubit.get(context).fanPostVideo != null &&
                              AppCubit.get(context)
                                  .videoPlayerController!
                                  .value
                                  .isInitialized)
                          ? Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: size.width,
                                      child: AspectRatio(
                                        aspectRatio: AppCubit.get(context)
                                            .videoPlayerController!
                                            .value
                                            .aspectRatio,
                                        child: AppCubit.get(context)
                                                    .videoPlayerController ==
                                                null
                                            ? const SizedBox(
                                                height: 0,
                                              )
                                            : VideoPlayer(AppCubit.get(context)
                                                .videoPlayerController!),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: Text(
                                  'No Video Selected Yet',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor1,
                                    fontFamily: AppStrings.appFont,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  )),
            ));
      },
    );
  }
}
