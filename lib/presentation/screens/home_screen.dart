// ignore_for_file: prefer_final_fields

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/post_widget.dart';

bool isPostPlaying = true;

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.pageHeight, required this.pageWidth});
  final double? pageHeight;
  final double? pageWidth;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _childScrollController = ScrollController();

  ScrollController _parentScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is PickPostImageSuccessState) {
          Navigator.pushNamed(context, 'add_image');
        }
        if (state is PickPostVideoSuccessState) {
          Navigator.pushNamed(context, 'add_video');
        }
        if (state is BrowiseGetPostsSuccessState) {
          // controller!.pause();
        }
        if (state is NavigateScreenState) {
          // controller!.pause();

        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.primaryColor1,
          body: AppCubit.get(context).userModel != null
              ? RefreshIndicator(
                  onRefresh: () async {
                    await AppCubit.get(context).getPosts();
                  },
                  child: SingleChildScrollView(
                    controller: _parentScrollController,
                    child: Container(
                      decoration: const BoxDecoration(
                          // image: DecorationImage(
                          //   image: AssetImage('assets/images/public_chat_image.jpeg')
                          // )
                          ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                              height: 2,
                              color: Colors.blue,
                              width: double.infinity,
                            ),
                          ),
                          CarouselSlider(
                            items: cubit.carouselImage.map((e) {
                              return Image(
                                image: NetworkImage(e),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            }).toList(),
                            options: CarouselOptions(
                                height: 150,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                viewportFraction: 1,
                                scrollDirection: Axis.horizontal,
                                autoPlayAnimationDuration:
                                    const Duration(seconds: 1),
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          // Container(height: MediaQuery.of(context).size.height*.002,width: MediaQuery.of(context).size.width,color: AppColors.myGrey),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        // print('State ////////////////////////');

                                        state is NavigateScreenState;
                                        // print(state);
                                        isPostPlaying = false;
                                        AppCubit.get(context).throwState();
                                      });
                                      // print('I am here');
                                      Navigator.pushNamed(context, 'add_text');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .06,
                                      color: AppColors.myWhite,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${AppCubit.get(context).userModel!.image}'),
                                            radius: 18,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .01,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .01,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .01,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .16),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .04),
                                                border: Border.all(
                                                    color: AppColors
                                                        .primaryColor1)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 0),
                                              child: Text(
                                                'What\'s on your mind....?',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor1,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                    fontFamily:
                                                        AppStrings.appFont),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 0,
                                  ),
                                ],
                              )),
                          Container(
                              height: MediaQuery.of(context).size.height * .002,
                              width: MediaQuery.of(context).size.width,
                              color: AppColors.myGrey),
                          const SizedBox(
                            height: 5,
                          ),

                          const SizedBox(
                            height: 5,
                          ),
                          NotificationListener(
                            onNotification: (ScrollNotification notification) {
                              if (notification is ScrollUpdateNotification) {
                                if (notification.metrics.pixels ==
                                    notification.metrics.maxScrollExtent) {
                                  debugPrint('Reached the bottom');
                                  _parentScrollController.animateTo(
                                      _parentScrollController
                                          .position.maxScrollExtent,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeIn);
                                } else if (notification.metrics.pixels ==
                                    notification.metrics.minScrollExtent) {
                                  debugPrint('Reached the top');
                                  _parentScrollController.animateTo(
                                      _parentScrollController
                                          .position.minScrollExtent,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeIn);
                                }
                              }
                              return true;
                            },
                            child: cubit.posts.isNotEmpty
                                ? ListView.separated(
                                    controller: _childScrollController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => Column(
                                          children: [
                                            const SizedBox(
                                              height: 0,
                                            ),
                                            PostWidget(index: index),
                                          ],
                                        ),
                                    separatorBuilder: (context, index) =>
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .01,
                                          width: double.infinity,
                                          color:
                                              AppColors.myGrey.withOpacity(.1),
                                        ),
                                    itemCount:
                                        AppCubit.get(context).posts.length)
                                : const Padding(
                                    padding: EdgeInsets.only(top: 170),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: AppColors.myGrey,
                  ),
                ),
        );
      },
    );
  }
}

// floatingActionButton:SpeedDial(
//   backgroundColor: AppColors.primaryColor1,
//   animatedIcon: AnimatedIcons.menu_close,
//   elevation: 1,
//   overlayColor: AppColors.myWhite,
//   overlayOpacity: 0.0001,
//
//   children: [
//     SpeedDialChild(
//       onTap: (){
//         Navigator.pushNamed(context, 'add_video');
//       },
//       child: Icon(Icons.video_camera_back,color: AppColors.myWhite,),
//       label: 'add video',
//       backgroundColor: AppColors.primaryColor2
//     ),
//     SpeedDialChild(
//       onTap: (){
//         Navigator.pushNamed(context, 'add_image');
//       },
//       child: Icon(Icons.image,color: AppColors.myWhite,),
//       label: 'add image',
//         backgroundColor: AppColors.primaryColor2
//
//     ),
//   ],
// )
