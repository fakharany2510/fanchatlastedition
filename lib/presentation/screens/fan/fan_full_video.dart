import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/user_profile.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Future <void> ?intilize;
  @override
  void initState() {
    // AppCubit.get(context).insertTOdatabase(
    //     postId: AppCubit.get(context).posts[widget.index!].postId!,
    //     userId: AppCubit.get(context).posts[widget.index!].userId!,
    //     image: AppCubit.get(context).posts[widget.index!].image!,
    //     name:  AppCubit.get(context).posts[widget.index!].name!,
    //     postImage:AppCubit.get(context).posts[widget.index!].postImage!,
    //     postVideo: AppCubit.get(context).posts[widget.index!].postVideo!,
    //     postText: AppCubit.get(context).posts[widget.index!].text!,
    //     time: AppCubit.get(context).posts[widget.index!].time!,
    //     timeSamp: AppCubit.get(context).posts[widget.index!].timeSmap!
    // );
    //////////////////////////////////
    videoPlayerController=VideoPlayerController.network(
        widget.video!
    );
    intilize=videoPlayerController!.initialize();
    videoPlayerController!.setLooping(true);
    videoPlayerController!.setVolume(1.0);    super.initState();
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
              height: MediaQuery.of(context).size.height*02,
              width: MediaQuery.of(context).size.width*.4,
              child: Image(
                image: AssetImage('assets/images/ncolort.png'),

              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            actions: [
              IconButton(onPressed: (){}, constraints: BoxConstraints(),
                padding: EdgeInsets.only(right: 20),
                icon: ImageIcon(
                  AssetImage("assets/images/notification.png"),
                  color:AppColors.navBarActiveIcon,

                ),),

            ],
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
                            child: FutureBuilder(
                              future: intilize,
                              builder: (context,snapshot){
                                if(snapshot.connectionState == ConnectionState.done){
                                  return AspectRatio(
                                    aspectRatio: videoPlayerController!.value.aspectRatio,
                                    child: VideoPlayer(videoPlayerController!),
                                  );
                                }
                                else{
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },



                            ),
                          ),
                          Positioned(
                              top: 10,
                              right: 10,
                              child: InkWell(
                                onTap: (){
                                  setState((){
                                    if(videoPlayerController!.value.isPlaying){
                                      videoPlayerController!.pause();
                                    }else{
                                      videoPlayerController!.play();
                                    }
                                  });
                                },
                                child: videoPlayerController!.value.isPlaying?
                                CircleAvatar(radius: 15, child: Icon(
                                  Icons.pause,color: AppColors.myWhite,size: 15,)): CircleAvatar(radius: 15, child: Icon(Icons.play_arrow,color: AppColors.myWhite,size: 15,)),
                              )
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
