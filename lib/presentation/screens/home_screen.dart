import 'package:carousel_slider/carousel_slider.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../data/modles/create_post_model.dart';
import '../widgets/post_widget.dart';

class HomeScreen extends StatelessWidget {
    HomeScreen(
      {Key? key, required this.pageHeight, required this.pageWidth})
      : super(key: key);
  final double? pageHeight;
  final double? pageWidth;
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
          backgroundColor:AppColors.myWhite,
          body:cubit.posts.length !=0 && AppCubit.get(context).userModel !=null
              ? SingleChildScrollView(
            controller:_parentScrollController ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: cubit.carouselImage.map((e) {
                    return Image(
                      image: NetworkImage(e),
                      width: double.infinity,fit: BoxFit.cover,
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 180,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    viewportFraction: 1,
                    scrollDirection: Axis.horizontal,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn
                  ),
                ),
                SizedBox(height: 3,),
                Container(height: MediaQuery.of(context).size.height*.01,width: MediaQuery.of(context).size.width,color: Colors.grey[300],),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, 'add_text');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*.06,
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                                  radius: 20,
                                ),
                              ),
                              const Padding(
                                padding:  EdgeInsets.only(left: 10,top: 0),
                                child: Text('What\'s on your mind?',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ),
                      ),
                      SizedBox(height: 3,),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                AppCubit.get(context).pickPostImage();
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height*.03,
                                width: MediaQuery.of(context).size.width*.2,
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.camera_alt,color:Colors.green,size: 17),
                                     SizedBox(width:4),
                                    Expanded(
                                      child: Text('Photo',style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15
                                      ),),
                                    )
                                  ],

                                )
                              ),
                            ),
                            SizedBox(width:MediaQuery.of(context).size.width*.15,),
                            Container(
                              color: Colors.grey,
                              height: 25,
                              width: 1,
                            ),
                            SizedBox(width:MediaQuery.of(context).size.width*.15,),
                            InkWell(
                              onTap: (){
                                AppCubit.get(context).pickPostVideo();
                                AppCubit.get(context).isVideoButtonTapped==true;
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height*.03,
                                width: MediaQuery.of(context).size.width*.2,
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.video_camera_back,color:Colors.red,size: 17),
                                    const SizedBox(width:4),
                                    Expanded(
                                      child: Text('Video',style: TextStyle(
                                          color:Colors.black,
                                          fontSize: 15
                                      ),),
                                    )
                                  ],

                                )
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  )
                ),
                Container(height: MediaQuery.of(context).size.height*.01,width: MediaQuery.of(context).size.width,color: Colors.grey[300],),
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
                            duration: Duration(seconds: 1),
                            curve: Curves.easeIn);
                      } else if (notification.metrics.pixels ==
                          notification.metrics.minScrollExtent) {
                        debugPrint('Reached the top');
                        _parentScrollController.animateTo(
                            _parentScrollController.position.minScrollExtent,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeIn);
                      }
                    }
                    return true;
                  },
                    child: ListView.separated(
                        controller: _childScrollController,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Column(
                          children: [
                            const SizedBox(height:10,),
                            PostWidget(index: index,),
                          ],
                        ),
                        separatorBuilder: (context,index)=>Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 1,
                          ),
                        ),
                        itemCount: AppCubit.get(context).posts.length),
                ),

              ],
            ),
          )
          :Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor1,
            ),
          ),
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
        );
      },
    );
  }
}

