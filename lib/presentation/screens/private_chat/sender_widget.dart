// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/private_chat/open_full_video_private_chat.dart';
import 'package:fanchat/presentation/screens/show_home_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_message_package/voice_message_package.dart';

class SenderMessageWidget extends StatefulWidget {
  int? index;

  SenderMessageWidget({super.key, this.index});

  @override
  State<SenderMessageWidget> createState() => _SenderMessageWidgetState();
}

class _SenderMessageWidgetState extends State<SenderMessageWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Align(
          alignment: AlignmentDirectional.centerStart,
          child: (AppCubit.get(context).messages[widget.index!].text != "")
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xffeef1ff).withOpacity(.9),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    '${AppCubit.get(context).messages[widget.index!].text}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Color(0xff7895b2),
                        fontFamily: AppStrings.appFont),
                  ),
                )
              : (AppCubit.get(context).messages[widget.index!].image != null)
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowHomeImage(
                                    image: AppCubit.get(context)
                                        .messages[widget.index!]
                                        .image)));
                      },
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        )),
                        height: MediaQuery.of(context).size.height * .28,
                        width: MediaQuery.of(context).size.width * .55,
                        child: CachedNetworkImage(
                          cacheManager: AppCubit.get(context).manager,
                          imageUrl:
                              "${AppCubit.get(context).messages[widget.index!].image}",
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : (AppCubit.get(context)
                              .messages[widget.index!]
                              .privateChatSumbnail !=
                          null)
                      ? Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return OpenFullVideoPrivateChat(
                                      controller: AppCubit.get(context)
                                          .messages[widget.index!]
                                          .video);
                                }));
                              },
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                )),
                                height:
                                    MediaQuery.of(context).size.height * .28,
                                width: MediaQuery.of(context).size.width * .55,
                                child: CachedNetworkImage(
                                  cacheManager: AppCubit.get(context).manager,
                                  imageUrl: AppCubit.get(context)
                                      .messages[widget.index!]
                                      .privateChatSumbnail!,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Positioned(
                                top: MediaQuery.of(context).size.height * .11,
                                left: MediaQuery.of(context).size.height * .1,
                                child: InkWell(
                                  onTap: () {
                                    // setState((){
                                    //   if(mymessageController.value.isPlaying){
                                    //     mymessageController.pause();
                                    //   }else{
                                    //     mymessageController.play();
                                    //   }
                                    // });
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return OpenFullVideoPrivateChat(
                                          controller: AppCubit.get(context)
                                              .messages[widget.index!]
                                              .video);
                                    }));
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Colors.white.withOpacity(.5),
                                    radius: 25,
                                    child: Icon(
                                      Icons.play_arrow,
                                      size: 40,
                                      color: AppColors.primaryColor1
                                          .withOpacity(.8),
                                    ),
                                  ),
                                )),
                          ],
                        )
                      : VoiceMessage(
                          audioSrc:
                              '${AppCubit.get(context).messages[widget.index!].voice}',
                          played: true, // To show played badge or not.
                          me: false, // Set message side.
                          meBgColor: AppColors.myGrey,
                          mePlayIconColor: AppColors.navBarActiveIcon,
                          onPlay: () {}, // Do something when voice played.
                        ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
