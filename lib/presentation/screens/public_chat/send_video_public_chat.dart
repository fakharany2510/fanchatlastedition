import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendVideoPublicChat extends StatelessWidget {

  SendVideoPublicChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        //  if(state is GetMessageSuccessState){
        // //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatDetails(userModel:widget.userModel,)),);
        //    Navigator.pop(context);
        //  }
        if(state is UploadVideoPublicChatSuccessState){
          Navigator.pop(context);
        }
      },
      builder: (context,state){
        return Scaffold(
            backgroundColor: AppColors.myWhite,
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
                    padding:  const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        (AppCubit.get(context).postVideo4!= null )
                            ?Column(
                              children: [
                                SizedBox(height: size.height*.1,),
                                Container(
                                  height: size.height*.75,
                                  width: size.width,
                                  child: AspectRatio(
                                    aspectRatio:AppCubit.get(context).controller!.value.aspectRatio,
                                    child: AppCubit.get(context).controller ==null
                                        ?const SizedBox(height: 0,)
                                        :CachedVideoPlayer(
                                        AppCubit.get(context).controller!
                                    ),

                                  ),
                                ),
                              ],
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
              ],
            ),
            floatingActionButton: state is UploadVideoPublicChatLoadingState || state is CreateVideoPublicChatLoadingState
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
              onPressed: (){
                AppCubit.get(context).uploadPublicChatVideo(
                    senderId: AppStrings.uId!,
                    dateTime: DateTime.now().toString(),
                    text: ""
                );
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
