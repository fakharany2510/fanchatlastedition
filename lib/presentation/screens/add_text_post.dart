import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTextPost extends StatefulWidget {
  @override
  State<AddTextPost> createState() => _AddTextPostState();
}

class _AddTextPostState extends State<AddTextPost> {
  @override
  TextEditingController postText=TextEditingController();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        if(state is BrowiseGetPostsSuccessState){
          Navigator.of(context).popAndPushNamed('home_layout');
          AppCubit.get(context).postImage=null;
        }

      },
      builder: (context,state){
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar:AppBar(
            backgroundColor: AppColors.myWhite,
            title: Text('Add new post',style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor1
            )),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,color: Colors.black),
              onPressed: (){
                setState((){
                  //AppCubit.get(context).postImage='';
                  AppCubit.get(context).postImage=null;
                  print('${AppCubit.get(context).postImage}');
                  Navigator.pop(context);

                });

              },
            ),
          ),
          body: Padding(
              padding:  EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children:  [
                      CircleAvatar(
                        backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                        radius: 30,
                      ),
                      const SizedBox(width: 10,),
                      Text('${AppCubit.get(context).userModel!.username}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: postText,
                    decoration: const InputDecoration(
                      hintMaxLines: 1,
                      hintText: 'what is on your mind.....',
                      border:InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                  const  SizedBox(height: 10,),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state is BrowiseUploadImagePostLoadingState || state is BrowiseGetPostsLoadingState?
                      Center(child:CircularProgressIndicator(),)
                          :defaultButton(
                          width: size.width*.8,
                          height: size.height*.06,
                          function: (){

                            if(AppCubit.get(context).postImage == null){
                              AppCubit.get(context).createImagePost(
                                dateTime: DateTime.now(),
                                text:postText.text,
                              );
                              AppCubit.get(context).uploadText(
                                dateTime: DateTime.now(),
                                text:postText.text,
                              );
                            }else{
                              print('from upload text post');
                            }

                          },

                          buttonText: 'Create Post',
                          buttonColor: AppColors.primaryColor1
                      ),
                    ],
                  )

                ],
              )
          ),
        );
      },
    );
  }
}