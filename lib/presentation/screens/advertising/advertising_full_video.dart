// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, must_be_immutable

import 'dart:developer';

import 'package:fanchat/business_logic/advertising_cubit/advertising_cubit.dart';
import 'package:fanchat/business_logic/advertising_cubit/advertising_state.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvertisingFullVideo extends StatefulWidget {
  AdvertisingFullVideo({super.key, this.video, this.videoLink});

  String? video;
  String? videoLink;
  @override
  State<AdvertisingFullVideo> createState() => _AdvertisingFullVideoState();
}

class _AdvertisingFullVideoState extends State<AdvertisingFullVideo> {
  final FijkPlayer player = FijkPlayer();
  Object? error;

  //bool isLoading = true;

  Future<void> init() async {
    try {} catch (e, st) {
      error = e;
      log('max $e \n $st');
    } finally {
      setState(() {});
    }
  }

  @override
  void initState() {
    init();
    super.initState();
    player.setDataSource(widget.video!, autoPlay: true, showCover: true);
  }

  @override
  void dispose() {
    player.pause();
    player.release();
    // player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdvertisingCubit, AdvertisingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarColor: AppColors.primaryColor1,
            ),
            iconTheme: IconThemeData(color: AppColors.myWhite),
            backgroundColor: AppColors.primaryColor1,
            title: SizedBox(
              height: MediaQuery.of(context).size.height * 02,
              width: MediaQuery.of(context).size.width * .4,
              child: const Image(
                image: AssetImage('assets/images/ncolors.png'),
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            actions: [
              IconButton(
                onPressed: () {},
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(right: 20),
                icon: ImageIcon(
                  const AssetImage("assets/images/notification.png"),
                  color: AppColors.navBarActiveIcon,
                ),
              ),
            ],
            leading: IconButton(
              onPressed: () {
                setState(() {
                  player.pause();
                  player.release();
                });
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Opacity(
                    opacity: 1,
                    child: Image(
                      image: AssetImage('assets/images/imageback.jpg'),
                      fit: BoxFit.cover,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .6,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          if (error != null)
                            Center(child: Text(error.toString()))
                          else if (player == null)
                            const Center(child: CupertinoActivityIndicator())
                          else
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: FijkView(
                                player: player,
                                fit: FijkFit.contain,
                                color: Colors.transparent,
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    ),
                    defaultButton(
                        textColor: AppColors.myWhite,
                        buttonText: 'Show this advertisement',
                        buttonColor: const Color(0Xffd32330),
                        width: MediaQuery.of(context).size.width * .6,
                        height: MediaQuery.of(context).size.height * .06,
                        function: () async {
                          //await widget.video==null;
                          await player.pause();
                          AdvertisingCubit.get(context).toAdvertisingLink(
                              advertisingLink: widget.videoLink!);
                        })
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
