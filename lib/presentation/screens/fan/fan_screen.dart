import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/screens/fan/add_fan_image.dart';
import 'package:fanchat/presentation/screens/fan/add_fan_video.dart';
import 'package:fanchat/presentation/widgets/fan_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/state_manager.dart';

class FanScreen extends StatefulWidget {
  const FanScreen({super.key});

  @override
  State<FanScreen> createState() => _FanScreenState();
}

class _FanScreenState extends State<FanScreen> {
  var isLoading = true.obs;
  var isAdding = true.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCubit.get(context).getFanPosts();
    AppCubit.get(context).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is PickFanPostImageSuccessState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFanImage()));
        }
        if (state is PickFanPostVideoSuccessState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFanVideo()));
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/public_chat_image.jpeg'))),
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Stack(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: const Opacity(
                          opacity: 1,
                          child: Image(
                            image: AssetImage(
                                'assets/images/public_chat_image.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        )),
                    // Container(
                    //   height: MediaQuery.of(context).size.height,
                    //   width: MediaQuery.of(context).size.width,
                    //   child:Opacity(
                    //     child:  Image(
                    //       image: AssetImage('assets/images/fanback.jpeg'),
                    //       fit: BoxFit.cover,
                    //
                    //     ),
                    //     opacity: .09,
                    //   )
                    // ),
                    GridView.count(
                      addAutomaticKeepAlives: true,
                      childAspectRatio:
                          MediaQuery.of(context).size.height * .0012 / 1.24,
                      crossAxisSpacing:
                          MediaQuery.of(context).size.height * .008,
                      mainAxisSpacing: MediaQuery.of(context).size.height * .00,
                      crossAxisCount: 3,
                      children: List.generate(
                          AppCubit.get(context).fans.length,
                          (index) => FanAreaWidget(
                                index: index,
                              )),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: SpeedDial(
              backgroundColor: AppColors.navBarActiveIcon,
              animatedIcon: AnimatedIcons.menu_close,
              elevation: 1,
              overlayColor: AppColors.myWhite,
              overlayOpacity: 0.0001,
              children: [
                SpeedDialChild(
                    onTap: () {
                      AppCubit.get(context).pickFanPostVideo();
                    },
                    child:
                        const Icon(Icons.video_camera_back, color: Colors.red),
                    backgroundColor: AppColors.myWhite),
                SpeedDialChild(
                  onTap: () {
                    AppCubit.get(context).pickFanPostImage();
                  },
                  child: const Icon(
                    Icons.image,
                    color: Colors.green,
                  ),
                  backgroundColor: AppColors.myWhite,
                ),
              ],
            ));
      },
    );
  }
}
