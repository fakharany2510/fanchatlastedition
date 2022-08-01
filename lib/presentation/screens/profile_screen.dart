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
            body: cubit.userModel !=null?SingleChildScrollView(
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
                  const SizedBox(height:7,),
                  Text('${cubit.userModel!.bio}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height:10,),
                  defaultButton(
                      buttonText: 'Edit Profile',
                      buttonColor: AppColors.primaryColor1,
                      height: size.height*.06,
                      width: size.width*.9,
                      function: (){
                        cubit.getUser();
                        Navigator.pushNamed(context, 'edit_profile');
                      }
                  ),
                  const SizedBox(height: 15,),
                  GridView.count(
                    shrinkWrap: true,
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
                ],
              ),
            ):Center(
              child: CircularProgressIndicator(),
            ),
          );
      },
    );
  }
}
