import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/message_model.dart';
import 'package:fanchat/presentation/screens/private_chat/open_full_video_private_chat.dart';
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
        "${AppCubit.get(context).messages[widget.index!].video}");
    senderController.initialize().then((value) {
      senderController.play();
      senderController.setLooping(true);
      senderController.setVolume(1.0);
      setState(() {
        senderController.pause();
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
          alignment:AlignmentDirectional.centerStart,
          child: (AppCubit.get(context).messages[widget.index!].text!="")
              ?Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5
            ),
            decoration:  BoxDecoration(
              color: const Color(0xffeef1ff).withOpacity(.9),
              borderRadius:const  BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text('${AppCubit.get(context).messages[widget.index!].text}',
              style:const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  color:  Color(0xff7895b2),
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
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
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
          (AppCubit.get(context).messages[widget.index!].video!=null)
              ?Stack(
            children: [
              senderController.value.isInitialized
                  ? Container(
                width: 200,
                child: AspectRatio(
                    aspectRatio:senderController.value.size.width/senderController.value.size.height,
                    child: CachedVideoPlayer(senderController)),
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
                      Navigator.push(context, MaterialPageRoute(builder: (_){
                        return OpenFullVideoPrivateChat(controller: senderController);
                      }));
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(.2),
                      radius: 40,
                      child: senderController.value.isPlaying? Icon(Icons.pause,size: 40,color: Colors.white.withOpacity(.5),): Icon(Icons.play_arrow,size: 40,color: Colors.white.withOpacity(.5),),
                    ),
                  )
              ),
            ],
          ):
          VoiceMessage(
            audioSrc: '${AppCubit.get(context).messages[widget.index!].voice}',
            played: true, // To show played badge or not.
            me: true, // Set message side.
            meBgColor: AppColors.myGrey,
            mePlayIconColor: AppColors.navBarActiveIcon,
            onPlay: () {

            }, // Do something when voice played.
          ),
        );
      },
    );
  }
}
