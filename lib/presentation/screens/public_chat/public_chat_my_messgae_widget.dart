import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/message_model.dart';
import 'package:fanchat/presentation/screens/show_home_image.dart';
import 'package:fanchat/presentation/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_message_package/voice_message_package.dart';

class MyMessagePublicChatWidget extends StatefulWidget {
  int ?index;

  MyMessagePublicChatWidget({Key? key,this.index}) : super(key: key);

  @override
  State<MyMessagePublicChatWidget> createState() => _MyMessagePublicChatWidgetState();
}

class _MyMessagePublicChatWidgetState extends State<MyMessagePublicChatWidget> {

  late CachedVideoPlayerController mymessageController;

  @override
  void initState() {
    mymessageController = CachedVideoPlayerController.network(
        "${AppCubit.get(context).publicChat[widget.index!].video}");
    mymessageController.initialize().then((value) {
      mymessageController.play();
      mymessageController.setLooping(true);
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
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){

      },
      builder: (context,state){
        return Align(
          alignment:Alignment.topRight,
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return UserProfile(userId: AppCubit.get(context).publicChat[widget.index!].senderId!,
                        userImage:AppCubit.get(context).publicChat[widget.index!].senderImage!,
                        userName: AppCubit.get(context).publicChat[widget.index!].senderName!);
                  }));
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.myGrey,
                  child: CircleAvatar(
                    backgroundImage:  NetworkImage('${AppCubit.get(context).publicChat[widget.index!].senderImage}' ),
                    radius: 17,
                    backgroundColor: Colors.blue,
                  ),

                ),
              ),
              const SizedBox(width: 5,),
              Column(
                children: [
                  (AppCubit.get(context).publicChat[widget.index!].text!="")
                      ?
                  Material(
                    color: AppColors.navBarActiveIcon.withOpacity(.9),
                    shape: RoundedRectangleBorder(
                      borderRadius:const  BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width*.74,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5
                      ),
                      decoration:  BoxDecoration(
                        color: AppColors.navBarActiveIcon.withOpacity(.5),
                        borderRadius:const  BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${AppCubit.get(context).publicChat[widget.index!].senderName}',
                            style:  TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 9,
                                color: AppColors.primaryColor1,
                                fontFamily: AppStrings.appFont
                            ),

                          ),
                          const SizedBox(height: 5,),
                          Text('${AppCubit.get(context).publicChat[widget.index!].text}',
                            style:  const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: AppStrings.appFont
                            ),
                          )

                        ],
                      ),
                    ),
                  ):
                  (AppCubit.get(context).publicChat[widget.index!].image !=null) ?
                  Container(
                    width: MediaQuery.of(context).size.width*.74,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5
                    ),
                    decoration:  BoxDecoration(
                      color: AppColors.myGrey,
                      borderRadius:const  BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${AppCubit.get(context).publicChat[widget.index!].senderName}',
                          style:  TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                              color: AppColors.primaryColor1,
                              fontFamily: AppStrings.appFont
                          ),

                        ),
                        const SizedBox(height: 5,),
                        Material(
                          shadowColor: AppColors.myGrey,
                          elevation: 100,
                          clipBehavior: Clip.antiAliasWithSaveLayer,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),

                          ),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowHomeImage(image: AppCubit.get(context).publicChat[widget.index!].image)));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height*.28,
                              width: MediaQuery.of(context).size.width*.70,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                // border: Border.all(color: AppColors.primaryColor1,width: 4),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child:CachedNetworkImage(
                                cacheManager: AppCubit.get(context).manager,
                                imageUrl: "${AppCubit.get(context).publicChat[widget.index!].image}",
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                // maxHeightDiskCache:75,
                                width: 200,
                                height: MediaQuery.of(context).size.height*.2,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ):
                  (AppCubit.get(context).publicChat[widget.index!].video != null)
                      ?Container(
                    width: MediaQuery.of(context).size.width*.74,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5
                    ),
                    decoration:  BoxDecoration(
                          color: AppColors.myGrey,
                          borderRadius:const  BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text('${AppCubit.get(context).publicChat[widget.index!].senderName}',
                              style:  TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9,
                                  color: AppColors.primaryColor1,
                                  fontFamily: AppStrings.appFont
                              ),

                            ),
                            const SizedBox(height: 5,),
                            Stack(
                    children: [
                            Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                height: MediaQuery.of(context).size.height*.25,
                                width: MediaQuery.of(context).size.width*.74,
                                child: mymessageController.value.isInitialized
                                    ? AspectRatio(
                                    aspectRatio: mymessageController.value.aspectRatio,
                                    child: CachedVideoPlayer(mymessageController))
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
                                      if(mymessageController.value.isPlaying){
                                        mymessageController.pause();
                                      }else{
                                        mymessageController.play();
                                      }
                                    });
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.primaryColor1,
                                    radius: 20,
                                    child: mymessageController.value.isPlaying? const Icon(Icons.pause):const Icon(Icons.play_arrow),
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
                      color: AppColors.myGrey,
                      borderRadius:const  BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${AppCubit.get(context).publicChat[widget.index!].senderName}',
                          style:  TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                              color: AppColors.primaryColor1,
                              fontFamily: AppStrings.appFont
                          ),

                        ),
                        const SizedBox(height: 5,),
                        VoiceMessage(
                          audioSrc: '${AppCubit.get(context).publicChat[widget.hashCode].voice}',
                          played: true, // To show played badge or not.
                          me: true, // Set message side.
                          contactBgColor:AppColors.myGrey ,

                          contactFgColor: Colors.white,
                          contactPlayIconColor: AppColors.primaryColor1,
                          onPlay: () {

                          }, // Do something when voice played.
                        ),
                      ],
                    ),
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
