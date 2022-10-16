import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/advertising_cubit/advertising_cubit.dart';
import 'package:fanchat/business_logic/advertising_cubit/advertising_state.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/advertising/advertising_full_post.dart';
import 'package:fanchat/presentation/screens/advertising/advertising_full_video.dart';
import 'package:fanchat/presentation/screens/fan/fan_full_post.dart';
import 'package:fanchat/presentation/screens/fan/fan_full_video.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class AdvertisingAreaWidget extends StatefulWidget {
  int? index;
  AdvertisingAreaWidget({Key? key, this.index}) : super(key: key);

  @override
  State<AdvertisingAreaWidget> createState() => _AdvertisingAreaWidgetState();
}

class _AdvertisingAreaWidgetState extends State<AdvertisingAreaWidget> {
  VideoPlayerController ?videoPlayerController;
  Future <void> ?intilize;

  @override
  void initState() {
    videoPlayerController=VideoPlayerController.network(
        AdvertisingCubit.get(context).advertising[widget.index!].postVideo!
    );
    intilize=videoPlayerController!.initialize();
    videoPlayerController!.setLooping(true);
    videoPlayerController!.setVolume(1.0);    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdvertisingCubit,AdvertisingState>(
        builder: (context , state){
          return Column(
            children: [
              InkWell(
                  onTap: (){
                    // (AdvertisingCubit.get(context).advertising[widget.index!].postImage!="")?
                    // Navigator.push(context, MaterialPageRoute(builder: (_){
                    //   return AdvertisingFullPost(image: '${AdvertisingCubit.get(context).advertising[widget.index!].postImage}',imageLink: '',);
                    // })):Navigator.push(context, MaterialPageRoute(builder: (_){
                    //   return AdvertisingFullVideo(
                    //       videoLink: '',
                    //       video: '${AdvertisingCubit.get(context).advertising[widget.index!].postVideo}');
                    //
                    // }));
                    AdvertisingCubit.get(context).toAdvertisingLink(
                        advertisingLink: AdvertisingCubit.get(context).advertising[widget.index!].advertisingLink!
                    );
                  },
                  child: (AdvertisingCubit.get(context).advertising[widget.index!].postImage!="")
                      ?Stack(
                    children: [
                      // Image(
                      //   height: MediaQuery.of(context).size.height*.2,
                      //   fit: BoxFit.fill,
                      //   image:
                      //   NetworkImage('${AppCubit.get(context).fans[widget.index!].postImage}') as ImageProvider,
                      // ),
                      CachedNetworkImage(
                        cacheManager: AdvertisingCubit.get(context).manager,
                        imageUrl: "${AdvertisingCubit.get(context).advertising[widget.index!].postImage}",
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        // maxHeightDiskCache:75,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*.24,
                        fit: BoxFit.fill,
                      ),
                      // Positioned(
                      //   top: 0,
                      //   right: 0,
                      //   child: IconButton(
                      //       onPressed: (){
                      //       },
                      //       icon: CircleAvatar(radius: 15, child: Icon(Icons.image,color: AppColors.myWhite,size: 15,))
                      //   ),
                      // ),
                      // Positioned(
                      //   top: 40,
                      //   right: 0,
                      //   child: IconButton(
                      //       onPressed: (){
                      //         AdvertisingCubit.get(context).toAdvertisingLink(
                      //             advertisingLink: AdvertisingCubit.get(context).advertising[widget.index!].advertisingLink!
                      //         );
                      //       },
                      //       icon: CircleAvatar(radius: 15, child: Icon(Icons.link_outlined,color: AppColors.myWhite,size: 15,))
                      //   ),
                      // ),

                    ],
                  )
                      :Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*.24,
                        width: double.infinity,
                        child: FutureBuilder(
                          future: intilize,
                          builder: (context,snapshot){
                            if(snapshot.connectionState == ConnectionState.done){
                              return AspectRatio(
                                aspectRatio: videoPlayerController!.value.aspectRatio,
                                child: VideoPlayer(videoPlayerController!),
                              );
                            }
                            else{
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
                            onTap: (){
                              setState((){
                                if(videoPlayerController!.value.isPlaying){
                                  videoPlayerController!.pause();
                                }else{
                                  videoPlayerController!.play();
                                }
                              });
                            },
                            child: videoPlayerController!.value.isPlaying?  CircleAvatar(
                                radius: 15,
                                backgroundColor:Colors.blue.withOpacity(.6),
                                child: Icon(Icons.pause,color: AppColors.myWhite,size: 15,)
                            ): CircleAvatar(
                                radius: 15,
                                backgroundColor:Colors.blue.withOpacity(.6),
                                child: Icon(Icons.play_arrow,color: AppColors.myWhite,size: 15)
                            ),
                          )
                      ),
                      // Positioned(
                      //   top: 40,
                      //   right: 0,
                      //   child: IconButton(
                      //       onPressed: (){
                      //         AdvertisingCubit.get(context).toAdvertisingLink(
                      //           advertisingLink: AdvertisingCubit.get(context).advertising[widget.index!].advertisingLink!
                      //         );
                      //       },
                      //       icon: CircleAvatar(radius: 15, child: Icon(Icons.link_outlined,color: AppColors.myWhite,size: 15,))
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
            videoPlayerController!.pause();
            // videoPlayerController!.pause();
          }
        });
  }
}
