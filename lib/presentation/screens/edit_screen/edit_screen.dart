// ignore_for_file: must_be_immutable

import 'package:fanchat/business_logic/cubit/app_cubit.dart';
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

  EditPostImageScreen(
      {super.key,
      required this.userImage,
      required this.userName,
      required this.postImage,
      required this.time,
      required this.date,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: customAppbar('', context),
        );
      },
    );
  }
}
