import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/data/services/notification_helper.dart';
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
  TextEditingController postText=TextEditingController();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        if(state is BrowiseGetPostsSuccessState){
         // Navigator.of(context).popAndPushNamed('home_layout');
         //  AppCubit.get(context).testLikes();
         //  AppCubit.get(context).testComments();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context)=>HomeLayout()), (route) => false);
          AppCubit.get(context).controller!.dispose();
          AppCubit.get(context).postVideo=null;

        }
      },
      builder: (context,state){
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar:AppBar(
            backgroundColor: AppColors.myWhite,
            title: Text('Add vew post',style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor1,
                fontFamily: AppStrings.appFont
            )),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.black),
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
                    function: (){
                      if(AppCubit.get(context).postVideo == null){
                        AppCubit.get(context).createVideoPost(
                            timeSpam: DateTime.now().toString(),
                            time: DateFormat.Hm().format(DateTime.now()),
                            dateTime: DateFormat.yMMMd().format(DateTime.now()),
                            text:postText.text
                        );
                        notifyHelper.displayNotification(
                            title:'New Post',
                            body:'${postText.text}'
                        );
                      }else{
                        AppCubit.get(context).uploadPostVideo(
                          timeSpam: DateTime.now().toString(),
                          time: DateFormat.Hm().format(DateTime.now()),
                          dateTime:DateFormat.yMMMd().format(DateTime.now()),
                          text:postText.text,
                          name: AppCubit.get(context).userModel!.username,
                        );
                        notifyHelper.displayNotification(
                            title:'New Post',
                            body:'${postText.text}'
                        );
                      }
                    },
                    buttonText: 'post',
                    buttonColor: AppColors.primaryColor1
              ),
                  ),
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is CreatePostLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      CircleAvatar(
                        backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                        radius: 30,
                      ),
                      SizedBox(width: 10,),
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
                  SizedBox(height: 10,),
                  Expanded(
                    child: TextFormField(
                      controller: postText,
                      decoration: const InputDecoration(
                        hintText: 'Say something about this video.....',
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ( AppCubit.get(context).postVideo!= null && AppCubit.get(context).controller!.value.isInitialized)
                      ?Expanded(
                        child: Container(
                    height: size.height,
                    width: size.width,
                    child: AspectRatio(
                        aspectRatio:AppCubit.get(context).controller!.value.aspectRatio,
                        child: AppCubit.get(context).controller ==null
                            ?SizedBox(height: 0,)
                            :CachedVideoPlayer(
                            AppCubit.get(context).controller!
                        ),

                    ),
                  ),
                      )
                      : Expanded(child: Container(
                    child: Center(child: Text('No Video Selected Yet',
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor1,
                            fontFamily: AppStrings.appFont
                        )
                    )),
                  )),
                  Spacer(),


                ],
              )
          ),
        );
      },
    );
  }
}