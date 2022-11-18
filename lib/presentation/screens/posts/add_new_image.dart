// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/data/services/notification_helper.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_strings.dart';

class AddNewImage extends StatefulWidget {
  const AddNewImage({super.key});

  @override
  State<AddNewImage> createState() => _AddNewImageState();
}

class _AddNewImageState extends State<AddNewImage> {
  TextEditingController postText = TextEditingController();

  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is BrowiseGetPostsLoadingState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeLayout()),
              (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.myWhite,
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor1,
              title: Text('Add new post',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: AppColors.myWhite,
                      fontFamily: AppStrings.appFont)),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  setState(() {
                    //AppCubit.get(context).postImage='';
                    //AppCubit.get(context).postImage=null;
                    // print('${AppCubit.get(context).postImage}');
                    Navigator.pop(context);
                  });
                },
              ),
              actions: [
                state is BrowiseUploadImagePostLoadingState ||
                        state is BrowiseGetPostsLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: defaultButton(
                            textColor: AppColors.primaryColor1,
                            width: size.width * .19,
                            height: size.height * .05,
                            raduis: 10,
                            function: () async {
                              if (AppCubit.get(context).postImage == null) {
                                AppCubit.get(context).createImagePost(
                                  time: DateFormat.Hm().format(DateTime.now()),
                                  timeSpam: DateTime.now().toUtc().toString(),
                                  dateTime:
                                      DateFormat.yMMMd().format(DateTime.now()),
                                  text: postText.text,
                                );
                                // notifyHelper.displayNotification(
                                //     title:'New Post',
                                //     body:'${postText.text}'
                                // );
                                // callFcmApiSendPushNotifications(
                                //   title: 'New Post Added',
                                //   description:postText.text,
                                //   imageUrl: "${AppCubit.get(context).postImage}",
                                //   context: context
                                //   //  token:AppCubit.get(context).userToken
                                // );
                              } else {
                                // AppCubit.get(context).createImagePost(
                                //   time: DateFormat.Hm().format(DateTime.now()),
                                //   timeSpam: DateTime.now().toString(),
                                //   dateTime: DateFormat.yMMMd().format(DateTime.now()),
                                //   text:postText.text,
                                //   postImage: AppCubit.get(context).userModel!.image
                                // );

                                const filesizeLimit =
                                    5000000; // in bytes // 30 Mega
                                final filesize = await AppCubit.get(context)
                                    .postImage!
                                    .length(); // in bytes
                                final isValidFilesize =
                                    filesize < filesizeLimit;
                                if (isValidFilesize) {
                                  AppCubit.get(context).uploadPostImage(
                                    dateTime: DateFormat.yMMMd()
                                        .format(DateTime.now()),
                                    time:
                                        DateFormat.Hm().format(DateTime.now()),
                                    timeSpam: DateTime.now().toUtc().toString(),
                                    text: postText.text,
                                    image:
                                        AppCubit.get(context).userModel!.image,
                                    name: AppCubit.get(context)
                                        .userModel!
                                        .username,
                                  );
                                  // notifyHelper.displayNotification(
                                  //     title:'New Post',
                                  //     body:'${postText.text}'
                                  // );
                                  //
                                  // callFcmApiSendPushNotifications(
                                  //     title: 'New Post Added',
                                  //     description:postText.text,
                                  //     imageUrl: "${AppCubit.get(context).postImage}",
                                  //     context: context
                                  //   //  token:AppCubit.get(context).userToken
                                  // );

                                } else {
                                  customToast(
                                      title: 'Max Image size is 5 Mb',
                                      color: Colors.red);
                                }
                              }
                              // print(DateFormat.Hms().format(DateTime.now()));
                            },
                            buttonText: 'post',
                            buttonColor: AppColors.myWhite),
                      )
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
                            Text(
                              '${AppCubit.get(context).userModel!.username}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppStrings.appFont),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .08,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            maxLines: 3,
                            controller: postText,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintMaxLines: 1,
                              hintText: 'Say someting about this photo.....',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        (AppCubit.get(context).postImage != null)
                            ? Expanded(
                                child: SizedBox(
                                  height: size.height,
                                  width: size.width,
                                  child: Align(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    child: Image(
                                      image: FileImage(
                                          AppCubit.get(context).postImage!),
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Center(
                                  child: Text(
                                    'No Photo Selected Yet',
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
              ],
            ));
      },
    );
  }
}
