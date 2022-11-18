// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenFullVideoPrivateChat extends StatefulWidget {
  String? controller;
  OpenFullVideoPrivateChat({super.key, required this.controller});

  @override
  State<OpenFullVideoPrivateChat> createState() =>
      _OpenFullVideoPrivateChatState();
}

class _OpenFullVideoPrivateChatState extends State<OpenFullVideoPrivateChat> {
  final FijkPlayer player = FijkPlayer();
  Object? error;

  //bool isLoading = true;

  Future<void> init() async {
    try {} catch (e, st) {
      error = e;
      log('max $e \n $st');
    } finally {
      setState(() {});
    }
  }

  @override
  void initState() {
    // // controller = CachedVideoPlayerController.network(
    // //     AppCubit.get(context).posts[widget.index!].postVideo!);
    // // controller!.initialize();
    // // controller!.pause();
    // // controller!.setLooping(true);
    // // controller!.setVolume(1.0);
    //
    // widget.controller!.initialize().then((value) {
    //  // widget.controller!.play();
    //   widget.controller!.setLooping(false);
    //   widget.controller!.setVolume(1.0);
    //   setState(() {
    //     //widget.controller!.pause();
    //   });
    // }).catchError((error){
    //   print('error while initializing video ${error.toString()}');
    // });
    init();
    player.setDataSource(widget.controller!, autoPlay: true, showCover: true);
    super.initState();
  }

  @override
  void dispose() {
    // widget.controller!.dispose();
    player.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Opacity(
                    opacity: 1,
                    child: Image(
                      image: AssetImage('assets/images/public_chat_image.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  )),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70, bottom: 50),
                      child: FijkView(
                        player: player,
                        fit: FijkFit.contain,
                        color: Colors.transparent,
                      ),

                      //   AspectRatio(
                      //       aspectRatio:widget.controller!.value.size.width/widget.controller!.value.size.height,
                      //       child: VideoPlayer(widget.controller!)),
                      // )
                    ),

                    // Positioned(
                    //     top: MediaQuery.of(context).size.height*.12,
                    //     right: MediaQuery.of(context).size.height*.03,
                    //     child: InkWell(
                    //       onTap: (){
                    //         setState((){
                    //           if(widget.controller!.value.isPlaying){
                    //             widget.controller!.pause();
                    //           }else{
                    //             widget.controller!.play();
                    //           }
                    //         });
                    //         // Navigator.push(context, MaterialPageRoute(builder: (_){
                    //         //   return OpenFullVideoPrivateChat(controller: widget.controller!);
                    //         // }));
                    //       },
                    //       child: CircleAvatar(
                    //         backgroundColor: Colors.white.withOpacity(.8),
                    //         radius: 30,
                    //         child: widget.controller!.value.isPlaying? Icon(Icons.pause,size: 30,color: AppColors.primaryColor1,): Icon(Icons.play_arrow,size: 30,color: AppColors.primaryColor1,),
                    //       ),
                    //     )
                    // ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
