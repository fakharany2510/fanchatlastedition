import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class AddNewVideo extends StatelessWidget {
  //const AddNewVideo({Key? key}) : super(key: key);
  @override
  TextEditingController postText=TextEditingController();
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar:AppBar(
            backgroundColor: AppColors.myWhite,
            title: Text('Add New Video',style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor
            )),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.black),
              onPressed: ()async{
                Navigator.pop(context);
                await  AppCubit.get(context).videoPlayerController!.pause();
              },
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is CreatePostLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircleAvatar(
                        backgroundImage: NetworkImage('https://img.freepik.com/free-photo/pretty-curly-haired-young-woman-smiles-gently-keeps-hands-together-focused-directly-camera-has-pleasant-talk-with-best-friend_273609-46056.jpg?t=st=1649688061~exp=1649688661~hmac=46e35abab9a62e7f0a5b5503f9c83486d54701b31332f77a79d7175ba0e2ca81&w=740'),
                        radius: 30,
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child:   Text('Marry James',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: TextFormField(
                      controller: postText,
                      decoration: InputDecoration(
                        hintText: 'what is on your mind.....',
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  (  AppCubit.get(context).postVideo!= null && AppCubit.get(context).videoPlayerController!.value.isInitialized)
                      ?Container(
                    height: size.height*.6,
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio:AppCubit.get(context).videoPlayerController!.value.aspectRatio,
                      child: AppCubit.get(context).videoPlayerController ==null
                          ?SizedBox(height: 0,)
                          :VideoPlayer(
                          AppCubit.get(context).videoPlayerController!
                      ),

                    ),
                  )
                      : Expanded(child: Container(
                    child: Center(child: Text('No Video Selected Yet',
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor
                        )
                    )),
                  )),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: TextButton(onPressed: (){
                      AppCubit.get(context).pickPostVideo();
                      AppCubit.get(context).isVideoButtonTapped==true;
                      // AppCubit.get(context).postImage=null ;
                      // AppCubit.get(context).isVideoButtonTapped==false;
                    }, child: Container(
                      width: size.width*.8,
                      height: size.height*.06,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.video_camera_back,color: AppColors.primaryColor,size: 26),
                          SizedBox(width:7),
                          Text('add video',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 15
                            ),
                          )
                        ],

                      ),
                    )),
                  ),
                  SizedBox(height: 10,),
                  defaultButton(
                      width: size.width*.8,
                      height: size.height*.06,
                      function: (){
                        var now=DateTime.now();
                        // AppCubit.get(context).uploadPostVideo(dateTime: now.toString());
                        if(AppCubit.get(context).postImage == null){
                          AppCubit.get(context).createVideoPost(
                              dateTime: now.toString(),
                              text:postText.text );
                        }else{
                          AppCubit.get(context).uploadPostVideo(
                              dateTime: now.toString(),
                              text:postText.text
                          );
                        }
                      },
                      buttonText: 'Upload Video',
                      buttonColor: AppColors.primaryColor
                  )
                ],
              )
          ),
        );
      },
    );
  }
}