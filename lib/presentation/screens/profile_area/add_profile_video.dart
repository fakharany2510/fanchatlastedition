import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/profile_area/profile_screen.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class AddProfileVideo extends StatelessWidget {
  const AddProfileVideo({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is ProfileCreateVideoPostSuccessState) {
          // AppCubit.get(context).videoPlayerController!.dispose();
          AppCubit.get(context).videoPlayerController == null;
          AppCubit.get(context).postVideo = null;
          // AppCubit.get(context).currentIndex=2;

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
              (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar: AppBar(
            backgroundColor: AppColors.myWhite,
            title: Text('Add Video',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor1,
                    fontFamily: AppStrings.appFont)),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                      child: (state is ProfileCreateVideoPostSuccessState) ||
                              (state is ProfileUploadVideoPostLoadingState) ||
                              (state is ProfileUploadVideoPostSuccessState)
                          ? CircularProgressIndicator(
                              backgroundColor: AppColors.navBarActiveIcon,
                            )
                          : defaultButton(
                              textColor: AppColors.myWhite,
                              width: size.width * .2,
                              height: size.height * .05,
                              raduis: 10,
                              function: () {
                                if (AppCubit.get(context).ProfilePostVideo ==
                                    null) {
                                  // print('fan video null');
                                } else {
                                  AppCubit.get(context).uploadProfilePostVideo(
                                    timeSpam: DateTime.now().toString(),
                                    time:
                                        DateFormat.Hm().format(DateTime.now()),
                                    dateTime: DateFormat.yMMMd()
                                        .format(DateTime.now()),
                                    text: "",
                                    name: AppCubit.get(context)
                                        .userModel!
                                        .username,
                                  );
                                }
                              },
                              buttonText: 'add',
                              buttonColor: AppColors.primaryColor1)),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is CreatePostLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${AppCubit.get(context).userModel!.image}'),
                      radius: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        '${AppCubit.get(context).userModel!.username}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppStrings.appFont),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                (AppCubit.get(context).ProfilePostVideo != null &&
                        AppCubit.get(context)
                            .videoPlayerController!
                            .value
                            .isInitialized)
                    ? Expanded(
                        child: SizedBox(
                          height: size.height,
                          width: size.width,
                          child: AspectRatio(
                            aspectRatio: AppCubit.get(context)
                                .videoPlayerController!
                                .value
                                .aspectRatio,
                            child:
                                AppCubit.get(context).videoPlayerController ==
                                        null
                                    ? const SizedBox(height: 0)
                                    : VideoPlayer(AppCubit.get(context)
                                        .videoPlayerController!),
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
            ),
          ),
        );
      },
    );
  }
}
