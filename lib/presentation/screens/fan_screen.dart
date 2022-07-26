import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/widgets/post_widget.dart';
import 'package:flutter/material.dart';

class FanScreen extends StatelessWidget {
  const FanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:ListView.separated(
          itemBuilder: (context, index) => Column(
            children: [
              const SizedBox(height:10,),
              buidPostItem(context),
            ],
          ),
          separatorBuilder: (context,index)=>const SizedBox(height: 0,),
          itemCount: 10),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){},
          label: const Text('add new post'),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.primaryColor,
      ),

    );
  }
}
