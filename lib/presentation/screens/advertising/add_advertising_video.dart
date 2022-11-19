import 'package:fanchat/business_logic/advertising_cubit/advertising_cubit.dart';
import 'package:fanchat/business_logic/advertising_cubit/advertising_state.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../../layouts/home_layout.dart';

class AddAdvertisingVideo extends StatelessWidget {
  const AddAdvertisingVideo({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AdvertisingCubit, AdvertisingState>(
      listener: (context, state) {
        if (state is AdvertisingCreateVideoPostSuccessState) {
          // AppCubit.get(context).videoPlayerController!.dispose();
          AdvertisingCubit.get(context).videoPlayerController == null;
          AdvertisingCubit.get(context).postVideo = null;
          AppCubit.get(context).currentIndex = 5;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeLayout()),
              (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor1,
            title: Text('Add Video',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: AppColors.myWhite,
                    fontFamily: AppStrings.appFont)),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () async {
                AdvertisingCubit.get(context).postVideo = null;
                Navigator.pop(context);
                await AdvertisingCubit.get(context)
                    .videoPlayerController!
                    .pause();
              },
            ),
            actions: [
              state is AdvertisingUploadVideoPostLoadingState
                  ? Center(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.myWhite,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: defaultButton(
                          textColor: AppColors.primaryColor1,
                          width: size.width * .2,
                          height: size.height * .05,
                          raduis: 10,
                          function: () {
                            if (AdvertisingCubit.get(context)
                                    .AdvertisingPostVideo ==
                                null) {
                              // print('advertising video null');
                            } else {
                              AdvertisingCubit.get(context)
                                  .uploadAdvertisngPostVideo(
                                timeSpam: DateTime.now().toString(),
                                time: DateFormat.Hm().format(DateTime.now()),
                                dateTime:
                                    DateFormat.yMMMd().format(DateTime.now()),
                                text: "",
                                advertisngLink: AdvertisingCubit.get(context)
                                    .advertingVideoLink
                                    .text,
                              );
                            }
                          },
                          buttonText: 'add',
                          buttonColor: AppColors.myWhite)),
            ],
          ),
          body: Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Opacity(
                    opacity: 1,
                    child: Image(
                      image: AssetImage('assets/images/public_chat_image.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                          color: AppColors.myWhite,
                          fontFamily: AppStrings.appFont,
                        ),
                        keyboardType: TextInputType.text,
                        controller:
                            AdvertisingCubit.get(context).advertingVideoLink,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          focusColor: AppColors.myGrey,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.myGrey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.myGrey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'Enter Advertising Link',
                          hintStyle: TextStyle(
                            color: AppColors.myGrey,
                            fontFamily: AppStrings.appFont,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter advertising link';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      if (state is CreatePostLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      (AdvertisingCubit.get(context).AdvertisingPostVideo !=
                                  null &&
                              AdvertisingCubit.get(context)
                                  .videoPlayerController!
                                  .value
                                  .isInitialized)
                          ? Expanded(
                              child: SizedBox(
                                height: size.height,
                                width: size.width,
                                child: AspectRatio(
                                  aspectRatio: AdvertisingCubit.get(context)
                                      .videoPlayerController!
                                      .value
                                      .aspectRatio,
                                  child: AdvertisingCubit.get(context)
                                              .videoPlayerController ==
                                          null
                                      ? const SizedBox(
                                          height: 0,
                                        )
                                      : VideoPlayer(
                                          AdvertisingCubit.get(context)
                                              .videoPlayerController!),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: Text(
                                  'No Video Selected Yet',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor1,
                                    fontFamily: AppStrings.appFont,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }
}
