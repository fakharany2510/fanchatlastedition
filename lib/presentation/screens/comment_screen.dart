// ignore_for_file: must_be_immutable

import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/data/modles/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_strings.dart';

class CommentScreen extends StatefulWidget {
  String postId;
  CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  var commentController = TextEditingController();
  bool commentControllerChanges = false;
  var formKey = GlobalKey<FormState>();

  //  WillPopCallback()  {
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AppCubit.get(context).getComment(widget.postId);
      return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // if(state)
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/imageback.jpg'),
                  fit: BoxFit.cover,
                )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                AppCubit.get(context)
                                    .testComments(widget.postId);
                                AppCubit.get(context).getPosts();
                                AppCubit.get(context).returnIconColor();
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Comment Screen',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor1,
                                  fontFamily: AppStrings.appFont),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 20.0,
                                        backgroundImage: NetworkImage(
                                            '${AppCubit.get(context).comments[index].userImage}'),
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
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${AppCubit.get(context).comments[index].username}',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: AppColors.myWhite,
                                                    height: 1.3,
                                                    fontFamily:
                                                        AppStrings.appFont),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                '${AppCubit.get(context).comments[index].comment}',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: AppColors.myWhite,
                                                    fontFamily:
                                                        AppStrings.appFont),
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
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10.0,
                          ),
                          itemCount: AppCubit.get(context).comments.length,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 22.0,
                              backgroundImage: NetworkImage(
                                  '${AppCubit.get(context).userModel!.image}'),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .65,
                              // color: backgroundColor: Colors.grey.shade100,,
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.grey[200],
                              ),
                              child: Form(
                                key: formKey,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please write your comment';
                                    }
                                    return null;
                                  },
                                  onSaved: (v) {
                                    setState(() {
                                      commentControllerChanges = true;
                                    });
                                  },
                                  onChanged: (v) {
                                    commentControllerChanges = true;

                                    AppCubit.get(context).changeIconColor();
                                  },
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    hintText: 'Write a comment...',
                                    border: InputBorder.none,
                                  ),
                                  controller: commentController,
                                ),
                              ),
                            ),
                            (commentControllerChanges == true) &&
                                    (commentController.text != '')
                                ? IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).commentHomePost(
                                          widget.postId,
                                          commentController.text);
                                      AppCubit.get(context)
                                          .getComment(widget.postId);
                                      AppCubit.get(context)
                                          .testComments(widget.postId);
                                      AppCubit.get(context).getPosts();
                                      commentController.text = '';
                                    },
                                    icon: commentController.text == ''
                                        ? Icon(
                                            Icons.send_rounded,
                                            color:
                                                AppCubit.get(context).iconColor,
                                            size: 34.0,
                                          )
                                        : Icon(
                                            Icons.send_rounded,
                                            color:
                                                AppCubit.get(context).iconColor,
                                            size: 34.0,
                                          ))
                                : IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.send_rounded,
                                      color: AppColors.myGrey,
                                      size: 34.0,
                                    ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget commentItem(CommentModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage('${model.userImage}'),
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
                    children: [
                      Text(
                        '${model.username}',
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w900,
                            height: 1.3,
                            fontFamily: AppStrings.appFont),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${model.comment}',
                        style: const TextStyle(
                            fontSize: 16.0, fontFamily: AppStrings.appFont),
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
