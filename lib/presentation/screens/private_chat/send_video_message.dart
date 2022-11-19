// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/shared_widgets.dart';

class SendVideoMessage extends StatelessWidget {
  String? userId;
  String? userImage;
  String? userName;
  SendVideoMessage(
      {super.key,
      required this.userId,
      required this.userImage,
      required this.userName});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        //  if(state is GetMessageSuccessState){
        // //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatDetails(userModel:widget.userModel,)),);
        //    Navigator.pop(context);
        //  }
        if (state is BrowiseUploadVideoPostSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.myWhite,
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
                    (AppCubit.get(context).postVideo3 != null)
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: size.height * .1),
                                  SizedBox(
                                    width: size.width,
                                    child: AspectRatio(
                                      aspectRatio: AppCubit.get(context)
                                              .controller!
                                              .value
                                              .size
                                              .width /
                                          AppCubit.get(context)
                                              .controller!
                                              .value
                                              .size
                                              .height,
                                      child: AppCubit.get(context).controller ==
                                              null
                                          ? const SizedBox(
                                              height: 0,
                                            )
                                          : CachedVideoPlayer(
                                              AppCubit.get(context)
                                                  .controller!),
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
                ),
              ),
            ),
            floatingActionButton: state is BrowiseUploadVideoPostLoadingState ||
                    state is BrowiseCreateVideoPostLoadingState
                ? FloatingActionButton(
                    onPressed: () {
                      // AppCubit.get(context).uploadPrivateVideo(
                      //     senderId: AppStrings.uId!,
                      //     dateTime: DateTime.now().toString(),
                      //     recevierId:userModel.uId!,
                      //     text: ""
                      // );
                    },
                    backgroundColor: AppColors.primaryColor1,
                    child: CircularProgressIndicator(
                        color: AppColors.navBarActiveIcon),
                  )
                : FloatingActionButton(
                    onPressed: () async {
                      const filesizeLimit = 15000000; // in bytes // 30 Mega
                      final filesize = await AppCubit.get(context)
                          .postVideo3!
                          .length(); // in bytes
                      final isValidFilesize = filesize < filesizeLimit;
                      if (isValidFilesize) {
                        AppCubit.get(context).uploadPrivateVideo(
                            senderId: AppStrings.uId!,
                            dateTime: DateTime.now().toUtc().toString(),
                            recevierId: userId!,
                            recevierImage: userImage!,
                            recevierName: userName!,
                            text: "");
                        // callFcmApiSendPushNotifications(
                        //     title: 'New Post Added',
                        //     description:postText.text,
                        //     imageUrl: "",
                        //     context: context
                        //
                        //   //  token:AppCubit.get(context).userToken
                        // );

                      } else {
                        customToast(
                            title: 'Max Video size is 15 Mb',
                            color: Colors.red);
                      }
                    },
                    backgroundColor: AppColors.primaryColor1,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ));
      },
    );
  }
}
