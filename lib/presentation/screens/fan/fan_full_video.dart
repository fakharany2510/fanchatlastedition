import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/user_profile.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_cache_manager/enums/download_media_status.dart';
import 'package:media_cache_manager/widgets/download_media_builder.dart';
import 'package:video_player/video_player.dart';

class FanFullVideo extends StatefulWidget {
  FanFullVideo({Key? key,this.video,this.userImage,this.userName,this.userId}) : super(key: key);
  String ?userImage;
  String ?userName;
  String ?userId;
  String ?video;
  @override
  State<FanFullVideo> createState() => _FanFullVideoState();
}

class _FanFullVideoState extends State<FanFullVideo> {
  VideoPlayerController ?videoPlayerController;
  //Future <void> ?intilize;
  ChewieController? chewieController;
  //bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1),()async{
      videoPlayerController=VideoPlayerController.network(
          widget.video!
      );
      await videoPlayerController!.initialize().then((value){
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          autoPlay: true,
          looping: false,
        );
      });
      setState((){
       // isLoading=false;
      });
    });


    super.initState();
  }
  @override
  void dispose() {
    videoPlayerController!.dispose();
    chewieController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppState>(
      listener: (context,state){

      },
      builder: (context , state){
        return Scaffold(
          backgroundColor:Colors.white,
          appBar: AppBar(
            systemOverlayStyle:  SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarColor: AppColors.primaryColor1,
            ),
            iconTheme: IconThemeData(
                color: AppColors.myWhite
            ),
            backgroundColor: AppColors.primaryColor1,
            title:Container(
              height: MediaQuery.of(context).size.height*1,
              width: MediaQuery.of(context).size.width*.25,
              child: Image(
                image: AssetImage('assets/images/ncolors.png'),

              ),
            ),
            centerTitle: true,
            elevation: 0.0,

            leading: IconButton(
              onPressed: (){
                setState((){
                  videoPlayerController!.pause();
                });
                Navigator.pop(context);

              },
              icon: Icon(
                Icons.arrow_back_ios
              ),
            ),
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              AppCubit.get(context).getUserProfilePosts(id: '${widget.userId}').then((value) {
                                Navigator.push(context, MaterialPageRoute(builder: (_){
                                  return UserProfile(
                                    userId: '${widget.userId}',
                                    userImage: '${widget.userImage}',
                                    userName: '${widget.userName}',

                                  );
                                }));
                              });
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage('${widget.userImage}',
                              ),
                              radius: 18,
                            ),
                          ),
                          const SizedBox(width: 7,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text('${widget.userName}',
                                        overflow: TextOverflow.ellipsis,
                                        style:  TextStyle(
                                            color: AppColors.primaryColor1,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: AppStrings.appFont
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Spacer(),
                          // IconButton(
                          //   onPressed: (){},
                          //   padding: EdgeInsets.zero,
                          //   constraints: BoxConstraints(),
                          //   icon:Icon(Icons.favorite_outline,color: AppColors.navBarActiveIcon,size: 20),)
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),

                    Container(
                      height: MediaQuery.of(context).size.height*.6,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height*.6,
                              width: double.infinity,
                              child: DownloadMediaBuilder(
                                url: widget.video!,
                                builder: (context, snapshot) {
                                  if (snapshot.status == DownloadMediaStatus.loading) {
                                    return Image(image:AssetImage('assets/images/load.png'));
                                  }
                                  if (snapshot.status == DownloadMediaStatus.success) {
                                    return chewieController == null
                                        ?Image(image:AssetImage('assets/images/load.png'))
                                        :Chewie(
                                        controller:chewieController!
                                    );

                                  }
                                  return const Text('Error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                                },
                              ),

                              // Chewie(
                              //   controller: chewieController!,
                              // )

                            // AspectRatio(
                            //   aspectRatio: videoPlayerController!.value.aspectRatio,
                            //     child: VideoPlayer(videoPlayerController!)),


                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        );
      },

    );
  }
}
