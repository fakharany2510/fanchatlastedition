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

class SenderTeamChatWidget extends StatefulWidget {
  int ?index;

  SenderTeamChatWidget({Key? key, this.index}) : super(key: key);

  @override
  State<SenderTeamChatWidget> createState() => _SenderTeamChatWidgetState();
}

class _SenderTeamChatWidgetState extends State<SenderTeamChatWidget> {

  late CachedVideoPlayerController senderController;

  @override
  void initState() {
    senderController = CachedVideoPlayerController.network(
        "${AppCubit.get(context).teamChat[widget.index!].video}");
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
          alignment:Alignment.topRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (AppCubit.get(context).teamChat[widget.index!].text!="")?
                  Container(
                    width: MediaQuery.of(context).size.width*.74,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5
                    ),
                    decoration:  BoxDecoration(
                      color: const Color(0xffb1b2ff).withOpacity(.16),
                      borderRadius:const  BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${AppCubit.get(context).userModel!.username}',
                          style:  TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                              color: AppColors.myWhite,
                              fontFamily: AppStrings.appFont
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text('${AppCubit.get(context).teamChat[widget.index!].text}',
                          style:  TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: AppColors.myWhite,
                              fontFamily: AppStrings.appFont
                          ),
                        )
                      ],
                    ),
                  ):(AppCubit.get(context).teamChat[widget.index!].image !=null) ?
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowHomeImage(image: AppCubit.get(context).teamChat[widget.index!].image)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*.74,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5
                      ),
                      decoration:  BoxDecoration(
                        color: const Color(0xffb1b2ff).withOpacity(.16),
                        borderRadius:const  BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${AppCubit.get(context).userModel!.username}',
                            style:  TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 9,
                                color: AppColors.myWhite,
                                fontFamily: AppStrings.appFont
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Material(
                            elevation: 0,
                            shadowColor: AppColors.myGrey,
                            clipBehavior: Clip.antiAliasWithSaveLayer,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),

                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height*.28,
                              width: MediaQuery.of(context).size.width*.70,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                // border: Border.all(color: AppColors.myGrey,width: 4),
                              ),
                              child: CachedNetworkImage(
                                cacheManager: AppCubit.get(context).manager,
                                imageUrl: "${AppCubit.get(context).teamChat[widget.index!].image}",
                                placeholder: (context, url) => const Center(child: const CircularProgressIndicator()),
                                // maxHeightDiskCache:75,
                                width: 200,
                                height: MediaQuery.of(context).size.height*.2,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ):
                  (AppCubit.get(context).teamChat[widget.index!].video!=null)
                      ?Container(
                    width: MediaQuery.of(context).size.width*.74,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5
                    ),
                    decoration:  BoxDecoration(
                      color: const Color(0xffb1b2ff).withOpacity(.16),
                      borderRadius:const  BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${AppCubit.get(context).userModel!.username}',
                          style:  TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                              color: AppColors.myWhite,
                              fontFamily: AppStrings.appFont
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Stack(
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
                        ),
                      ],
                    ),
                  ):
                  Container(
                    width: MediaQuery.of(context).size.width*.60,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5
                    ),
                    decoration:  BoxDecoration(
                      color: const Color(0xffb1b2ff).withOpacity(.16),
                      borderRadius:const  BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${AppCubit.get(context).userModel!.username}',
                          style:  TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                              color: AppColors.myWhite,
                              fontFamily: AppStrings.appFont
                          ),
                        ),
                        const SizedBox(height: 5,),
                        VoiceMessage(
                          contactBgColor:AppColors.primaryColor1 ,
                          contactFgColor: Colors.white,
                          contactPlayIconColor: AppColors.primaryColor1,
                          audioSrc: '${AppCubit.get(context).teamChat[widget.index!].voice}',
                          played: true, // To show played badge or not.
                          me: false, // Set message side.
                          onPlay: () {}, // Do something when voice played.
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(width: 5,),
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryColor1,
                child: CircleAvatar(
                  backgroundImage:  NetworkImage('${AppCubit.get(context).userModel!.image}') as ImageProvider,
                  radius: 17,
                  backgroundColor: Colors.blue,
                ),

              ),

            ],
          ),
        );
      },
    );
  }
}
