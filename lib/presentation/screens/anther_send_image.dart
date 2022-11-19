// ignore_for_file: must_be_immutable

import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/screens/another_chat_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_strings.dart';

class AntherSendImage extends StatefulWidget {
  String? userId;
  String? userImage;
  String? userName;
  AntherSendImage(this.userId, this.userImage, this.userName, {super.key});
  @override
  State<AntherSendImage> createState() => _AntherSendImageState();
}

class _AntherSendImageState extends State<AntherSendImage> {
  TextEditingController postText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        //  if(state is GetMessageSuccessState){
        // //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatDetails(userModel:widget.userModel,)),);
        //    Navigator.pop(context);
        //  }
        if (state is BrowiseUploadImagePostSuccessState) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return AntherChatDetails(
                userName: widget.userName,
                userId: widget.userId,
                userImage: widget.userImage);
          }));
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.myWhite,
            body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    (AppCubit.get(context).postImage != null)
                        ? Expanded(
                            child: SizedBox(
                              height: size.height,
                              width: size.width,
                              child: Align(
                                alignment: AlignmentDirectional.bottomCenter,
                                child: Image(
                                  image: FileImage(
                                      AppCubit.get(context).postImage!),
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Center(
                                child: Text('No Photo Selected Yet',
                                    style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor1,
                                        fontFamily: AppStrings.appFont,),),),),
                  ],
                )),
            floatingActionButton: state is BrowiseUploadImagePostLoadingState ||
                    state is BrowiseCreatePostLoadingState
                ? CircularProgressIndicator(
                    color: AppColors.navBarActiveIcon,
                  )
                : FloatingActionButton(
                    onPressed: () {
                      AppCubit.get(context).uploadMessageImage(
                          senderId: AppStrings.uId!,
                          dateTime: DateTime.now().toString(),
                          recevierId: widget.userId!,
                          recevierImage: widget.userImage!,
                          recevierName: widget.userName!,
                          text: "");
                    },
                    backgroundColor: AppColors.primaryColor1,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ));
      },
    );
  }
}
