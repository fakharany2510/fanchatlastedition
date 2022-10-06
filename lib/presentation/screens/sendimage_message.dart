import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_strings.dart';
import '../../data/modles/user_model.dart';
import 'messages_details.dart';

class SendImage extends StatefulWidget {
  UserModel userModel;
  SendImage(this.userModel);
  @override
  State<SendImage> createState() => _SendImageState();
}

class _SendImageState extends State<SendImage> {
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
        if(state is CreateImagePrivateSuccessState){
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
          floatingActionButton: state is UploadImagePrivateLoadingState || state is CreateImagePrivateLoadingState
              ?CircularProgressIndicator(color: AppColors.navBarActiveIcon,)
                :FloatingActionButton(
            onPressed: (){
          AppCubit.get(context).uploadMessageImage(
              senderId: AppStrings.uId!,
              dateTime: DateTime.now().toString(),
              recevierId:widget.userModel.uId!,
              text: ""
          );
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
