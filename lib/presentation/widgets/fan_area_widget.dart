import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/fan/fan_full_post.dart';
import 'package:fanchat/presentation/screens/fan/fan_full_video.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:media_cache_manager/media_cache_manager.dart';


class FanAreaWidget extends StatefulWidget {
  int? index;
  FanAreaWidget({Key? key, this.index}) : super(key: key);

  @override
  State<FanAreaWidget> createState() => _FanAreaWidgetState();
}

class _FanAreaWidgetState extends State<FanAreaWidget> {

  //bool isLoading = true;
  VideoPlayerController ?fanVideoPlayerController;
  //Future <void> ?intilize;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1),()async{
      fanVideoPlayerController=VideoPlayerController.network(
          AppCubit.get(context).fans[widget.index!].postVideo!
      );
      await fanVideoPlayerController!.initialize().then((value){
        setState((){
        //  isLoading=false;
        });
      });
    });

    super.initState();
  }
  @override
  void dispose() {
    fanVideoPlayerController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context , state){
          return Column(
            children: [
              InkWell(
                  onTap: (){
                    (AppCubit.get(context).fans[widget.index!].postImage!="")?
                    Navigator.push(context, MaterialPageRoute(builder: (_){
                      return FanFullPost(image: '${AppCubit.get(context).fans[widget.index!].postImage}',userImage: '${AppCubit.get(context).fans[widget.index!].image}',userName: '${AppCubit.get(context).fans[widget.index!].name}',userId: '${AppCubit.get(context).fans[widget.index!].userId}',);
                    })):Navigator.push(context, MaterialPageRoute(builder: (_){
                      return FanFullVideo(video: '${AppCubit.get(context).fans[widget.index!].postVideo}',userImage: '${AppCubit.get(context).fans[widget.index!].image}',userName: '${AppCubit.get(context).fans[widget.index!].name}',userId: '${AppCubit.get(context).fans[widget.index!].userId}',);
                    }));
                  },
                  child: (AppCubit.get(context).fans[widget.index!].postImage!="")
                      ?Stack(
                    children: [
                      // Image(
                      //   height: MediaQuery.of(context).size.height*.2,
                      //   fit: BoxFit.fill,
                      //   image:
                      //   NetworkImage('${AppCubit.get(context).fans[widget.index!].postImage}') as ImageProvider,
                      // ),
                       CachedNetworkImage(
                        cacheManager: AppCubit.get(context).manager,
                        imageUrl: "${AppCubit.get(context).fans[widget.index!].postImage}",
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                       // maxHeightDiskCache:75,
                            width: 200,
                            height: MediaQuery.of(context).size.height*.18,
                          fit: BoxFit.cover,
                        ),
                      // Positioned(
                      //   top: 0,
                      //   right: 0,
                      //   child: IconButton(
                      //       onPressed: (){
                      //       },
                      //       icon:Icon(Icons.image,color: AppColors.myWhite,)
                      //   ),
                      // ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Row(
                          children: [
                            Text('${AppCubit.get(context).fans[widget.index!].likes}',
                              style: TextStyle(
                                  color: AppColors.myWhite,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppStrings.appFont
                              ),),
                            IconButton(
                                padding:EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                onPressed:(){
                                  AppCubit.get(context).likePosts('${AppCubit.get(context).fans[widget.index!].postId}',AppCubit.get(context).fans[widget.index!].likes!);

                                  if(CashHelper.getData(key: '${AppCubit.get(context).fans[widget.index!].postId}')==null || CashHelper.getData(key: '${AppCubit.get(context).fans[widget.index!].postId}')==false){
                                    setState(() {
                                      AppCubit.get(context).fans[widget.index!].likes=AppCubit.get(context).fans[widget.index!].likes!+1;
                                    });
                                    AppCubit.get(context).isLikeFan[widget.index!]=true;
                                    CashHelper.saveData(key: '${AppCubit.get(context).fans[widget.index!].postId}',value:AppCubit.get(context).isLikeFan[widget.index!] );
                                    setState(() {
                                      FirebaseFirestore.instance
                                          .collection('fan')
                                          .doc('${AppCubit.get(context).fans[widget.index!].postId}')
                                          .update({
                                        'likes':AppCubit.get(context).fans[widget.index!].likes
                                      }).then((value){
                                        print('Siiiiiiiiiiiiiiiiiiiiiiii');

                                      });
                                    });

                                  }
                                  else{
                                    setState(() {
                                      AppCubit.get(context).fans[widget.index!].likes=AppCubit.get(context).fans[widget.index!].likes!-1;

                                    });
                                    AppCubit.get(context).isLikeFan[widget.index!]=false;
                                    CashHelper.saveData(key: '${AppCubit.get(context).fans[widget.index!].postId}',value:AppCubit.get(context).isLikeFan[widget.index!] );
                                    setState(() {
                                      FirebaseFirestore.instance
                                          .collection('fan')
                                          .doc('${AppCubit.get(context).fans[widget.index!].postId}')
                                          .update({
                                        'likes':AppCubit.get(context).fans[widget.index!].likes
                                      }).then((value){
                                        printMessage('This is right ${AppCubit.get(context).fans[widget.index!].likes}');
                                        print('Siiiiiiiiiiiiiiiiiiiiiiii');

                                      });
                                    });

                                  }
                                },
                                icon: CashHelper.getData(key: '${AppCubit.get(context).fans[widget.index!].postId}')==null ?
                                Icon(Icons.favorite_outline,color: AppColors.myWhite,size: 20):CashHelper.getData(key: '${AppCubit.get(context).fans[widget.index!].postId}') ?Icon(Icons.favorite,color: Colors.red,size: 20):
                                Icon(Icons.favorite_outline,color: AppColors.myWhite,size: 20)),
                          ],
                        ),
                      ),
                    ],
                  )
                      :Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*.18,
                        width: double.infinity,
                        child: DownloadMediaBuilder(
                          url: AppCubit.get(context).fans[widget.index!].postVideo!,
                          builder: (context, snapshot) {
                            if (snapshot.status == DownloadMediaStatus.loading) {
                              return Image(image:AssetImage('assets/images/load.png'));
                            }
                            if (snapshot.status == DownloadMediaStatus.success) {
                              return fanVideoPlayerController==null
                              ?Image(image:AssetImage('assets/images/load.png'))
                              :AspectRatio(
                                aspectRatio: fanVideoPlayerController!.value.aspectRatio,
                                child: VideoPlayer(fanVideoPlayerController!),
                              );
                            }
                            return Image(image:AssetImage('assets/images/nonet.jpg'),fit: BoxFit.cover,);
                          },
                        ),





                      ),
                      // Positioned(
                      //     top: 7,
                      //     right: 5,
                      //     child: InkWell(
                      //       onTap: (){
                      //         setState((){
                      //           if(fanVideoPlayerController!.value.isPlaying){
                      //             fanVideoPlayerController!.pause();
                      //           }else{
                      //             fanVideoPlayerController!.play();
                      //           }
                      //         });
                      //       },
                      //       child: fanVideoPlayerController!.value.isPlaying?  Material(elevation: 20,color: Colors.transparent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),child: CircleAvatar(radius: 15, child: Icon(Icons.pause,color: Colors.white,size: 15,),backgroundColor: Colors.white.withOpacity(.4))): Material(elevation: 20,color:Colors.transparent,shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20) ),child: CircleAvatar(radius: 15, child: Icon(Icons.play_arrow,color: Colors.white,size: 15,),backgroundColor: Colors.white.withOpacity(.4))),
                      //     )
                      // ),
                      // Positioned(
                      //   bottom: 0,
                      //   right: 5,
                      //   child: Row(
                      //     children: [
                      //       Text('${AppCubit.get(context).fans[widget.index!].likes}',
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
                      //             AppCubit.get(context).likePosts('${AppCubit.get(context).fans[widget.index!].postId}',AppCubit.get(context).fans[widget.index!].likes!);
                      //
                      //             if(CashHelper.getData(key: '${AppCubit.get(context).fans[widget.index!].postId}')==null || CashHelper.getData(key: '${AppCubit.get(context).fans[widget.index!].postId}')==false){
                      //               setState(() {
                      //                 AppCubit.get(context).fans[widget.index!].likes=AppCubit.get(context).fans[widget.index!].likes!+1;
                      //               });
                      //               AppCubit.get(context).isLikeFan[widget.index!]=true;
                      //               CashHelper.saveData(key: '${AppCubit.get(context).fans[widget.index!].postId}',value:AppCubit.get(context).isLikeFan[widget.index!] );
                      //               setState(() {
                      //                 FirebaseFirestore.instance
                      //                     .collection('fan')
                      //                     .doc('${AppCubit.get(context).fans[widget.index!].postId}')
                      //                     .update({
                      //                   'likes':AppCubit.get(context).fans[widget.index!].likes
                      //                 }).then((value){
                      //                   print('Siiiiiiiiiiiiiiiiiiiiiiii');
                      //
                      //                 });
                      //               });
                      //
                      //             }
                      //             else{
                      //               setState(() {
                      //                 AppCubit.get(context).fans[widget.index!].likes=AppCubit.get(context).fans[widget.index!].likes!-1;
                      //
                      //               });
                      //               AppCubit.get(context).isLikeFan[widget.index!]=false;
                      //               CashHelper.saveData(key: '${AppCubit.get(context).fans[widget.index!].postId}',value:AppCubit.get(context).isLikeFan[widget.index!] );
                      //               setState(() {
                      //                 FirebaseFirestore.instance
                      //                     .collection('fan')
                      //                     .doc('${AppCubit.get(context).fans[widget.index!].postId}')
                      //                     .update({
                      //                   'likes':AppCubit.get(context).fans[widget.index!].likes
                      //                 }).then((value){
                      //                   printMessage('This is right ${AppCubit.get(context).fans[widget.index!].likes}');
                      //                   print('Siiiiiiiiiiiiiiiiiiiiiiii');
                      //
                      //                 });
                      //               });
                      //
                      //             }
                      //           },
                      //           icon: CashHelper.getData(key: '${AppCubit.get(context).fans[widget.index!].postId}')==null ?
                      //           Icon(Icons.favorite_outline,color: AppColors.myWhite,size: 20):CashHelper.getData(key: '${AppCubit.get(context).fans[widget.index!].postId}') ?Icon(Icons.favorite,color: Colors.red,size: 20):
                      //           Icon(Icons.favorite_outline,color: AppColors.myWhite,size: 20)),
                      //     ],
                      //   ),
                      // ),

                    ],
                  )
              ),
            ],
          );
        },
        listener: (context , state){
          if(state is NavigateScreenState){
            fanVideoPlayerController!.pause();
          // videoPlayerController!.pause();
        }

        });
  }
}
