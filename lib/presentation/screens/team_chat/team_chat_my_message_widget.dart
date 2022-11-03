import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/message_model.dart';
import 'package:fanchat/presentation/screens/home_screen.dart';
import 'package:fanchat/presentation/screens/private_chat/open_full_video_private_chat.dart';
import 'package:fanchat/presentation/screens/show_home_image.dart';
import 'package:fanchat/presentation/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:voice_message_package/voice_message_package.dart';

class MyMessageTeamChatWidget extends StatefulWidget {
  int ?index;

  MyMessageTeamChatWidget({Key? key,this.index}) : super(key: key);

  @override
  State<MyMessageTeamChatWidget> createState() => _MyMessageTeamChatWidgetState();
}

class _MyMessageTeamChatWidgetState extends State<MyMessageTeamChatWidget> with AutomaticKeepAliveClientMixin {

  late VideoPlayerController mymessageController;

  @override
  void initState() {
    mymessageController = VideoPlayerController.network(
        "${AppCubit.get(context).teamChat[widget.index!].video}");
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
          alignment:Alignment.topRight,
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  AppCubit.get(context).getUserProfilePosts(id: '${AppCubit.get(context).teamChat[widget.index!].senderId}').then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (_){
                      return UserProfile(
                        userId: '${AppCubit.get(context).teamChat[widget.index!].senderId}',
                        userImage: '${AppCubit.get(context).teamChat[widget.index!].senderImage}',
                        userName: '${AppCubit.get(context).teamChat[widget.index!].senderName}',
                      );
                    }));
                  });
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.myGrey,
                  child: CircleAvatar(
                    backgroundImage:  NetworkImage('${AppCubit.get(context).teamChat[widget.index!].senderImage}' ),
                    radius: 17,
                    backgroundColor: Colors.blue,
                  ),

                ),
              ),
              const SizedBox(width: 5,),
              Column(
                children: [
                  (AppCubit.get(context).teamChat[widget.index!].text!="")
                      ?Container(
                    width: MediaQuery.of(context).size.width*.74,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5
                    ),
                    decoration:  BoxDecoration(
                      color: const Color(0xffb1b2ff).withOpacity(.10),
                      borderRadius:const  BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${AppCubit.get(context).teamChat[widget.index!].senderName}',
                          style:  TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                              color:  Color(0xfffbf7c2),
                              fontFamily: AppStrings.appFont
                          ),

                        ),
                        const SizedBox(height: 5,),
                        Text('${AppCubit.get(context).teamChat[widget.index!].text}',
                          style:  const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color:  Color(0xfffbf7c2),
                              fontFamily: AppStrings.appFont
                          ),
                        )

                      ],
                    ),
                  ):
                  (AppCubit.get(context).teamChat[widget.index!].image !=null) ?
                  Container(
                    width: MediaQuery.of(context).size.width*.60,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5
                    ),
                    decoration:  BoxDecoration(
                      color: const Color(0xffb1b2ff).withOpacity(.10),
                      borderRadius:const  BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${AppCubit.get(context).teamChat[widget.index!].senderName}',
                            style:  TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 9,
                                color:  Color(0xfffbf7c2),
                                fontFamily: AppStrings.appFont
                            ),

                          ),
                          const SizedBox(height: 5,),
                          Material(
                            color: const Color(0xffb1b2ff).withOpacity(.10),
                            elevation: 0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),

                            ),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowHomeImage(image: AppCubit.get(context).teamChat[widget.index!].image)));
                              },
                              child: CachedNetworkImage(
                                cacheManager: AppCubit.get(context).manager,
                                imageUrl: "${AppCubit.get(context).teamChat[widget.index!].image}",
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                // maxHeightDiskCache:75,

                                fit: BoxFit.cover,
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                  ):
                  (AppCubit.get(context).teamChat[widget.index!].video != null)
                      ?Container(
                    width: MediaQuery.of(context).size.width*.66,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 5,
                    ),
                    decoration:  BoxDecoration(
                      color: const Color(0xffb1b2ff).withOpacity(.10),
                      borderRadius:const  BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('${AppCubit.get(context).teamChat[widget.index!].senderName}',
                            style:  TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 9,
                                color:  Color(0xfffbf7c2),
                                fontFamily: AppStrings.appFont
                            ),

                          ),
                        ),
                        const SizedBox(height: 5,),
                        Stack(
                          children: [
                            mymessageController.value.isInitialized
                                ? InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_){
                                  return OpenFullVideoPrivateChat(controller: mymessageController);
                                }));
                              },
                                  child: Container(
                              padding: const EdgeInsets.only(left: 5),
                              width: MediaQuery.of(context).size.width*.65,
                              child: AspectRatio(
                                    aspectRatio:mymessageController.value.size.width/mymessageController.value.size.height,
                                    child:VideoPlayer(mymessageController)),
                            ),
                                )
                                : const Center(child: CircularProgressIndicator()),

                            Positioned(
                                top: MediaQuery.of(context).size.height*.01,
                                right: MediaQuery.of(context).size.height*.01,
                                child: InkWell(
                                  onTap: (){
                                    // setState((){
                                    //   if(mymessageController.value.isPlaying){
                                    //     mymessageController.pause();
                                    //   }else{
                                    //     mymessageController.play();
                                    //   }
                                    // });
                                    mymessageController.play();
                                    isPostPlaying=false;
                                    Navigator.push(context, MaterialPageRoute(builder: (_){
                                      return OpenFullVideoPrivateChat(controller: mymessageController);
                                    }));
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white.withOpacity(.5),
                                    radius: 25,
                                    child: mymessageController.value.isPlaying? Icon(Icons.pause,size: 40,color:AppColors.primaryColor1.withOpacity(.8),): Icon(Icons.play_arrow,size: 40,color:AppColors.primaryColor1.withOpacity(.8),),
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
                      color: const Color(0xffb1b2ff).withOpacity(.10),
                      borderRadius:const  BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${AppCubit.get(context).teamChat[widget.index!].senderName}',
                          style:  TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                              color:  Color(0xfffbf7c2),
                              fontFamily: AppStrings.appFont
                          ),

                        ),
                        const SizedBox(height: 5,),
                        VoiceMessage(
                          audioSrc: '${AppCubit.get(context).teamChat[widget.index!].voice}',
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
