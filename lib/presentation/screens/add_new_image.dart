import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../constants/app_strings.dart';

class AddNewImage extends StatefulWidget {
  @override
  State<AddNewImage> createState() => _AddNewImageState();
}

class _AddNewImageState extends State<AddNewImage> {
  @override
  TextEditingController postText=TextEditingController();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        if(state is BrowiseGetPostsSuccessState){
         // Navigator.of(context).popAndPushNamed('home_layout');
         //  AppCubit.get(context).testLikes();
         //  AppCubit.get(context).testComments();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeLayout()), (route) => false);
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
                color: AppColors.primaryColor1,
                fontFamily: AppStrings.appFont
            )),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,color: Colors.black),
              onPressed: (){
              setState((){
                //AppCubit.get(context).postImage='';
                //AppCubit.get(context).postImage=null;
                print('${AppCubit.get(context).postImage}');
               Navigator.pop(context);

              });

              },
            ),
            actions: [
              state is BrowiseUploadImagePostLoadingState || state is BrowiseGetPostsLoadingState?
              Center(child:CircularProgressIndicator(),)
                  :Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultButton(
                    textColor: AppColors.myWhite,
                    width: size.width*.2,
                    height: size.height*.05,
                    raduis: 10,
                    function: (){


                      if(AppCubit.get(context).postImage == null){
                        AppCubit.get(context).createImagePost(
                          time: DateFormat.Hm().format(DateTime.now()),
                          timeSpam: DateTime.now().toString(),
                          dateTime: DateFormat.yMMMd().format(DateTime.now()),
                          text:postText.text,
                        );
                      }else{
                        AppCubit.get(context).uploadPostImage(
                          dateTime: DateFormat.yMMMd().format(DateTime.now()),
                          time: DateFormat.Hm().format(DateTime.now()),
                          timeSpam: DateTime.now().toString(),
                          text:postText.text,
                          image: AppCubit.get(context).userModel!.image,
                          name: AppCubit.get(context).userModel!.username,
                        );
                      }
                      print(DateFormat.Hms().format(DateTime.now()));

                    },

                    buttonText: 'post',
                    buttonColor: AppColors.primaryColor1
              ),
                  )
            ],
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
                            fontWeight: FontWeight.w500,
                            fontFamily: AppStrings.appFont
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: MediaQuery.of(context).size.height*.08,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      maxLines: 3,
                      controller: postText,
                      decoration: const InputDecoration(
                        hintMaxLines: 1,
                        hintText: 'Say someting about this photo.....',
                        border:InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                 const  SizedBox(height: 0,),
                  (AppCubit.get(context).postImage!= null )
                      ?Expanded(
                        child: Container(
                          height: size.height,
                          width: size.width,
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: Image(
                              image: FileImage(AppCubit.get(context).postImage!),
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                      )
                  :Expanded(child: Container(
                    child: Center(child: Text('No Photo Selected Yet',
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor1,
                            fontFamily: AppStrings.appFont
                        )
                    )),
                  )),


                ],
              )
          ),
        );
      },
    );
  }
}