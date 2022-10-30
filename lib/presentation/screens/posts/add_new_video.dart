import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/data/services/notification_helper.dart';
import 'package:fanchat/presentation/notifications/functions/send_notification.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_strings.dart';
import '../../layouts/home_layout.dart';

class AddNewVideo extends StatefulWidget {
  @override
  State<AddNewVideo> createState() => _AddNewVideoState();
}

class _AddNewVideoState extends State<AddNewVideo> {
  //const AddNewVideo({Key? key}) : super(key: key);


 // var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // notifyHelper = NotifyHelper();
    // notifyHelper.initializeNotification();
    // notifyHelper.requestIOSPermissions();
  }
  @override
  TextEditingController postText=TextEditingController();

  Widget build(BuildContext context) {



    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        if(state is BrowiseCreateVideoPostLoadingState){
         // Navigator.of(context).popAndPushNamed('home_layout');
         //  AppCubit.get(context).testLikes();
         //  AppCubit.get(context).testComments();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context)=>const HomeLayout()), (route) => false);
          AppCubit.get(context).controller!.pause();
          // AppCubit.get(context).postVideo=null;

        }
        if(state is PickPostVideoSuccessState){AppCubit.get(context).controller!.pause();}
       // if(state is BrowiseCreateVideoPostSuccessState){AppCubit.get(context).controller!.pause();}
      },
      builder: (context,state){
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar:AppBar(
            backgroundColor: AppColors.myWhite,
            title: Text('Add New post',style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor1,
                fontFamily: AppStrings.appFont
            )),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,color: Colors.black),
              onPressed: ()async{
                AppCubit.get(context).postVideo=null;
                Navigator.pop(context);
                await  AppCubit.get(context).videoPlayerController!.pause();
              },
            ),
            actions: [
              state is BrowiseCreateVideoPostLoadingState||state is BrowiseGetPostsLoadingState || state is BrowiseUploadVideoPostLoadingState
                  ? Center(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor1,
                  ),
                ),
              )
                  :Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultButton(
                    textColor: AppColors.myWhite,
                    width: size.width*.2,
                    height: size.height*.05,
                    raduis: 10,
                    function: ()async{
                      if(AppCubit.get(context).postVideo == null){
                        AppCubit.get(context).createVideoPost(
                            timeSpam: DateTime.now().toString(),
                            time: DateFormat.Hm().format(DateTime.now()),
                            dateTime: DateFormat.yMMMd().format(DateTime.now()),
                            text:postText.text
                        );
                        // notifyHelper.displayNotification(
                        //     title:'New Post',
                        //     body:'${postText.text}'
                        // );
                        // callFcmApiSendPushNotifications(
                        //     title: 'New Post Added',
                        //     description:postText.text,
                        //     imageUrl: "${AppCubit.get(context).postImage}",
                        //     context: context
                        //   //  token:AppCubit.get(context).userToken
                        // );
                      }else {
                        AppCubit.get(context).controller!.pause();
                        final filesizeLimit = 30000000;  // in bytes // 30 Mega
                        final filesize = await AppCubit.get(context).postVideo!.length(); // in bytes
                        final isValidFilesize = filesize < filesizeLimit;
                        if (isValidFilesize) {

                          AppCubit.get(context).uploadPostVideo(
                            timeSpam: DateTime.now().toString(),
                            time: DateFormat.Hm().format(DateTime.now()),
                            dateTime:DateFormat.yMMMd().format(DateTime.now()),
                            text:postText.text,
                            name: AppCubit.get(context).userModel!.username,
                          );


                        } else {
                          customToast(title: 'Max Video size is 15 Mb', color: Colors.red);
                        }
                        // callFcmApiSendPushNotifications(
                        //     title: 'New Post Added',
                        //     description:postText.text,
                        //     imageUrl: "",
                        //     context: context
                        //
                        //   //  token:AppCubit.get(context).userToken
                        // );
                   
                      }
                    },
                    buttonText: 'post',
                    buttonColor: AppColors.primaryColor1
              ),
                  ),
            ],
          ),
          body: Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child:const Opacity(
                    opacity: 1,
                    child:  Image(
                      image: AssetImage('assets/images/imageback.jpg'),
                      fit: BoxFit.cover,
                    ),
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if(state is CreatePostLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                          CircleAvatar(
                            backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                            radius: 30,
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child:   Text('${AppCubit.get(context).userModel!.username}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppStrings.appFont
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      SingleChildScrollView(
                        child: TextFormField(
                          controller: postText,
                          decoration: const InputDecoration(
                            hintText: 'Say something about this video.....',
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40,),
                      ( AppCubit.get(context).postVideo!= null && AppCubit.get(context).controller!.value.isInitialized)
                          ?Container(
                            height: MediaQuery.of(context).size.height*.55,
                            child: Align(
                              alignment: Alignment.centerRight,
                              heightFactor: 1,
                              widthFactor: 1,
                              child: AspectRatio(
                                aspectRatio:AppCubit.get(context).controller!.value.aspectRatio*1,
                                child: AppCubit.get(context).controller ==null
                                    ?const SizedBox(height: 0,)
                                    :CachedVideoPlayer(
                                    AppCubit.get(context).controller!
                                ),
                              ),
                            ),
                          )
                          : Expanded(child: Center(child: Text('No Video Selected Yet',
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor1,
                              fontFamily: AppStrings.appFont
                          )
                      ))),
                      const Spacer(),


                    ],
                  )
              ),
            ],
          )
        );
      },
    );
  }
}