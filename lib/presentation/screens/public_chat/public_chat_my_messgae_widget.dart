// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/private_chat/open_full_video_private_chat.dart';
import 'package:fanchat/presentation/screens/show_home_image.dart';
import 'package:fanchat/presentation/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_message_package/voice_message_package.dart';

class MyMessagePublicChatWidget extends StatefulWidget {
  int? index;

  MyMessagePublicChatWidget({super.key, this.index});

  @override
  State<MyMessagePublicChatWidget> createState() =>
      _MyMessagePublicChatWidgetState();
}

class _MyMessagePublicChatWidgetState extends State<MyMessagePublicChatWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Align(
          alignment: Alignment.topRight,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  AppCubit.get(context)
                      .getUserProfilePosts(
                          id: '${AppCubit.get(context).publicChat[widget.index!].senderId}')
                      .then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return UserProfile(
                        userId:
                            '${AppCubit.get(context).publicChat[widget.index!].senderId}',
                        userImage:
                            '${AppCubit.get(context).publicChat[widget.index!].senderImage}',
                        userName:
                            '${AppCubit.get(context).publicChat[widget.index!].senderName}',
                      );
                    }));
                  });
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.myGrey,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        '${AppCubit.get(context).publicChat[widget.index!].senderImage}'),
                    radius: 17,
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  (AppCubit.get(context).publicChat[widget.index!].text != "")
                      ? Material(
                          color: const Color(0xffb1b2ff).withOpacity(.10),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .74,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xffb1b2ff).withOpacity(.10),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      '${AppCubit.get(context).publicChat[widget.index!].senderName}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 9,
                                          color: Color(0xfffbf7c2),
                                          fontFamily: AppStrings.appFont),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    ' ${AppCubit.get(context).publicChat[widget.index!].text}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Color(0xfffbf7c2),
                                        fontFamily: AppStrings.appFont),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : (AppCubit.get(context)
                                  .publicChat[widget.index!]
                                  .image !=
                              null)
                          ? Container(
                              width: MediaQuery.of(context).size.width * .74,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xffb1b2ff).withOpacity(.10),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Text(
                                        '${AppCubit.get(context).publicChat[widget.index!].senderName}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 9,
                                            color: Color(0xfffbf7c2),
                                            fontFamily: AppStrings.appFont),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Stack(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ShowHomeImage(
                                                              image: AppCubit.get(
                                                                      context)
                                                                  .publicChat[
                                                                      widget
                                                                          .index!]
                                                                  .image)));
                                            },
                                            child: Material(
                                              elevation: 100,
                                              shadowColor:
                                                  const Color(0xffb1b2ff)
                                                      .withOpacity(.16),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                              child: CachedNetworkImage(
                                                cacheManager:
                                                    AppCubit.get(context)
                                                        .manager,
                                                imageUrl:
                                                    "${AppCubit.get(context).publicChat[widget.index!].image}",
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                // maxHeightDiskCache:75,

                                                fit: BoxFit.contain,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : (AppCubit.get(context)
                                      .publicChat[widget.index!]
                                      .publicChatThumbnail !=
                                  null)
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width * .74,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffb1b2ff)
                                        .withOpacity(.10),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: Text(
                                            '${AppCubit.get(context).publicChat[widget.index!].senderName}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 9,
                                                color: Color(0xfffbf7c2),
                                                fontFamily: AppStrings.appFont),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Stack(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                    return OpenFullVideoPrivateChat(
                                                        controller: AppCubit
                                                                .get(context)
                                                            .publicChat[
                                                                widget.index!]
                                                            .video);
                                                  }));
                                                },
                                                child: Material(
                                                  elevation: 100,
                                                  shadowColor:
                                                      const Color(0xffb1b2ff)
                                                          .withOpacity(.16),
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    cacheManager:
                                                        AppCubit.get(context)
                                                            .manager,
                                                    imageUrl:
                                                        "${AppCubit.get(context).publicChat[widget.index!].publicChatThumbnail}",
                                                    placeholder: (context,
                                                            url) =>
                                                        const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    // maxHeightDiskCache:75,

                                                    fit: BoxFit.contain,
                                                  ),
                                                )),
                                            Positioned(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .01,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .01,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (_) {
                                                      return OpenFullVideoPrivateChat(
                                                          controller: AppCubit
                                                                  .get(context)
                                                              .publicChat[
                                                                  widget.index!]
                                                              .video);
                                                    }));
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors
                                                        .white
                                                        .withOpacity(.5),
                                                    radius: 25,
                                                    child: Icon(
                                                      Icons.play_arrow,
                                                      size: 40,
                                                      color: AppColors
                                                          .primaryColor1
                                                          .withOpacity(.8),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  width:
                                      MediaQuery.of(context).size.width * .60,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffb1b2ff)
                                        .withOpacity(.10),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AppCubit.get(context).publicChat[widget.index!].senderName}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 9,
                                            color: Color(0xfffbf7c2),
                                            fontFamily: AppStrings.appFont),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      VoiceMessage(
                                        audioSrc:
                                            '${AppCubit.get(context).publicChat[widget.index!].voice}',
                                        played:
                                            true, // To show played badge or not.
                                        me: true, // Set message side.
                                        contactBgColor: AppColors.myGrey,

                                        contactFgColor: Colors.white,
                                        contactPlayIconColor:
                                            AppColors.primaryColor1,
                                        onPlay:
                                            () {}, // Do something when voice played.
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
