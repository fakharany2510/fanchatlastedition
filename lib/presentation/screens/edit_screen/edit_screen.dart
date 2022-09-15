import 'package:cached_network_image/cached_network_image.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/show_home_image.dart';
import 'package:fanchat/presentation/screens/user_profile.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPostImageScreen extends StatelessWidget {
  String userImage;
  String userName;
  String date;
  String time;
  String postImage;
  int index;

  EditPostImageScreen({
    Key? key,
    required this.userImage,
    required this.userName,
    required this.postImage,
    required this.time,
    required this.date,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
      builder: (context,state){
          return Scaffold(
            appBar: customAppbar('', context),


          );
      },
    );
  }
}
