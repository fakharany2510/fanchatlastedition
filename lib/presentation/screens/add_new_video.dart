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
      listener: (context,state){
        if(state is BrowiseGetPostsSuccessState){
          Navigator.pop(context);
        }
      },
      builder: (context,state){
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar:AppBar(
            backgroundColor: AppColors.myWhite,
            title: Text('Add New Video',style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor1
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
                    children:  [
                      CircleAvatar(
                        backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                        radius: 30,
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child:   Text('${AppCubit.get(context).userModel!.username}',
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
                      decoration: const InputDecoration(
                        hintText: 'what is on your mind.....',
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ( AppCubit.get(context).postVideo!= null && AppCubit.get(context).videoPlayerController!.value.isInitialized)
                      ?Expanded(
                        child: Container(
                    height: size.height*.9,
                    width: double.infinity,
                    child: AspectRatio(
                        aspectRatio:AppCubit.get(context).videoPlayerController!.value.aspectRatio,
                        child: AppCubit.get(context).videoPlayerController ==null
                            ?SizedBox(height: 0,)
                            :VideoPlayer(
                            AppCubit.get(context).videoPlayerController!
                        ),

                    ),
                  ),
                      )
                      : Expanded(child: Container(
                    child: Center(child: Text('No Video Selected Yet',
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor1
                        )
                    )),
                  )),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: TextButton(onPressed: (){
                      AppCubit.get(context).pickPostVideo();
                      AppCubit.get(context).isVideoButtonTapped==true;
                    }, child: Container(
                      width: size.width*.8,
                      height: size.height*.06,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor1),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.video_camera_back,color: AppColors.primaryColor1,size: 26),
                          SizedBox(width:7),
                          Text('add video',
                            style: TextStyle(
                                color: AppColors.primaryColor1,
                                fontSize: 15
                            ),
                          )
                        ],

                      ),
                    )),
                  ),
                  SizedBox(height: 10,),
                  (state is BrowiseCreateVideoPostLoadingState || state is BrowiseGetPostsLoadingState)?
                  Center(
                    child: CircularProgressIndicator(
                       color: AppColors.primaryColor1,
                    ),
                  )
                  :defaultButton(
                      width: size.width*.8,
                      height: size.height*.06,
                      function: (){
                        var now=DateTime.now();
                        // AppCubit.get(context).uploadPostVideo(dateTime: now.toString());
                        if(AppCubit.get(context).postVideo == null){
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
                      buttonColor: AppColors.primaryColor1
                  )
                ],
              )
          ),
        );
      },
    );
  }
}