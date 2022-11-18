// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class ProfileAreaWidget extends StatefulWidget {
  int? index;
  ProfileAreaWidget({super.key, this.index});

  @override
  State<ProfileAreaWidget> createState() => _ProfileAreaWidgetState();
}

class _ProfileAreaWidgetState extends State<ProfileAreaWidget> {
  VideoPlayerController? videoPlayerController;
  Future<void>? intilize;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(
        AppCubit.get(context).profileImages[widget.index!].postVideo!);
    intilize = videoPlayerController!.initialize();
    videoPlayerController!.setLooping(true);
    videoPlayerController!.setVolume(1.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          return Column(
            children: [
              InkWell(
                  onTap: () {
                    // (AppCubit.get(context).profileImages[widget.index!].postImage!="")?
                    // Navigator.push(context, MaterialPageRoute(builder: (_){
                    //   return FanFullPost(image: '${AppCubit.get(context).profileImages[widget.index!].postImage}',userImage: '${AppCubit.get(context).profileImages[widget.index!].image}',userName: '${AppCubit.get(context).profileImages[widget.index!].name}',);
                    // })):Navigator.push(context, MaterialPageRoute(builder: (_){
                    //   return FanFullVideo(video: '${AppCubit.get(context).profileImages[widget.index!].postVideo}',userImage: '${AppCubit.get(context).profileImages[widget.index!].image}',userName: '${AppCubit.get(context).profileImages[widget.index!].name}',);
                    // }));
                  },
                  child: (AppCubit.get(context)
                              .profileImages[widget.index!]
                              .postImage !=
                          "")
                      ? Stack(
                          children: [
                            // Image(
                            //   height: MediaQuery.of(context).size.height*.2,
                            //   fit: BoxFit.fill,
                            //   image:
                            //   NetworkImage('${AppCubit.get(context).profileImages[widget.index!].postImage}') as ImageProvider,
                            // ),
                            CachedNetworkImage(
                              cacheManager: AppCubit.get(context).manager,
                              imageUrl:
                                  "${AppCubit.get(context).profileImages[widget.index!].postImage}",
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              // maxHeightDiskCache:75,
                              width: 200,
                              height: MediaQuery.of(context).size.height * .18,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.image,
                                    color: AppColors.myWhite,
                                  )),
                            ),
                            // Positioned(
                            //   bottom: 0,
                            //   right: 0,
                            //   child: Row(
                            //     children: [
                            //       Text('${AppCubit.get(context).profileImages[widget.index!].likes}',
                            //         style: TextStyle(
                            //             color: AppColors.myWhite,
                            //             fontSize: 13,
                            //             fontWeight: FontWeight.w500,
                            //             fontFamily: AppStrings.appFont
                            //         ),),
                            //       IconButton(
                            //           padding:EdgeInsets.zero,
                            //           constraints: BoxConstraints(),
                            //           onPressed:(){
                            //             AppCubit.get(context).likePosts('${AppCubit.get(context).profileImages[widget.index!].postId}',AppCubit.get(context).profileImages[widget.index!].likes!);
                            //
                            //             if(CashHelper.getData(key: '${AppCubit.get(context).profileImages[widget.index!].postId}')==null || CashHelper.getData(key: '${AppCubit.get(context).profileImages[widget.index!].postId}')==false){
                            //               setState(() {
                            //                 AppCubit.get(context).profileImages[widget.index!].likes=AppCubit.get(context).profileImages[widget.index!].likes!+1;
                            //               });
                            //               AppCubit.get(context).isLikeFan[widget.index!]=true;
                            //               CashHelper.saveData(key: '${AppCubit.get(context).profileImages[widget.index!].postId}',value:AppCubit.get(context).isLikeFan[widget.index!] );
                            //               setState(() {
                            //                 FirebaseFirestore.instance
                            //                     .collection('users')
                            //                     .doc('${AppStrings.uId}')
                            //                     .collection('profileImages')
                            //                     .doc('${AppCubit.get(context).profileImages[widget.index!].postId}')
                            //                     .update({
                            //                   'likes':AppCubit.get(context).profileImages[widget.index!].likes
                            //                 }).then((value){
                            //                   print('Siiiiiiiiiiiiiiiiiiiiiiii');
                            //
                            //                 });
                            //               });
                            //
                            //             }
                            //             else{
                            //               setState(() {
                            //                 AppCubit.get(context).profileImages[widget.index!].likes=AppCubit.get(context).profileImages[widget.index!].likes!-1;
                            //
                            //               });
                            //               AppCubit.get(context).isLikeFan[widget.index!]=false;
                            //               CashHelper.saveData(key: '${AppCubit.get(context).profileImages[widget.index!].postId}',value:AppCubit.get(context).isLikeFan[widget.index!] );
                            //               setState(() {
                            //                 FirebaseFirestore.instance
                            //                     .collection('users')
                            //                     .doc('${AppStrings.uId}')
                            //                     .collection('profileImages')
                            //                     .doc('${AppCubit.get(context).profileImages[widget.index!].postId}')
                            //                     .update({
                            //                   'likes':AppCubit.get(context).profileImages[widget.index!].likes
                            //                 }).then((value){
                            //                   printMessage('This is right ${AppCubit.get(context).profileImages[widget.index!].likes}');
                            //                   print('Siiiiiiiiiiiiiiiiiiiiiiii');
                            //
                            //                 });
                            //               });
                            //
                            //             }
                            //           },
                            //           icon: CashHelper.getData(key: '${AppCubit.get(context).profileImages[widget.index!].postId}')==null ?
                            //           Icon(Icons.favorite_outline,color: AppColors.myWhite,size: 20):CashHelper.getData(key: '${AppCubit.get(context).profileImages[widget.index!].postId}') ?Icon(Icons.favorite,color: Colors.red,size: 20):
                            //           Icon(Icons.favorite_outline,color: AppColors.myWhite,size: 20)),
                            //     ],
                            //   ),
                            // ),
                          ],
                        )
                      : Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .18,
                              width: double.infinity,
                              child: FutureBuilder(
                                future: intilize,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return AspectRatio(
                                      aspectRatio: videoPlayerController!
                                          .value.aspectRatio,
                                      child:
                                          VideoPlayer(videoPlayerController!),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ),
                            Positioned(
                                top: 10,
                                right: 10,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (videoPlayerController!
                                          .value.isPlaying) {
                                        videoPlayerController!.pause();
                                      } else {
                                        videoPlayerController!.play();
                                      }
                                    });
                                  },
                                  child: videoPlayerController!.value.isPlaying
                                      ? CircleAvatar(
                                          radius: 15,
                                          child: Icon(
                                            Icons.pause,
                                            color: AppColors.myWhite,
                                            size: 15,
                                          ))
                                      : CircleAvatar(
                                          radius: 15,
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: AppColors.myWhite,
                                            size: 15,
                                          )),
                                )),
                            // Positioned(
                            //   bottom: 0,
                            //   right: 0,
                            //   child: Row(
                            //     children: [
                            //       Text('${AppCubit.get(context).profileImages[widget.index!].likes}',
                            //         style: TextStyle(
                            //             color: AppColors.myWhite,
                            //             fontSize: 13,
                            //             fontWeight: FontWeight.w500,
                            //             fontFamily: AppStrings.appFont
                            //         ),),
                            //       IconButton(
                            //           padding:EdgeInsets.zero,
                            //           constraints: BoxConstraints(),
                            //           onPressed:(){
                            //             AppCubit.get(context).likePosts('${AppCubit.get(context).profileImages[widget.index!].postId}',AppCubit.get(context).profileImages[widget.index!].likes!);
                            //
                            //             if(CashHelper.getData(key: '${AppCubit.get(context).profileImages[widget.index!].postId}')==null || CashHelper.getData(key: '${AppCubit.get(context).profileImages[widget.index!].postId}')==false){
                            //               setState(() {
                            //                 AppCubit.get(context).profileImages[widget.index!].likes=AppCubit.get(context).profileImages[widget.index!].likes!+1;
                            //               });
                            //               AppCubit.get(context).isLikeFan[widget.index!]=true;
                            //               CashHelper.saveData(key: '${AppCubit.get(context).profileImages[widget.index!].postId}',value:AppCubit.get(context).isLikeFan[widget.index!] );
                            //               setState(() {
                            //                 FirebaseFirestore.instance
                            //                     .collection('users')
                            //                     .doc('${AppStrings.uId}')
                            //                     .collection('profileImages')
                            //                     .doc('${AppCubit.get(context).profileImages[widget.index!].postId}')
                            //                     .update({
                            //                   'likes':AppCubit.get(context).profileImages[widget.index!].likes
                            //                 }).then((value){
                            //                   print('Siiiiiiiiiiiiiiiiiiiiiiii');
                            //
                            //                 });
                            //               });
                            //
                            //             }
                            //             else{
                            //               setState(() {
                            //                 AppCubit.get(context).profileImages[widget.index!].likes=AppCubit.get(context).profileImages[widget.index!].likes!-1;
                            //
                            //               });
                            //               AppCubit.get(context).isLikeFan[widget.index!]=false;
                            //               CashHelper.saveData(key: '${AppCubit.get(context).profileImages[widget.index!].postId}',value:AppCubit.get(context).isLikeFan[widget.index!] );
                            //               setState(() {
                            //                 FirebaseFirestore.instance
                            //                     .collection('users')
                            //                     .doc('${AppStrings.uId}')
                            //                     .collection('profileImages')
                            //                     .doc('${AppCubit.get(context).profileImages[widget.index!].postId}')
                            //                     .update({
                            //                   'likes':AppCubit.get(context).profileImages[widget.index!].likes
                            //                 }).then((value){
                            //                   printMessage('This is right ${AppCubit.get(context).profileImages[widget.index!].likes}');
                            //                   print('Siiiiiiiiiiiiiiiiiiiiiiii');
                            //
                            //                 });
                            //               });
                            //
                            //             }
                            //           },
                            //           icon: CashHelper.getData(key: '${AppCubit.get(context).profileImages[widget.index!].postId}')==null ?
                            //           Icon(Icons.favorite_outline,color: AppColors.myWhite,size: 20):CashHelper.getData(key: '${AppCubit.get(context).profileImages[widget.index!].postId}') ?Icon(Icons.favorite,color: Colors.red,size: 20):
                            //           Icon(Icons.favorite_outline,color: AppColors.myWhite,size: 20)),
                            //     ],
                            //   ),
                            // ),
                          ],
                        )),
            ],
          );
        },
        listener: (context, state) {});
  }
}
