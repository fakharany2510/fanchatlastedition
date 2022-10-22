import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class OpenFullVideoPrivateChat extends StatefulWidget {
  CachedVideoPlayerController ?controller;
  OpenFullVideoPrivateChat({Key? key,required this.controller}) : super(key: key);

  @override
  State<OpenFullVideoPrivateChat> createState() => _OpenFullVideoPrivateChatState();
}

class _OpenFullVideoPrivateChatState extends State<OpenFullVideoPrivateChat> {



  @override
  void initState() {

    // controller = CachedVideoPlayerController.network(
    //     AppCubit.get(context).posts[widget.index!].postVideo!);
    // controller!.initialize();
    // controller!.pause();
    // controller!.setLooping(true);
    // controller!.setVolume(1.0);

    widget.controller!.initialize().then((value) {
      widget.controller!.play();
      widget.controller!.setLooping(true);
      widget.controller!.setVolume(1.0);
      setState(() {
        widget.controller!.pause();
      });
    }).catchError((error){
      print('error while initializing video ${error.toString()}');
    });
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
                    padding: const EdgeInsets.only(
                        top: 70,
                        bottom: 50
                    ),
                    child: AspectRatio(
                        aspectRatio:widget.controller!.value.size.width/widget.controller!.value.size.height,
                        child: CachedVideoPlayer(widget.controller!)),
                  )
                  ),


                Positioned(
                    top: MediaQuery.of(context).size.height*.12,
                    right: MediaQuery.of(context).size.height*.03,
                    child: InkWell(
                      onTap: (){
                        setState((){
                          if(widget.controller!.value.isPlaying){
                            widget.controller!.pause();
                          }else{
                            widget.controller!.play();
                          }
                        });
                        // Navigator.push(context, MaterialPageRoute(builder: (_){
                        //   return OpenFullVideoPrivateChat(controller: widget.controller!);
                        // }));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(.8),
                        radius: 30,
                        child: widget.controller!.value.isPlaying? Icon(Icons.pause,size: 30,color: AppColors.primaryColor1,): Icon(Icons.play_arrow,size: 30,color: AppColors.primaryColor1,),
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