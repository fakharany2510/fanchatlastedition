import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SendImageTeamChat extends StatefulWidget {
  @override
  State<SendImageTeamChat> createState() => _SendImageTeamChatState();
}

class _SendImageTeamChatState extends State<SendImageTeamChat> {
  @override
  TextEditingController postText=TextEditingController();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        //  if(state is GetMessageSuccessState){
        // //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatDetails(userModel:widget.userModel,)),);
        //    Navigator.pop(context);
        //  }
        if(state is BrowiseUploadImagePostSuccessState){
          Navigator.pop(context);
        }
      },
      builder: (context,state){
        return Scaffold(
            backgroundColor: AppColors.myWhite,
            body: Padding(
                padding:  EdgeInsets.all(20.0),
                child: Column(
                  children: [
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
                            fit: BoxFit.contain,
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
            floatingActionButton: state is BrowiseUploadImagePostLoadingState || state is BrowiseCreatePostLoadingState
                ?CircularProgressIndicator(color: AppColors.navBarActiveIcon,)
                :FloatingActionButton(
              onPressed: (){

                AppCubit.get(context).uploadTeamChatImage(dateTime:  DateTime.now().toString(), text: "", senderId:  AppStrings.uId!, senderName: '${AppCubit.get(context).userModel!.username}', senderImage: '${AppCubit.get(context).userModel!.image}');


              },
              backgroundColor: AppColors.primaryColor1,
              child: const Icon(
                Icons.send,
                color: Colors.white
                ,
              )
              ,
            )

        );
      },
    );
  }
}
