// ignore_for_file: prefer_typing_uninitialized_variables, unused_field

import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/services/notification_helper.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/notifications/functions/send_notification.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddTextPost extends StatefulWidget {
  const AddTextPost({super.key});

  @override
  State<AddTextPost> createState() => _AddTextPostState();
}

class _AddTextPostState extends State<AddTextPost> {
  TextEditingController postText = TextEditingController();
  var formKey = GlobalKey<FormState>();

  var notifyHelper;
  bool textFormFielsChanged = false;
  bool isbuttonDisabled = false;
  int increaseNumberOfPosts = 0;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    // _fcm.getToken().then((token) =>{
    // //   print('token =====> ${token}'),
    // FirebaseFirestore.instance.collection('tokens').add({
    // 'token':token,
    // })
    // });
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is BrowiseGetPostsLoadingState) {
          // AppCubit.get(context).testLikes();
          // AppCubit.get(context).testComments();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeLayout()),
              (route) => false);

          AppCubit.get(context).postImage = null;
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.myWhite,
            body: SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: const Opacity(
                        opacity: 1,
                        child: Image(
                          image: AssetImage(
                              'assets/images/public_chat_image.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      )),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  AppCubit.get(context).postImage = null;
                                  // print('${AppCubit.get(context).postImage}');
                                  Navigator.pop(context);
                                });
                              },
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text('Add new post',
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.myWhite,
                                    fontFamily: AppStrings.appFont)),
                            const Spacer(),
                            state is BrowiseCreateTextPostLoadingState ||
                                    state is BrowiseGetPostsLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : (textFormFielsChanged == true &&
                                        postText.text != "" &&
                                        AppCubit.get(context)
                                                .userModel!
                                                .numberOfPosts !=
                                            12)
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: defaultButton(
                                          textColor: AppColors.primaryColor1,
                                          width: size.width * .21,
                                          height: size.height * .06,
                                          raduis: 10,
                                          function: () async {
                                            // final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

                                            if (formKey.currentState!
                                                .validate()) {
                                              AppCubit.get(context)
                                                  .createTextPost(
                                                text: postText.text,
                                                timeSpam: DateTime.now()
                                                    .toUtc()
                                                    .toString(),
                                                time: DateFormat.Hm()
                                                    .format(DateTime.now()),
                                                dateTime: DateFormat.yMMMd()
                                                    .format(DateTime.now()),
                                              );
                                              // print(DateTime.now().toUtc());

                                              setState(() {
                                                callFcmApiSendPushNotifications(
                                                    title: 'New Post Added',
                                                    description: postText.text,
                                                    imageUrl:
                                                        "${AppCubit.get(context).postImage}",
                                                    context: context
                                                    //  token:AppCubit.get(context).userToken
                                                    );
                                              });
                                              // callFcmApiSendPushNotifications(
                                              // title: 'New Post Added',
                                              // description:postText.text,
                                              // imageUrl: "",
                                              // //  token:AppCubit.get(context).userToken
                                              // );
                                              // setState((){
                                              //   increaseNumberOfPosts=increaseNumberOfPosts+1;
                                              // });
                                              // AppCubit.get(context).increasNumberOfPosts(increaseNumberOfPosts);
                                            }
                                          },
                                          buttonText: 'post',
                                          buttonColor: AppColors.myWhite,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: defaultButton(
                                          textColor: AppColors.primaryColor1,
                                          width: size.width * .21,
                                          height: size.height * .06,
                                          raduis: 10,
                                          function: () {},
                                          buttonText: 'post',
                                          buttonColor:
                                              AppColors.myWhite.withOpacity(1),
                                        ),
                                      ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
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
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Form(
                            key: formKey,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please write your post';
                                }
                                return null;
                              },
                              onChanged: (String s) {
                                setState(() {
                                  textFormFielsChanged = true;
                                });
                              },
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              controller: postText,
                              decoration: const InputDecoration(
                                hintMaxLines: 1,
                                hintText: 'what is on your mind.....',
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              children: [
                                Container(
                                  height: size.height * .001,
                                  width: size.width,
                                  color: AppColors.myWhite,
                                ),

                                // image
                                TextButton(
                                    onPressed: () {
                                      AppCubit.get(context)
                                          .pickPostImageFromCamera();
                                    },
                                    child: Row(
                                      children: [
                                        ImageIcon(
                                          const AssetImage(
                                              "assets/images/camera.png"),
                                          color: AppColors.navBarActiveIcon,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Camera',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: AppStrings.appFont,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )),
                                Container(
                                  height: size.height * .001,
                                  width: size.width,
                                  color: AppColors.myWhite,
                                ),
                                TextButton(
                                    onPressed: () {
                                      AppCubit.get(context)
                                          .pickPostVideoCamera2();
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.video_camera_back,
                                          color: AppColors.myWhite,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Video Camera',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: AppStrings.appFont,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )),
                                Container(
                                  height: size.height * .001,
                                  width: size.width,
                                  color: AppColors.myWhite,
                                ),

                                TextButton(
                                    onPressed: () {
                                      AppCubit.get(context).pickPostImage();
                                    },
                                    child: Row(
                                      children: const [
                                        ImageIcon(
                                          AssetImage(
                                              "assets/images/fanarea.png"),
                                          color: Colors.green,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Photo',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: AppStrings.appFont,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )),
                                Container(
                                  height: size.height * .001,
                                  width: size.width,
                                  color: AppColors.myWhite,
                                ),

                                TextButton(
                                    onPressed: () {
                                      AppCubit.get(context).pickPostVideo2();
                                    },
                                    child: Row(
                                      children: const [
                                        ImageIcon(
                                          AssetImage("assets/images/video.png"),
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Video',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: AppStrings.appFont,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
