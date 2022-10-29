import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class FanFullVideo extends StatefulWidget {
  int index;

  FanFullVideo({Key? key,required this.index}) : super(key: key);

  @override
  State<FanFullVideo> createState() => _FanFullVideoState();
}

class _FanFullVideoState extends State<FanFullVideo> {

  VideoPlayerController ?controller;
  Future <void> ?intilize;
  bool isLoading=false;

  @override
  void initState() {

    // AppCubit.get(context).singleViedo='';
    AppCubit.get(context).getSingleVideo(
      index: widget.index,
    ).then((value) {
      controller=VideoPlayerController.network(
          AppCubit.get(context).singleViedo!
      );
      print(controller==null);
      print('============================= controller ================');
      print( controller);
      print('============================= controller ================');

      intilize=controller!.initialize();
      controller!.setLooping(false);
      controller!.setVolume(1.0);
      controller!.pause();
    });
     // setState(() {
     //   FirebaseFirestore.instance.collection('singleVideo').doc('${widget.index}').get().then((value) {
     //     print('============================= Success ================');
     //     print(value.data()!['video']);
     //
     //
     //   }).catchError((error){
     //     print('============================= error================');
     //     print(error.toString());
     //     print('============================= error================');
     //
     //   });
     // });


    // controller = CachedVideoPlayerController.network(
    //     AppCubit.get(context).posts[widget.index!].postVideo!);
    // controller!.initialize();
    // controller!.pause();
    // controller!.setLooping(true);
    // controller!.setVolume(1.0);
    // widget.controller!.pause();
    // widget.intilize=widget.controller!.initialize();
    // widget.controller!.setLooping(false);
    // widget.controller!.setVolume(1.0);

    super.initState();

  }

  @override
  void dispose() {

    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(controller==null);
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){

      },
      builder: (context,state){
        return  Scaffold(
            body: state is GetSingleVideoLoadingState ?const Center(
              child: CircularProgressIndicator(),
            ):Stack(
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
                Container(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 70,
                              bottom: 50
                          ),
                          child: FutureBuilder(
                            future:intilize,
                            builder: (context,snapshot){
                              if(snapshot.connectionState == ConnectionState.done){
                                return AspectRatio(
                                  aspectRatio:controller!.value.aspectRatio,
                                  child: VideoPlayer(controller!),
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
                                if(controller!.value.isPlaying){
                                  controller!.pause();
                                  isPostPlaying=true;
                                }else{
                                  controller!.play();
                                  isPostPlaying=false;

                                }
                              });

                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(.8),
                              radius: 30,
                              child:controller!.value.isPlaying?Icon(Icons.pause,size: 30,color: AppColors.primaryColor1,): Icon(Icons.play_arrow,size: 30, color:AppColors.primaryColor1),
                            ),
                          )
                      ),

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
