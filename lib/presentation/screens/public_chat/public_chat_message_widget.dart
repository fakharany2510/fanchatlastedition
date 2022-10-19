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

class SenderPublicChatWidget extends StatefulWidget {
  int ?index;

  SenderPublicChatWidget({Key? key, this.index}) : super(key: key);

  @override
  State<SenderPublicChatWidget> createState() => _SenderPublicChatWidgetState();
}

class _SenderPublicChatWidgetState extends State<SenderPublicChatWidget> {

  late CachedVideoPlayerController senderController;

  @override
  void initState() {
    senderController = CachedVideoPlayerController.network(
        "${AppCubit.get(context).publicChat[widget.index!].video}");
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
                  (AppCubit.get(context).publicChat[widget.index!].text!="")?
                  Container(
                    width: MediaQuery.of(context).size.width*.74,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5
                    ),
                    decoration:  BoxDecoration(
                      color: AppColors.primaryColor1.withOpacity(.9),
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
                        Text('${AppCubit.get(context).publicChat[widget.index!].text}',
                          style:  TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: AppColors.myWhite,
                              fontFamily: AppStrings.appFont
                          ),
                        )
                      ],
                    ),
                  ):(AppCubit.get(context).publicChat[widget.index!].image !=null) ?
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowHomeImage(image: AppCubit.get(context).publicChat[widget.index!].image)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*.74,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5
                      ),
                      decoration:  BoxDecoration(
                        color: AppColors.primaryColor1,
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
                            elevation: 100,
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
                                imageUrl: "${AppCubit.get(context).publicChat[widget.index!].image}",
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
                  (AppCubit.get(context).publicChat[widget.index!].video!=null)
                      ?Container(
                    width: MediaQuery.of(context).size.width*.74,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5
                    ),
                    decoration:  BoxDecoration(
                      color: AppColors.primaryColor1,
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
                            Container(
                                decoration:  BoxDecoration(
                                  borderRadius:const  BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                               /// height: MediaQuery.of(context).size.height*.25,
                                width: MediaQuery.of(context).size.width*.74,
                                child: senderController.value.isInitialized
                                    ? AspectRatio(
                                    aspectRatio:senderController.value.size.width/senderController.value.size.height,
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
                  ),
                          ],
                        ),
                      ):
                  Container(
                    width: MediaQuery.of(context).size.width*.60,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5
                    ),
                    decoration:  BoxDecoration(
                      color: AppColors.primaryColor1,
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
                          audioSrc: '${AppCubit.get(context).publicChat[widget.index!].voice}',
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
