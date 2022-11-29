// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/private_chat/open_full_video_private_chat.dart';
import 'package:fanchat/presentation/screens/show_home_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:voice_message_package/voice_message_package.dart';

class SenderTeamChatWidget extends StatefulWidget {
  int? index;

  SenderTeamChatWidget({super.key, this.index});

  @override
  State<SenderTeamChatWidget> createState() => _SenderTeamChatWidgetState();
}

class _SenderTeamChatWidgetState extends State<SenderTeamChatWidget>
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (AppCubit.get(context).teamChat[widget.index!].text != "")
                      ? Container(
                          width: MediaQuery.of(context).size.width * .74,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xffb1b2ff).withOpacity(.16),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  '${AppCubit.get(context).userModel!.username}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 9,
                                      color: AppColors.myWhite,
                                      fontFamily: AppStrings.appFont),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  '${AppCubit.get(context).teamChat[widget.index!].text}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: AppColors.myWhite,
                                      fontFamily: AppStrings.appFont),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    DateFormat('kk:mm').format(DateTime.parse(AppCubit.get(context).teamChat[widget.index!].dateTime!).toLocal()),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Color(0xfffbf7c2),
                                        fontFamily: AppStrings.appFont),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : (AppCubit.get(context).teamChat[widget.index!].image !=
                              null)
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowHomeImage(
                                            image: AppCubit.get(context)
                                                .teamChat[widget.index!]
                                                .image)));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * .74,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xffb1b2ff).withOpacity(.16),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AppCubit.get(context).userModel!.username}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 9,
                                            color: AppColors.myWhite,
                                            fontFamily: AppStrings.appFont),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Material(
                                        elevation: 0,
                                        shadowColor: AppColors.myGrey,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: CachedNetworkImage(
                                          cacheManager:
                                              AppCubit.get(context).manager,
                                          imageUrl:
                                              "${AppCubit.get(context).teamChat[widget.index!].image}",
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          // maxHeightDiskCache:75,

                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Text(
                                            DateFormat('kk:mm').format(DateTime.parse(AppCubit.get(context).teamChat[widget.index!].dateTime!).toLocal()),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Color(0xfffbf7c2),
                                                fontFamily: AppStrings.appFont),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : (AppCubit.get(context)
                                      .teamChat[widget.index!]
                                      .teamChatThumbnail !=
                                  null)
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width * .66,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffb1b2ff)
                                        .withOpacity(.16),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          '${AppCubit.get(context).userModel!.username}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 9,
                                              color: AppColors.myWhite,
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
                                                      controller:
                                                          AppCubit.get(context)
                                                              .teamChat[
                                                                  widget.index!]
                                                              .video);
                                                }));
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
                                                      "${AppCubit.get(context).teamChat[widget.index!].teamChatThumbnail}",
                                                  placeholder: (context, url) =>
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
                                                            .teamChat[
                                                                widget.index!]
                                                            .video);
                                                  }));
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white
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
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Text(
                                            DateFormat('kk:mm').format(DateTime.parse(AppCubit.get(context).teamChat[widget.index!].dateTime!).toLocal()),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Color(0xfffbf7c2),
                                                fontFamily: AppStrings.appFont),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  width:
                                      MediaQuery.of(context).size.width * .60,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffb1b2ff)
                                        .withOpacity(.16),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AppCubit.get(context).userModel!.username}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 9,
                                            color: AppColors.myWhite,
                                            fontFamily: AppStrings.appFont),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      VoiceMessage(
                                        contactBgColor: AppColors.primaryColor1,
                                        contactFgColor: Colors.white,
                                        contactPlayIconColor:
                                            AppColors.primaryColor1,
                                        audioSrc:
                                            '${AppCubit.get(context).teamChat[widget.index!].voice}',
                                        played: true, // To show played badge or not.
                                        me: false, // Set message side.
                                        onPlay:
                                            () {}, // Do something when voice played.
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Text(
                                            DateFormat('kk:mm').format(DateTime.parse(AppCubit.get(context).teamChat[widget.index!].dateTime!).toLocal()),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Color(0xfffbf7c2),
                                                fontFamily: AppStrings.appFont),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryColor1,
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage('${AppCubit.get(context).userModel!.image}'),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
