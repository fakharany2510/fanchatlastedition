import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FanScreen extends StatelessWidget {
  const FanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
      builder: (context,state){
          var cubit=AppCubit.get(context);
          return Scaffold(
            backgroundColor: AppColors.myWhite,
            body:GridView.count(
                childAspectRatio: 1/1.3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                crossAxisCount: 3,
                children: List.generate(
                    cubit.fanImages.length, (index) => Column(
                  children: [
                    Stack(
                      children: [
                        Image(
                          height: MediaQuery.of(context).size.height*.2,
                          fit: BoxFit.cover,
                          image: NetworkImage('${cubit.fanImages[index]}'),
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: (){
                            },
                            icon:Icon(Icons.image,color: AppColors.myWhite,)
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            )

          );
      },
    );
  }
}
