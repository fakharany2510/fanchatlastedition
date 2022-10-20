import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class OpenFullVideo extends StatefulWidget {
  VideoPlayerController ?controller;
  Future <void> ?intilize;
  OpenFullVideo({Key? key,required this.controller,required this.intilize}) : super(key: key);

  @override
  State<OpenFullVideo> createState() => _OpenFullVideoState();
}

class _OpenFullVideoState extends State<OpenFullVideo> {



  @override
  void initState() {

    // controller = CachedVideoPlayerController.network(
    //     AppCubit.get(context).posts[widget.index!].postVideo!);
    // controller!.initialize();
    // controller!.pause();
    // controller!.setLooping(true);
    // controller!.setVolume(1.0);
    widget.controller!.pause();
    widget.intilize=widget.controller!.initialize();
    widget.controller!.setLooping(true);
    widget.controller!.setVolume(1.0);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
       builder: (context,state){
          return  Scaffold(
            body: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 70,
                        bottom: 50
                      ),
                      child: FutureBuilder(
                        future: widget.intilize,
                        builder: (context,snapshot){
                          if(snapshot.connectionState == ConnectionState.done){
                            return AspectRatio(
                              aspectRatio:widget.controller!.value.aspectRatio,
                              child: VideoPlayer(widget.controller!),
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
                  ),

                  Positioned(
                      top: MediaQuery.of(context).size.height*.12,
                      right: MediaQuery.of(context).size.height*.03,
                      child: InkWell(
                        onTap: (){
                          print('hhfhds');
                          setState((){
                            print('hhfhds 5653');
                            if(widget.controller!.value.isPlaying){
                              widget.controller!.pause();
                              isPostPlaying=true;
                            }else{
                              widget.controller!.play();
                              isPostPlaying=false;

                            }
                          });

                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(.8),
                          radius: 30,
                          child: widget.controller!.value.isPlaying?Icon(Icons.pause,size: 30,color: AppColors.primaryColor1,): Icon(Icons.play_arrow,size: 30, color:AppColors.primaryColor1),
                        ),
                      )
                  ),

                ],
              ),
            ),
          );
       },
    );
  }
}
