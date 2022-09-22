
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/user_model.dart';
import 'package:fanchat/presentation/screens/messages_details.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppState>(
      listener: (context , state){},
      builder: (context , state){
        return Scaffold(
          appBar:customAppbar('s', context) ,
          body: ConditionalBuilder(
            condition: AppCubit.get(context).users.length>0,
            fallback: (context)=>Center(child: CircularProgressIndicator(
              backgroundColor: AppColors.primaryColor1,
            )),
            builder: (context)=>ListView.separated
              (itemBuilder: (context , index)=> buildChatItem(AppCubit.get(context).users[index] , context),
                separatorBuilder: (context , index)=>Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
                itemCount: AppCubit.get(context).users.length),

          ),
        );

      },
    );
  }
  Widget buildChatItem(UserModel model , context)=>InkWell(
    splashColor: AppColors.primaryColor1,
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatDetails(userModel: model,)));
      print('kkkkkkkkkkkkkkkkkkkkkkkkkkk${model.uId}');
    },
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('${model.image}'),
            radius: 25,
          ),
          const SizedBox(width: 15,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('${model.username}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        fontFamily: AppStrings.appFont
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    ),
  );
}
