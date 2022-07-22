import 'package:carousel_slider/carousel_slider.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: cubit.carouselImage.map((e) {
                    return Image(
                      image: AssetImage(e),
                      width: double.infinity,fit: BoxFit.cover,
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 250,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    viewportFraction: 1,
                    scrollDirection: Axis.horizontal,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn
                  ),
                ),
                const SizedBox(height: 15,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1
                      ),
                      color: AppColors.myWhite,
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child:Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                      child: Text('Public Chat',style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor
                      ),),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                Container(
                  height: 800,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context,index){
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                 CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage('${cubit.groupsImages[index]}'),
                                ),
                                const SizedBox(width: 10,),
                                Text('Goooooooooooooooal',style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700
                                ),),
                                Spacer(),
                                CircleAvatar(
                                  radius: 13,
                                  child: Text('13'),
                                ),
                                SizedBox(width: 20,)
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context,index){
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15
                          ),
                          height: 1,
                          color: AppColors.primaryColor,
                        );
                      },
                      itemCount: cubit.groupsImages.length
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
