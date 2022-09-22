import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/message_model.dart';
import 'package:fanchat/presentation/screens/show_home_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_message_package/voice_message_package.dart';

class MyMessageWidget extends StatefulWidget {
  int ?index;

  MyMessageWidget({Key? key,this.index}) : super(key: key);

  @override
  State<MyMessageWidget> createState() => _MyMessageWidgetState();
}

class _MyMessageWidgetState extends State<MyMessageWidget> {

  late CachedVideoPlayerController myController;

  @override
  void initState() {
    myController = CachedVideoPlayerController.network(
        "${AppCubit.get(context).messages[widget.index!].video!}");
    myController.initialize().then((value) {
      myController.play();
      myController.setLooping(true);
      myController.setVolume(1.0);
      setState(() {
        myController.pause();
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
          return Align(
            alignment:AlignmentDirectional.centerEnd,
            child: (AppCubit.get(context).messages[widget.index!].text!="")
                ?Container(
              padding: const EdgeInsets.all(10),
              decoration:  BoxDecoration(
                color: AppColors.primaryColor2,
                borderRadius:const  BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Text('${AppCubit.get(context).messages[widget.index!].text}',
                style:  const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: Colors.white,
                    fontFamily: AppStrings.appFont
                ),
              ),
            )
                :(AppCubit.get(context).messages[widget.index!].image !=null)
                ? GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowHomeImage(image: AppCubit.get(context).messages[widget.index!].image)));
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration:  BoxDecoration(
                  color: AppColors.primaryColor1,
                  borderRadius:const  BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height*.28,
                  width: MediaQuery.of(context).size.width*.55,
                  child:  CachedNetworkImage(
                    cacheManager: AppCubit.get(context).manager,
                    imageUrl: "${AppCubit.get(context).messages[widget.index!].image}",
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
                :
            (AppCubit.get(context).messages[widget.index!].video != null)
                ?Stack(
              children: [
                Container(
                    decoration:  BoxDecoration(
                      borderRadius:const  BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height*.25,
                    width: MediaQuery.of(context).size.width*.55,
                    child: myController.value.isInitialized
                        ? AspectRatio(
                        aspectRatio: myController.value.aspectRatio,
                        child: CachedVideoPlayer(myController))
                        : const Center(child: CircularProgressIndicator())
                ),

                // FutureBuilder(
                //   future: intilize,
                //   builder: (context,snapshot){
                //     if(snapshot.connectionState == ConnectionState.done){
                //       return AspectRatio(
                //         aspectRatio: videoPlayerController!.value.aspectRatio,
                //         child: VideoPlayer(videoPlayerController!),
                //       );
                //     }
                //     else{
                //       return const Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     }
                //   },
                //
                //
                //
                // ),

                Positioned(
                    top: 10,
                    right: 20,
                    child: InkWell(
                      onTap: (){
                        setState((){
                          if(myController.value.isPlaying){
                            myController.pause();
                          }else{
                            myController.play();
                          }
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryColor1,
                        radius: 20,
                        child: myController.value.isPlaying? const Icon(Icons.pause):const Icon(Icons.play_arrow),
                      ),
                    )
                ),
              ],
            ):
            VoiceMessage(
              audioSrc: '${AppCubit.get(context).messages[widget.index!].voice}',
              played: true, // To show played badge or not.
              me: true, // Set message side.
              meBgColor: AppColors.primaryColor1,
              mePlayIconColor: AppColors.navBarActiveIcon,
              onPlay: () {

              }, // Do something when voice played.
            ),
          );
      },
    );
  }
}
