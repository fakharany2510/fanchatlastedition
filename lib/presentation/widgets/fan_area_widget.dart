// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
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

class FanAreaWidget extends StatefulWidget {
  int? index;

  FanAreaWidget({super.key, this.index});

  @override
  State<FanAreaWidget> createState() => _FanAreaWidgetState();
}

class _FanAreaWidgetState extends State<FanAreaWidget>
    with AutomaticKeepAliveClientMixin {
  //final FijkPlayer player = FijkPlayer();

  // void initState() {
  //   player.start();
  //   player.setDataSource(
  //     AppCubit.get(context).fans[widget.index!].postVideo!,
  //     autoPlay: false,
  //     showCover: true,
  //   );
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   //  fanVideoPlayerController!.dispose();
  //   player.pause();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<AppCubit, AppState>(builder: (context, state) {
      return InkWell(
        onTap: () {
          // player.pause();
          (AppCubit.get(context).fans[widget.index!].postImage != "")
              ? Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return FanFullPost(
                    image:
                        '${AppCubit.get(context).fans[widget.index!].postImage}',
                    userImage:
                        '${AppCubit.get(context).fans[widget.index!].image}',
                    userName:
                        '${AppCubit.get(context).fans[widget.index!].name}',
                    userId:
                        '${AppCubit.get(context).fans[widget.index!].userId}',
                  );
                }))
              : Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return FanFullVideo(
                    video:
                        '${AppCubit.get(context).fans[widget.index!].postVideo}',
                    userImage:
                        '${AppCubit.get(context).fans[widget.index!].image}',
                    userName:
                        '${AppCubit.get(context).fans[widget.index!].name}',
                    userId:
                        '${AppCubit.get(context).fans[widget.index!].userId}',
                  );
                }));
        },
        child: (AppCubit.get(context).fans[widget.index!].postImage != "")
            ? Stack(
                children: [
                  // Image(
                  //   height: MediaQuery.of(context).size.height*.2,
                  //   fit: BoxFit.fill,
                  //   image:
                  //   NetworkImage('${AppCubit.get(context).fans[widget.index!].postImage}') as ImageProvider,
                  // ),
                  CachedNetworkImage(
                    cacheManager: AppCubit.get(context).manager,
                    imageUrl:
                        "${AppCubit.get(context).fans[widget.index!].postImage}",
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    // maxHeightDiskCache:75,
                    width: 200,
                    height: MediaQuery.of(context).size.height * .18,
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
                    bottom: 4,
                    right: 5,
                    child: Row(
                      children: [
                        Text(
                          '${AppCubit.get(context).fans[widget.index!].likes}',
                          style: TextStyle(
                              color: AppColors.myWhite,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppStrings.appFont),
                        ),
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              AppCubit.get(context).likePosts(
                                  '${AppCubit.get(context).fans[widget.index!].postId}',
                                  AppCubit.get(context)
                                      .fans[widget.index!]
                                      .likes!);

                              if (CashHelper.getData(
                                          key:
                                              '${AppCubit.get(context).fans[widget.index!].postId}') ==
                                      null ||
                                  CashHelper.getData(
                                          key:
                                              '${AppCubit.get(context).fans[widget.index!].postId}') ==
                                      false) {
                                setState(() {
                                  AppCubit.get(context)
                                      .fans[widget.index!]
                                      .likes = AppCubit.get(context)
                                          .fans[widget.index!]
                                          .likes! +
                                      1;
                                });
                                AppCubit.get(context).isLikeFan[widget.index!] =
                                    true;
                                CashHelper.saveData(
                                    key:
                                        '${AppCubit.get(context).fans[widget.index!].postId}',
                                    value: AppCubit.get(context)
                                        .isLikeFan[widget.index!]);
                                setState(() {
                                  FirebaseFirestore.instance
                                      .collection('fan')
                                      .doc(
                                          '${AppCubit.get(context).fans[widget.index!].postId}')
                                      .update({
                                    'likes': AppCubit.get(context)
                                        .fans[widget.index!]
                                        .likes
                                  }).then((value) {
                                    // print('Siiiiiiiiiiiiiiiiiiiiiiii');
                                  });
                                });
                              } else {
                                setState(() {
                                  AppCubit.get(context)
                                      .fans[widget.index!]
                                      .likes = AppCubit.get(context)
                                          .fans[widget.index!]
                                          .likes! -
                                      1;
                                });
                                AppCubit.get(context).isLikeFan[widget.index!] =
                                    false;
                                CashHelper.saveData(
                                    key:
                                        '${AppCubit.get(context).fans[widget.index!].postId}',
                                    value: AppCubit.get(context)
                                        .isLikeFan[widget.index!]);
                                setState(() {
                                  FirebaseFirestore.instance
                                      .collection('fan')
                                      .doc(
                                          '${AppCubit.get(context).fans[widget.index!].postId}')
                                      .update({
                                    'likes': AppCubit.get(context)
                                        .fans[widget.index!]
                                        .likes
                                  }).then((value) {
                                    printMessage(
                                        'This is right ${AppCubit.get(context).fans[widget.index!].likes}');
                                    // print('Siiiiiiiiiiiiiiiiiiiiiiii');
                                  });
                                });
                              }
                            },
                            icon: CashHelper.getData(
                                        key:
                                            '${AppCubit.get(context).fans[widget.index!].postId}') ==
                                    null
                                ? Icon(Icons.favorite_outline,
                                    color: AppColors.myWhite, size: 20)
                                : CashHelper.getData(
                                        key:
                                            '${AppCubit.get(context).fans[widget.index!].postId}')
                                    ? const Icon(Icons.favorite,
                                        color: Colors.red, size: 20)
                                    : Icon(Icons.favorite_outline,
                                        color: AppColors.myWhite, size: 20)),
                      ],
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .18,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      cacheManager: AppCubit.get(context).manager,
                      imageUrl: AppCubit.get(context)
                          .fans[widget.index!]
                          .thumbnailFanPosts!,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      // maxHeightDiskCache:75,

                      fit: BoxFit.cover,
                    ),

                    //  Image(
                    //    image: NetworkImage(AppCubit.get(context).fans[widget.index!].thumbnailFanPosts!),
                    // fit: BoxFit.cover,
                    //  )
                  ),
                  //  player==null ?Text('') :
                  Positioned(
                    top: MediaQuery.of(context).size.height * .05,
                    right: MediaQuery.of(context).size.height * .04,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.black.withOpacity(.2),
                      child: Icon(
                        Icons.play_arrow,
                        size: 40,
                        color: Colors.white.withOpacity(.7),
                      ),
                    ),
                  ),
                  //player==null ?
                  // Text(''):
                  Positioned(
                    bottom: 4,
                    right: 5,
                    child: Row(
                      children: [
                        Text(
                          '${AppCubit.get(context).fans[widget.index!].likes}',
                          style: TextStyle(
                              color: AppColors.myWhite,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppStrings.appFont),
                        ),
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              AppCubit.get(context).likePosts(
                                  '${AppCubit.get(context).fans[widget.index!].postId}',
                                  AppCubit.get(context)
                                      .fans[widget.index!]
                                      .likes!);

                              if (CashHelper.getData(
                                          key:
                                              '${AppCubit.get(context).fans[widget.index!].postId}') ==
                                      null ||
                                  CashHelper.getData(
                                          key:
                                              '${AppCubit.get(context).fans[widget.index!].postId}') ==
                                      false) {
                                setState(() {
                                  AppCubit.get(context)
                                      .fans[widget.index!]
                                      .likes = AppCubit.get(context)
                                          .fans[widget.index!]
                                          .likes! +
                                      1;
                                });
                                AppCubit.get(context).isLikeFan[widget.index!] =
                                    true;
                                CashHelper.saveData(
                                    key:
                                        '${AppCubit.get(context).fans[widget.index!].postId}',
                                    value: AppCubit.get(context)
                                        .isLikeFan[widget.index!]);
                                setState(() {
                                  FirebaseFirestore.instance
                                      .collection('fan')
                                      .doc(
                                          '${AppCubit.get(context).fans[widget.index!].postId}')
                                      .update({
                                    'likes': AppCubit.get(context)
                                        .fans[widget.index!]
                                        .likes
                                  }).then((value) {
                                    // print('Siiiiiiiiiiiiiiiiiiiiiiii');
                                  });
                                });
                              } else {
                                setState(() {
                                  AppCubit.get(context)
                                      .fans[widget.index!]
                                      .likes = AppCubit.get(context)
                                          .fans[widget.index!]
                                          .likes! -
                                      1;
                                });
                                AppCubit.get(context).isLikeFan[widget.index!] =
                                    false;
                                CashHelper.saveData(
                                    key:
                                        '${AppCubit.get(context).fans[widget.index!].postId}',
                                    value: AppCubit.get(context)
                                        .isLikeFan[widget.index!]);
                                setState(() {
                                  FirebaseFirestore.instance
                                      .collection('fan')
                                      .doc(
                                          '${AppCubit.get(context).fans[widget.index!].postId}')
                                      .update({
                                    'likes': AppCubit.get(context)
                                        .fans[widget.index!]
                                        .likes
                                  }).then((value) {
                                    printMessage(
                                        'This is right ${AppCubit.get(context).fans[widget.index!].likes}');
                                    // print('Siiiiiiiiiiiiiiiiiiiiiiii');
                                  });
                                });
                              }
                            },
                            icon: CashHelper.getData(
                                        key:
                                            '${AppCubit.get(context).fans[widget.index!].postId}') ==
                                    null
                                ? Icon(Icons.favorite_outline,
                                    color: AppColors.myWhite, size: 20)
                                : CashHelper.getData(
                                        key:
                                            '${AppCubit.get(context).fans[widget.index!].postId}')
                                    ? const Icon(Icons.favorite,
                                        color: Colors.red, size: 20)
                                    : Icon(Icons.favorite_outline,
                                        color: AppColors.myWhite, size: 20)),
                      ],
                    ),
                  ),
                ],
              ),
      );
    }, listener: (context, state) {
      if (state is NavigateScreenState) {
        // fanVideoPlayerController!.pause();
        //player.pause();
        // videoPlayerController!.pause();
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
