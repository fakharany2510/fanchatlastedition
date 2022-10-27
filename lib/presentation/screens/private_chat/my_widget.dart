import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/home_screen.dart';
import 'package:fanchat/presentation/screens/posts/open_full_video.dart';
import 'package:fanchat/presentation/screens/private_chat/open_full_video_private_chat.dart';
import 'package:fanchat/presentation/screens/show_home_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:voice_message_package/voice_message_package.dart';

class MyMessageWidget extends StatefulWidget {
  int ?index;

  MyMessageWidget({Key? key,this.index}) : super(key: key);

  @override
  State<MyMessageWidget> createState() => _MyMessageWidgetState();
}

class _MyMessageWidgetState extends State<MyMessageWidget> {

  late VideoPlayerController mymessageController;

  @override
  void initState() {
    mymessageController = VideoPlayerController.network(
        "${AppCubit.get(context).messages[widget.index!].video}");
    mymessageController.initialize().then((value) {
      mymessageController.play();
      mymessageController.setLooping(false);
      mymessageController.setVolume(1.0);
      setState(() {
        mymessageController.pause();
      });
    }).catchError((error){
      print('error while initializing video ${error.toString()}');
    });
    super.initState();
  }
@override
  void dispose() {
  mymessageController.dispose();
    super.dispose();
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
              padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5
              ),
              decoration:  BoxDecoration(
                color: const Color(0xff7895b2).withOpacity(.9),
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
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                ),
                height: MediaQuery.of(context).size.height*.28,
                width: MediaQuery.of(context).size.width*.55,
                child:  CachedNetworkImage(
                  cacheManager: AppCubit.get(context).manager,
                  imageUrl: "${AppCubit.get(context).messages[widget.index!].image}",
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  fit: BoxFit.contain,
                ),
              ),
            )
                :
            (AppCubit.get(context).messages[widget.index!].video != null)
                ?Stack(
              children: [
                mymessageController.value.isInitialized
                    ? Container(
                  width: 200,
                      child: AspectRatio(
                      aspectRatio:mymessageController.value.size.width/mymessageController.value.size.height,
                      child: VideoPlayer(mymessageController)),
                    )
                    : const Center(child: CircularProgressIndicator()),

                Positioned(
                    top: MediaQuery.of(context).size.height*.2,
                    right: MediaQuery.of(context).size.height*.08,
                    child: InkWell(
                      onTap: (){
                        // setState((){
                        //   if(mymessageController.value.isPlaying){
                        //     mymessageController.pause();
                        //   }else{
                        //     mymessageController.play();
                        //   }
                        // });
                        //mymessageController.play();
                        isPostPlaying=false;
                        Navigator.push(context, MaterialPageRoute(builder: (_){
                          return OpenFullVideoPrivateChat(controller: mymessageController);
                        }));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(.2),
                        radius: 40,
                        child: mymessageController.value.isPlaying? Icon(Icons.pause,size: 40,color: Colors.white.withOpacity(.5),): Icon(Icons.play_arrow,size: 40,color: Colors.white.withOpacity(.5),),
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
