import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';
import '../../layouts/home_layout.dart';

class AddFanVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        if(state is FanCreateVideoPostLoadingState){
          AppCubit.get(context).getPosts();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context)=>const HomeLayout()), (route) => false);
         // AppCubit.get(context).videoPlayerController!.dispose();
         //  AppCubit.get(context).videoPlayerController==null;
         //  AppCubit.get(context).videoPlayerController!.pause();
         // AppCubit.get(context).postVideo=null;
          AppCubit.get(context).currentIndex=2;
       // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeLayout()), (route) => false);
        }
      },
      builder: (context,state){
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar:AppBar(
            backgroundColor: AppColors.myWhite,
            title: Text('Add Video',style: TextStyle(
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
                child:(state is FanCreateVideoPostSuccessState)||
                (state is FanUploadVideoPostLoadingState)||
                    ( state is FanUploadVideoPostSuccessState)?
                    CircularProgressIndicator(backgroundColor: AppColors.navBarActiveIcon,)
                :defaultButton(
                    textColor: AppColors.myWhite,
                    width: size.width*.2,
                    height: size.height*.05,
                    raduis: 10,
                    function: (){
                      if(AppCubit.get(context).fanPostVideo == null){
                        print('fan video null');
                      }else{
                        AppCubit.get(context).uploadFanPostVideo(
                          timeSpam: DateTime.now().toString(),
                          time: DateFormat.Hm().format(DateTime.now()),
                          dateTime:DateFormat.yMMMd().format(DateTime.now()),
                          text:"",
                          name: AppCubit.get(context).userModel!.username,
                        );
                        //AppCubit.get(context).getFanPosts();
                      }

                    },
                    buttonText: 'add',
                    buttonColor: AppColors.primaryColor1
                )
              ),
            ],
          ),
          body:Stack(
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
                        LinearProgressIndicator(),
                      SizedBox(height: 5,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children:  [
                      //     CircleAvatar(
                      //       backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                      //       radius: 30,
                      //     ),
                      //     SizedBox(width: 10,),
                      //     Expanded(
                      //       child:   Text('${AppCubit.get(context).userModel!.username}',
                      //         style: const TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.w500,
                      //             fontFamily: AppStrings.appFont
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 10,),
                      ( AppCubit.get(context).fanPostVideo!= null && AppCubit.get(context).videoPlayerController!.value.isInitialized)
                          ?Expanded(
                        child: Container(
                          height: size.height,
                          width: size.width,
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
                                color: AppColors.primaryColor1,
                                fontFamily: AppStrings.appFont
                            )
                        )),
                      )),


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