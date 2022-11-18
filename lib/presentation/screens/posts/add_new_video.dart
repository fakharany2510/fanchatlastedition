// ignore_for_file: use_build_context_synchronously

import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_strings.dart';
import '../../layouts/home_layout.dart';

class AddNewVideo extends StatefulWidget {
  const AddNewVideo({super.key});

  @override
  State<AddNewVideo> createState() => _AddNewVideoState();
}

class _AddNewVideoState extends State<AddNewVideo> {
  //const AddNewVideo({super.key}) ;

  // var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // notifyHelper = NotifyHelper();
    // notifyHelper.initializeNotification();
    // notifyHelper.requestIOSPermissions();
  }

  TextEditingController postText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is BrowiseCreateVideoPostLoadingState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeLayout()),
              (route) => false);
          AppCubit.get(context).videoPlayerController!.pause();
          // AppCubit.get(context).postVideo=null;

        }
        if (state is PickPostVideoSuccessState) {
          AppCubit.get(context).videoPlayerController!.pause();
        }
        // if(state is BrowiseCreateVideoPostSuccessState){AppCubit.get(context).controller!.pause();}
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.myWhite,
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor1,
              title: Text('Add New post',
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
                            color: AppColors.myWhite,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: defaultButton(
                            textColor: AppColors.primaryColor1,
                            width: size.width * .2,
                            height: size.height * .05,
                            raduis: 10,
                            function: () async {
                              if (AppCubit.get(context).postVideo == null) {
                                AppCubit.get(context).createVideoPost(
                                    timeSpam: DateTime.now().toUtc().toString(),
                                    time:
                                        DateFormat.Hm().format(DateTime.now()),
                                    dateTime: DateFormat.yMMMd()
                                        .format(DateTime.now()),
                                    text: postText.text);
                              } else {
                                AppCubit.get(context).controller!.pause();
                                const filesizeLimit = 15000000;
                                // in bytes // 30 Mega
                                final filesize = await AppCubit.get(context)
                                    .postVideo!
                                    .length(); // in bytes
                                final isValidFilesize =
                                    filesize < filesizeLimit;
                                if (isValidFilesize) {
                                  AppCubit.get(context).uploadPostVideo(
                                    timeSpam: DateTime.now().toUtc().toString(),
                                    time:
                                        DateFormat.Hm().format(DateTime.now()),
                                    dateTime: DateFormat.yMMMd()
                                        .format(DateTime.now()),
                                    text: postText.text,
                                    name: AppCubit.get(context)
                                        .userModel!
                                        .username,
                                  );
                                } else {
                                  customToast(
                                      title: 'Max Video size is 15 Mb',
                                      color: Colors.red);
                                }
                              }
                            },
                            buttonText: 'post',
                            buttonColor: AppColors.myWhite),
                      ),
              ],
            ),
            body: Stack(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Opacity(
                      opacity: 1,
                      child: Image(
                        image:
                            AssetImage('assets/images/public_chat_image.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    )),
                Padding(
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
                                    color: Colors.white,
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
                        SingleChildScrollView(
                          child: TextFormField(
                            controller: postText,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Say something about this video.....',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        (AppCubit.get(context).postVideo != null &&
                                AppCubit.get(context)
                                    .controller!
                                    .value
                                    .isInitialized)
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .55,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  heightFactor: 1,
                                  widthFactor: 1,
                                  child: AspectRatio(
                                    aspectRatio: AppCubit.get(context)
                                            .controller!
                                            .value
                                            .aspectRatio *
                                        1,
                                    child: AppCubit.get(context).controller ==
                                            null
                                        ? const SizedBox(
                                            height: 0,
                                          )
                                        : CachedVideoPlayer(
                                            AppCubit.get(context).controller!),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Center(
                                    child: Text('No Video Selected Yet',
                                        style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryColor1,
                                            fontFamily: AppStrings.appFont,),),),),
                        const Spacer(),
                      ],
                    )),
              ],
            ));
      },
    );
  }
}
