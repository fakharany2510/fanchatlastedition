
import 'package:cloud_firestore/cloud_firestore.dart';
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
class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  String name = "";
  UserModel? model;
  @override
  void initState(){
    AppCubit.get(context).getAllUsers();
    super.initState();
  }
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppState>(
      listener: (context , state){},
      builder: (context , state){
        return Scaffold(
            backgroundColor: AppColors.myWhite,
            appBar: AppBar(
                elevation: 0,
                backgroundColor: AppColors.primaryColor1,
                title: Card(
                  elevation: 0,

                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search), hintText: 'Search Your Friend...'),
                    onChanged: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                  ),
                )),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshots) {
                return (snapshots.connectionState == ConnectionState.waiting)
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.separated(
                  separatorBuilder: (context,index)=>Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    child: Container(
                      width: double.infinity,
                      height: 0,
                      color: AppColors.myGrey,
                    ),
                  ),
                    itemCount: AppCubit.get(context).users.length,

                    itemBuilder: (context, index) {

                   //  as Map<String, dynamic>;

                      if (name.isEmpty) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatDetails(userModel:AppCubit.get(context).users[index])));
                            print('users length 1111111111111111 ${AppCubit.get(context).users.length}');
                          },
                          child: ListTile(
                            title: Text(
                              AppCubit.get(context).users[index].username!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: AppColors.primaryColor1,
                                  fontFamily: AppStrings.appFont,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(AppCubit.get(context).users[index].image!),
                            ),
                          ),
                        );
                      }
                      if (AppCubit.get(context).users[index].username!
                          .toString()
                          .toLowerCase()
                          .startsWith(name.toLowerCase())) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatDetails(userModel: AppCubit.get(context).users[index],)));
                          },
                          child: ListTile(
                            title: Text(
                              AppCubit.get(context).users[index].username!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: AppColors.primaryColor1,
                                  fontSize: 16,
                                  fontFamily: AppStrings.appFont,
                                  fontWeight: FontWeight.bold),
                            ),

                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(AppCubit.get(context).users[index].image!),
                            ),
                          ),
                        );
                      }
                      return Container();
                    });
              },
            ));

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
