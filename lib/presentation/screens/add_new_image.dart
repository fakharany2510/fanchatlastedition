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
      listener: (context,state){
        if(state is BrowiseGetPostsSuccessState){
          Navigator.pop(context);
        }

      },
      builder: (context,state){
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar:AppBar(
            backgroundColor: AppColors.myWhite,
            title: Text('Add New Image',style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor1
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
              padding:  EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children:  [
                      CircleAvatar(
                        backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                        radius: 30,
                      ),
                      const SizedBox(width: 15,),
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
                  (AppCubit.get(context).postImage!= null )
                      ?Expanded(
                        child: Container(
                          height: size.height*.7,
                          width: size.width*.7,
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: Image(
                              image: FileImage(AppCubit.get(context).postImage!),
                            ),
                          ),
                        ),
                      )
                     :Expanded(child: Container(
                    child: Center(child: Text('No Photo Selected Yet',
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor1
                        )
                    )),
                  )),
SizedBox(height: size.height*.03,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(
                       width: size.width/2.5,
                       height: size.height*.06,
                       decoration: BoxDecoration(
                           border: Border.all(color: AppColors.primaryColor1),
                           borderRadius: BorderRadius.circular(25)
                       ),
                       child: TextButton(onPressed: (){
                         AppCubit.get(context).pickPostImage();
                       },
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Icon(Icons.camera_alt,color: AppColors.primaryColor1,size: 26),
                               const SizedBox(width:7),
                               Expanded(
                                 child: Text('Choose photo',style: TextStyle(
                                     color: AppColors.primaryColor1,
                                     fontSize: 15
                                 ),),
                               )
                             ],

                           )),
                     ),
                     const SizedBox(width: 10,),
                     state is BrowiseUploadImagePostLoadingState || state is BrowiseGetPostsLoadingState?
                     Center(child:CircularProgressIndicator(),)
                         :defaultButton(
                         width: size.width/2.5,
                         height: size.height*.06,
                         function: (){
                           var now=DateTime.now();
                           if(AppCubit.get(context).postImage == null){
                             AppCubit.get(context).createImagePost(
                                 dateTime: now.toString(),
                                 text:postText.text );

                           }else{
                             AppCubit.get(context).uploadPostImage(
                               dateTime: now.toString(),
                               text:postText.text,
                             );

                           }

                         },

                         buttonText: 'Upload Post',
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