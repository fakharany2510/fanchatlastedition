// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'dart:developer';

import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenFullVideo extends StatefulWidget {
  String? controller;
  OpenFullVideo({super.key, required this.controller});

  @override
  State<OpenFullVideo> createState() => _OpenFullVideoState();
}

class _OpenFullVideoState extends State<OpenFullVideo> {
  final FijkPlayer player = FijkPlayer();
  Object? error;
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
    init();
    super.initState();
    player.setDataSource(widget.controller!, autoPlay: true, showCover: true);
    super.initState();
  }

  @override
  void dispose() {
    player.pause();
    player.release();
    // player.dispose();
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
                if (error != null)
                  Center(child: Text(error.toString()))
                else if (player == null)
                  const Center(child: CupertinoActivityIndicator())
                else
                  Padding(
                      padding: const EdgeInsets.all(0),
                      child: FijkView(
                        player: player,
                        fit: FijkFit.contain,
                        color: Colors.transparent,
                      )),

                // Positioned(
                //           top: MediaQuery.of(context).size.height*.12,
                //           right: MediaQuery.of(context).size.height*.03,
                //           child: InkWell(
                //             onTap: (){
                //               print('hhfhds');
                //               setState((){
                //                 print('hhfhds 5653');
                //                 if(widget.controller!.value.isPlaying){
                //                   widget.controller!.pause();
                //                   isPostPlaying=true;
                //                 }else{
                //                   widget.controller!.play();
                //                   isPostPlaying=false;
                //
                //                 }
                //               });
                //
                //             },
                //             child: CircleAvatar(
                //               backgroundColor: Colors.white.withOpacity(.8),
                //               radius: 30,
                //               child: widget.controller!.value.isPlaying?Icon(Icons.pause,size: 30,color: AppColors.primaryColor1,): Icon(Icons.play_arrow,size: 30, color:AppColors.primaryColor1),
                //             ),
                //           )
                //       ),
              ],
            ),
          ],
        ));
      },
    );
  }
}
