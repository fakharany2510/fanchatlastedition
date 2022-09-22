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

class SenderMessageWidget extends StatefulWidget {
  int ?index;

  SenderMessageWidget({Key? key, this.index}) : super(key: key);

  @override
  State<SenderMessageWidget> createState() => _SenderMessageWidgetState();
}

class _SenderMessageWidgetState extends State<SenderMessageWidget> {

  late CachedVideoPlayerController senderController;

  @override
  void initState() {
    senderController = CachedVideoPlayerController.network(
        "${AppCubit.get(context).messages[widget.index!].video!}");
    senderController.initialize().then((value) {
      senderController.play();
      senderController.setLooping(true);
      senderController.setVolume(1.0);
      setState(() {
        senderController.pause();
      });
    }).catchError((error){
      print('error while initializing video ${error.toString()}');
    });    super.initState();
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
              :(AppCubit.get(context).messages[widget.index!].image!=null)
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
          (AppCubit.get(context).messages[widget.index!].video!=null)
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
                  child: senderController.value.isInitialized
                      ? AspectRatio(
                      aspectRatio: senderController.value.aspectRatio,
                      child: CachedVideoPlayer(senderController))
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
                        if(senderController.value.isPlaying){
                          senderController.pause();
                        }else{
                          senderController.play();
                        }
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor1,
                      radius: 20,
                      child: senderController.value.isPlaying? const Icon(Icons.pause):const Icon(Icons.play_arrow),
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
