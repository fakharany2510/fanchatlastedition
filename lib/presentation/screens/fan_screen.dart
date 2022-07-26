import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FanScreen extends StatelessWidget {
  const FanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.myWhite,
      body:ListView.separated(
          itemBuilder: (context, index) => Column(
            children: [
              const SizedBox(height:10,),
              buidPostItem(context),
            ],
          ),
          separatorBuilder: (context,index)=>Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              color: Colors.grey.shade300,
              width: double.infinity,
              height: 1,
            ),
          ),
          itemCount: 10),
      floatingActionButton:  SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: IconButton(icon:Icon(Icons.photo),onPressed: (){},),
            label: 'add photo'
          ),
          SpeedDialChild(
              child: IconButton(icon:Icon(Icons.video_camera_back_outlined),onPressed: (){},),
              label: 'add video'
          ),
        ],
      ),

    );
  }
}
