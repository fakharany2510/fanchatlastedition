import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../data/modles/create_post_model.dart';
import '../widgets/post_widget.dart';

class HomeScreen extends StatefulWidget {
    HomeScreen(
      {Key? key, required this.pageHeight, required this.pageWidth})
      : super(key: key);
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
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        if(state is PickPostImageSuccessState){
          Navigator.pushNamed(context, 'add_image');
        }
        if(state is PickPostVideoSuccessState){
          Navigator.pushNamed(context, 'add_video');
        }
      },
      builder: (context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(
          backgroundColor:AppColors.primaryColor1,
          body:  AppCubit.get(context).userModel !=null
        ?SingleChildScrollView(
            controller:_parentScrollController ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 2,
                  color: Colors.blue,
                  width: double.infinity,
                ),
                const SizedBox(height: 5,),
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
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true

                  ),
                ),
                const SizedBox(height: 3,),
                  // Container(height: MediaQuery.of(context).size.height*.002,width: MediaQuery.of(context).size.width,color: AppColors.myGrey),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                  child: Column(
                    children: [
                      const SizedBox(height: 3,),
                      InkWell(
                        onTap: (){
                          setState((){
                            controller.pause();

                          });
                          Navigator.pushNamed(context, 'add_text');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*.06,
                          color: AppColors.myGrey,
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                                  radius: 20,
                                ),
                              ),
                               Padding(
                                padding:  const EdgeInsets.only(left: 10,top: 0),
                                child: Text('What\'s on your mind....?',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppColors.primaryColor1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17,
                                      fontFamily: AppStrings.appFont
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ),
                      ),
                      const SizedBox(height: 0,),
                    ],
                  )
                ),
                Container(height: MediaQuery.of(context).size.height*.002,width: MediaQuery.of(context).size.width,color:AppColors.myGrey),
                const SizedBox(height: 5,),

                const SizedBox(height: 5,),
                NotificationListener(
                  onNotification: (ScrollNotification notification) {
                    if (notification is ScrollUpdateNotification) {
                      if (notification.metrics.pixels ==
                          notification.metrics.maxScrollExtent) {
                        debugPrint('Reached the bottom');
                        _parentScrollController.animateTo(
                            _parentScrollController.position.maxScrollExtent,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeIn);
                      } else if (notification.metrics.pixels ==
                          notification.metrics.minScrollExtent) {
                        debugPrint('Reached the top');
                        _parentScrollController.animateTo(
                            _parentScrollController.position.minScrollExtent,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeIn);
                      }
                    }
                    return true;
                  },
                    child:cubit.posts.length !=0
                      ? ListView.separated(
                        controller: _childScrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Column(
                          children: [
                            const SizedBox(height:10,),
                            PostWidget(index: index),
                          ],
                        ),
                        separatorBuilder: (context,index)=>Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            height: MediaQuery.of(context).size.height*.00030,
                            width: double.infinity,
                            color: AppColors.myGrey,
                          ),
                        ),
                        itemCount: AppCubit.get(context).posts.length)
                        :Padding(
                          padding: const EdgeInsets.only(top:170),
                          child: Center(
                      child: Text('No Posts Added Yet',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.navBarActiveIcon,

                      ),
                      )
                    ),
                        ),
                ),

              ],
            ),
          ) :Center(
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