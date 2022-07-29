import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_colors.dart';
import '../widgets/shared_widgets.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
      builder: (context,state){
          var cubit=AppCubit.get(context);
          return Scaffold(
            appBar: customAppbar('Profile'),
            backgroundColor: AppColors.myWhite,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //profile
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      child: Stack(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  image: DecorationImage(
                                      image: NetworkImage('${cubit.userModel!.cover}'),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 57,
                            child: CircleAvatar(
                              backgroundImage:NetworkImage('${cubit.userModel!.image}'),
                              radius: 55,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),
                  const SizedBox(height:5,),
                  //name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text('${cubit.userModel!.username}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      const SizedBox(width: 5,),
                      const Icon(Icons.check_circle,color: Colors.blue,size:15,),
                    ],
                  ),
                  const SizedBox(height:15,),
                  defaultButton(
                      buttonText: 'Edit Profile',
                      buttonColor: AppColors.primaryColor,
                      height: size.height*.06,
                      width: size.width*.4,
                      function: (){
                        cubit.getUser();
                        Navigator.pushNamed(context, 'edit_profile');
                      }
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}
