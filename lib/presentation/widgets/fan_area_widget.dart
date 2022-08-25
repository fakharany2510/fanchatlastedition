import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/screens/fan/fan_full_post.dart';
import 'package:fanchat/presentation/screens/fan/fan_full_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class FanAreaWidget extends StatefulWidget {
  int? index;
  FanAreaWidget({Key? key, this.index}) : super(key: key);

  @override
  State<FanAreaWidget> createState() => _FanAreaWidgetState();
}

class _FanAreaWidgetState extends State<FanAreaWidget> {
  VideoPlayerController ?videoPlayerController;
  Future <void> ?intilize;
  @override
  void initState() {
    videoPlayerController=VideoPlayerController.network(
        AppCubit.get(context).fans[widget.index!].postVideo!
    );
    intilize=videoPlayerController!.initialize();
    videoPlayerController!.setLooping(true);
    videoPlayerController!.setVolume(1.0);    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context , state){
          return Column(
            children: [
              InkWell(
                  onTap: (){
                    (AppCubit.get(context).fans[widget.index!].postImage!="")?
                    Navigator.push(context, MaterialPageRoute(builder: (_){
                      return FanFullPost(image: '${AppCubit.get(context).fans[widget.index!].postImage}',userImage: '${AppCubit.get(context).fans[widget.index!].image}',userName: '${AppCubit.get(context).fans[widget.index!].name}',);
                    })):Navigator.push(context, MaterialPageRoute(builder: (_){
                      return FanFullVideo(video: '${AppCubit.get(context).fans[widget.index!].postVideo}',userImage: '${AppCubit.get(context).fans[widget.index!].image}',userName: '${AppCubit.get(context).fans[widget.index!].name}',);
                    }));
                  },
                  child: (AppCubit.get(context).fans[widget.index!].postImage!="")
                      ?Stack(
                    children: [
                      Image(
                        height: MediaQuery.of(context).size.height*.2,
                        fit: BoxFit.fill,
                        image: NetworkImage('${AppCubit.get(context).fans[widget.index!].postImage}') as ImageProvider,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                            onPressed: (){
                            },
                            icon:Icon(Icons.image,color: AppColors.myWhite,)
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                            padding: EdgeInsets.all(4),
                            constraints: BoxConstraints(),
                            onPressed: (){
                            },
                            icon:Icon(Icons.favorite,color:Colors.red,)
                        ),
                      ),
                    ],
                  )
                      :Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*.2,
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
                            child: videoPlayerController!.value.isPlaying?  Icon(Icons.pause,color: AppColors.primaryColor1,): Icon(Icons.play_arrow,color: AppColors.primaryColor1,),
                          )
                      ),
                    ],
                  )
              ),
            ],
          );
        },
        listener: (context , state){});
  }
}
