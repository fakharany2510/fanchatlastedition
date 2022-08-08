import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/data/modles/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_strings.dart';


class CommentScreen extends StatefulWidget {
  String postId;
  CommentScreen({Key? key , required this.postId }) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  var commentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          AppCubit.get(context).getComment(widget.postId);
          return BlocConsumer <AppCubit , AppState> (
            listener: (context , state) {
              // if(state)
            },
            builder: (context , state) {
              return Scaffold(
                backgroundColor: AppColors.myWhite,
                appBar: AppBar(
                  systemOverlayStyle:  SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light,
                    statusBarColor: AppColors.primaryColor1,
                  ),
                  iconTheme: IconThemeData(
                      color: AppColors.primaryColor1
                  ),
                  backgroundColor: AppColors.myWhite,
                  title: Text('Comment Screen',style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor1,
                      fontFamily: AppStrings.appFont
                  ),),
                  titleSpacing: 0.0,
                  // centerTitle: true,
                  elevation: 0.0,
                  leading: IconButton(
                    onPressed: (){
                      // AppCubit.get(context).homeComments = [];
                      // AppCubit.get(context).groupComments = [];
                      AppCubit.get(context).testComments(widget.postId);
                      AppCubit.get(context).getPosts();
                      AppCubit.get(context).returnIconColor();

                      Navigator.pop(context);

                    },
                    icon:  Icon(
                      Icons.arrow_back,
                      color: AppColors.primaryColor1,
                    ),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context , index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 20.0,
                                        backgroundImage: NetworkImage(
                                            '${AppCubit.get(context).comments[index].userImage}'
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          padding: const EdgeInsets.only(
                                            top: 5.0,
                                            bottom: 10.0,
                                            left: 15.0,
                                            right: 15.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor1,
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:  [
                                              Text(
                                                '${AppCubit.get(context).comments[index].username}',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: AppColors.myWhite,
                                                    height: 1.3,
                                                    fontFamily: AppStrings.appFont
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                '${AppCubit.get(context).comments[index].comment}' ,
                                                style:  TextStyle(
                                                    fontSize: 16.0,
                                                    color: AppColors.myWhite,
                                                    fontFamily: AppStrings.appFont
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } ,
                          separatorBuilder: (context , index) => const SizedBox(
                            height: 10.0,
                          ),
                          itemCount: AppCubit.get(context).comments.length,
                        ),
                        //   fallback: (context ) =>
                        //    child :Center(
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Icon(
                        //           Icons.comment,
                        //           size: 100.0,
                        //           color: Colors.grey[300],
                        //         ),
                        //         const SizedBox(
                        //           height: 10,
                        //         ),
                        //         Text(
                        //           'Add Comment',
                        //           style: TextStyle(
                        //             fontSize: 26.0,
                        //             fontWeight: FontWeight.bold,
                        //             color: Colors.grey[300],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 22.0,
                              backgroundImage: NetworkImage(
                                  '${AppCubit.get(context).userModel!.image}'
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Container(
                                height: 42.0,
                                // color: backgroundColor: Colors.grey.shade100,,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.grey[200],
                                ),
                                child: TextField(

                                   onChanged: (v){

                                     AppCubit.get(context).changeIconColor();


                                   },
                                  decoration: const InputDecoration(
                                    hintText: 'Write a comment...',
                                    border: InputBorder.none,
                                  ),
                                  controller: commentController,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                // if(route == 'home')
                                // {
                                // //   DioHelper.postDate( data: {
                                // //     "data" : commentController.text,
                                // //   }).then((value) {
                                // //     if(value.data['response'] == "comment is normal"){
                                // //       print(value.data['response']);
                                // //       AppCubit.get(context).commentHomePost(postId!, commentController.text);
                                // //     }else{
                                // //       customToast("Comment not Allow", Colors.red);
                                // //     }
                                // //   });
                                // // }
                                // // else if (route == 'group')
                                // // {
                                // //   DioHelper.postDate( data: {
                                // //     "data" : commentController.text,
                                // //   }).then((value) {
                                // //     if(value.data['response'] == "comment is normal"){
                                // //       print(value.data['response']);
                                // //       AppCubit.get(context).commentGroupPost(postId!, commentController.text);
                                // //     }else{
                                // //       customToast("Comment not Allow", Colors.red);
                                // //     }
                                // //   });
                                // }
                                AppCubit.get(context).commentHomePost(widget.postId, commentController.text);
                                AppCubit.get(context).testComments(widget.postId);
                                commentController.text='';
                              },
                              icon:  commentController.text=='' ?  Icon(
                                Icons.send_rounded,
                                color: AppCubit.get(context).iconColor,
                                size: 34.0,
                              ) :  Icon(
                                Icons.send_rounded,
                                color: AppCubit.get(context).iconColor,
                                size: 34.0,
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }

  Widget commentItem (CommentModel model)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                    '${model.userImage}'
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    bottom: 10.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        '${model.username}',
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w900,
                            height: 1.3,
                            fontFamily: AppStrings.appFont
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${model.comment}',
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: AppStrings.appFont
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}