import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/user_model.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendVideoTeamChat extends StatelessWidget {
  String? countryName;

  SendVideoTeamChat({Key? key,this.countryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        //  if(state is GetMessageSuccessState){
        // //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatDetails(userModel:widget.userModel,)),);
        //    Navigator.pop(context);
        //  }
        if(state is UploadVideoTeamChatSuccessState){
          Navigator.pop(context);
        }
      },
      builder: (context,state){
        return Scaffold(
            backgroundColor: AppColors.myWhite,
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/imageback.jpg'),
                    fit: BoxFit.cover,
                  )
              ),
              child: Padding(
                  padding:  EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      (AppCubit.get(context).postVideo5!= null )
                          ?Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: size.height*.1,),
                              Container(
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

                            ],
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
                    ],
                  )
              ),
            ),
            floatingActionButton: state is UploadVideoTeamChatLoadingState || state is CreateVideoTeamChatLoadingState
                ?FloatingActionButton(
              onPressed: (){
                // AppCubit.get(context).uploadPrivateVideo(
                //     senderId: AppStrings.uId!,
                //     dateTime: DateTime.now().toString(),
                //     recevierId:userModel.uId!,
                //     text: ""
                // );
              },
              backgroundColor: AppColors.primaryColor1,
              child:  CircularProgressIndicator(color: AppColors.navBarActiveIcon)
              ,
            )
                :FloatingActionButton(
              onPressed: ()async{

                final filesizeLimit = 30000000;  // in bytes // 30 Mega
                final filesize = await AppCubit.get(context).postVideo5!.length(); // in bytes
                final isValidFilesize = filesize < filesizeLimit;
                if (isValidFilesize) {

                  AppCubit.get(context).uploadTeamChatVideo(
                      senderId: AppStrings.uId!,
                      dateTime: DateTime.now().toString(),
                      text: "",
                      countryName: countryName,
                      senderName: '${AppCubit.get(context).userModel!.username}',
                      senderImage: '${AppCubit.get(context).userModel!.image}'

                  );
                  // callFcmApiSendPushNotifications(
                  //     title: 'New Post Added',
                  //     description:postText.text,
                  //     imageUrl: "",
                  //     context: context
                  //
                  //   //  token:AppCubit.get(context).userToken
                  // );

                } else {
                  customToast(title: 'Max Video size is 30 Mb', color: Colors.red);
                }


              },
              backgroundColor: AppColors.primaryColor1,
              child: const Icon(
                Icons.send,
                color: Colors.white
                ,
              )
              ,
            )

        );
      },
    );
  }
}