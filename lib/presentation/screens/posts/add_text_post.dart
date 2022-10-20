import 'package:cloud_firestore/cloud_firestore.dart';
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
  @override
  State<AddTextPost> createState() => _AddTextPostState();
}

class _AddTextPostState extends State<AddTextPost> {

  @override
  TextEditingController postText = TextEditingController();
  var formKey =GlobalKey<FormState>();


  var notifyHelper;
  bool textFormFielsChanged = false;
  bool isbuttonDisabled = false;
  int increaseNumberOfPosts=0;
  @override
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    // _fcm.getToken().then((token) =>{
    //   print('token =====> ${token}'),
    // FirebaseFirestore.instance.collection('tokens').add({
    // 'token':token,
    // })
    // });
    notifyHelper.requestIOSPermissions();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is BrowiseGetPostsLoadingState) {
          // AppCubit.get(context).testLikes();
          // AppCubit.get(context).testComments();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeLayout()), (route) => false);

          AppCubit.get(context).postImage = null;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar: AppBar(
            backgroundColor: AppColors.myWhite,
            title: Text('Add new post',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor1,
                    fontFamily: AppStrings.appFont)),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                setState(() {
                  AppCubit.get(context).postImage = null;
                  print('${AppCubit.get(context).postImage}');
                  Navigator.pop(context);
                });
              },
            ),
            actions: [
              state is BrowiseCreateTextPostLoadingState ||
                      state is BrowiseGetPostsLoadingState
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : (textFormFielsChanged == true && postText.text != ""  && AppCubit.get(context).userModel!.numberOfPosts != 12)
              ?Padding(
        padding: const EdgeInsets.all(8.0),
        child: defaultButton(
        textColor: AppColors.myWhite,
        width: size.width*.2,
        height: size.height*.05,
        raduis: 10,
        function: () {
        if(formKey.currentState!.validate()){
        AppCubit.get(context).createTextPost(
        text: postText.text,
        timeSpam: DateTime.now().toString(),
        time: DateFormat.Hm().format(DateTime.now()),
        dateTime: DateFormat.yMMMd().format(DateTime.now()),
        );
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
        buttonColor: AppColors.primaryColor1,
        ),
        )
              :Padding(
        padding: const EdgeInsets.all(8.0),
        child: defaultButton(
        textColor: AppColors.myWhite,
        width: size.width*.2,
        height: size.height*.05,
        raduis: 10,
        function: () {},
        buttonText: 'post',
        buttonColor: AppColors.primaryColor1.withOpacity(.2),
        ),
        )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20.0),
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
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppStrings.appFont),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: formKey,
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'please write your post';
                          }
                        },
                        onChanged: (String s){
                          setState((){
                            textFormFielsChanged = true;
                          });
                        },
                        controller: postText,
                        decoration: const InputDecoration(
                          hintMaxLines: 1,
                          hintText: 'what is on your mind.....',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .5,
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Container(
                            height: size.height * .001,
                            width: size.width,
                            color: AppColors.myGrey,
                          ),
                          TextButton(
                              onPressed: () {
                                AppCubit.get(context).pickPostImage();
                              },
                              child: Row(
                                children: [
                                    ImageIcon(
                                      AssetImage("assets/images/fanarea.png"),
                                      color:Colors.green,

                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Photo',
                                    style: TextStyle(
                                        color: AppColors.primaryColor1,
                                        fontFamily: AppStrings.appFont,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                          Container(
                            height: size.height * .001,
                            width: size.width,
                            color: AppColors.myGrey,
                          ),
                          TextButton(
                              onPressed: () {
                                AppCubit.get(context).pickPostVideo2();
                              },
                              child: Row(
                                children: [
                                  ImageIcon(
                                    AssetImage("assets/images/video.png"),
                                    color:Colors.red,

                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Video',
                                    style: TextStyle(
                                        color: AppColors.primaryColor1,
                                        fontFamily: AppStrings.appFont,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                          Container(
                            height: size.height * .001,
                            width: size.width,
                            color: AppColors.myGrey,
                          ),
                          TextButton(
                              onPressed: () {
                                AppCubit.get(context).pickPostImageFromCamera();
                              },
                              child: Row(
                                children: [
                                  ImageIcon(
                                    AssetImage("assets/images/camera.png"),
                                    color:AppColors.navBarActiveIcon,

                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Camera',
                                    style: TextStyle(
                                        color: AppColors.primaryColor1,
                                        fontFamily: AppStrings.appFont,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}
