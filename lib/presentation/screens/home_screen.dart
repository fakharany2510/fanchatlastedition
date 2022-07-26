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
            physics: const BouncingScrollPhysics(),
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
                    autoPlayInterval: const Duration(seconds: 3),
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
                  child: GridView.count(
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1/1.02,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: List.generate(cubit.nationalTitles.length, (index) =>
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20)

                          ),
                          padding:const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 10,),
                              Align(
                                alignment: Alignment.topRight,
                                child:CircleAvatar(
                                    radius: 16,
                                    backgroundColor: AppColors.primaryColor,
                                    child: Text('8',style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.myWhite
                                    ),),
                              )),
                              const SizedBox(height: 10,),
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(cubit.groupsImages[index]),
                              ),
                              const SizedBox(height: 10,),
                              Text(cubit.nationalTitles[index],style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500
                              ),),
                            ],
                          ),
                        )
                    ),
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
