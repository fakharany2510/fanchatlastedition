import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewImage extends StatelessWidget {
  @override
  TextEditingController postText=TextEditingController();
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar:AppBar(
            backgroundColor: AppColors.myWhite,
            title: Text('Add New Image',style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor
            )),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,color: Colors.black),
              onPressed: ()async{
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is CreatePostLoadingState)
                   const  LinearProgressIndicator(),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children:  [
                      CircleAvatar(
                        backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                        radius: 30,
                      ),
                      const SizedBox(width: 15,),
                      Expanded(
                        child:  Text('${AppCubit.get(context).userModel!.username}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: TextFormField(
                      controller: postText,
                      decoration: const InputDecoration(
                        hintText: 'what is on your mind.....',
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                 const  SizedBox(height: 10,),
                  (AppCubit.get(context).postImage!= null )
                      ?Stack(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: size.height*.4,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  image: DecorationImage(
                                      image: FileImage( AppCubit.get(context).postImage!),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                     :Container(),
                  const Spacer(),
                  Container(
                    width: size.width*.8,
                    height: size.height*.06,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: TextButton(onPressed: (){
                      AppCubit.get(context).pickPostImage();
                    }, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt,color: AppColors.primaryColor,size: 26),
                        const SizedBox(width:7),
                        Text('Choose photo',style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 15
                        ),)
                      ],

                    )),
                  ),
                  const SizedBox(height: 10,),
                  defaultButton(
                      width: size.width*.8,
                      height: size.height*.06,
                      function: (){
                        var now=DateTime.now();
                       // AppCubit.get(context).uploadPostImage(
                       //    dateTime:now.microsecondsSinceEpoch.toString(),
                       //  );
                        if(AppCubit.get(context).postImage == null){
                          AppCubit.get(context).createImagePost(
                              dateTime: now.toString(),
                              text:postText.text );
                        }else{
                          AppCubit.get(context).uploadPostImage(
                              dateTime: now.toString(),
                              text:postText.text
                          );
                        }
                      },
                      buttonText: 'Upload Image',
                      buttonColor: AppColors.primaryColor
                  )
                ],
              )
          ),
        );
      },
    );
  }
}