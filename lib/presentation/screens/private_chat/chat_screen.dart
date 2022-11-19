// ignore_for_file: unused_field, prefer_final_fields

import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/user_model.dart';
import 'package:fanchat/presentation/screens/private_chat/messages_details.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  ScrollController _childScrollController = ScrollController();
  ScrollController _parentScrollController = ScrollController();
  String name = "";
  UserModel? model;

  @override
  void initState() {
    AppCubit.get(context).getAllUsers();
    AppCubit.get(context).getLastUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.primaryColor1,
            appBar: customAppbar('private chat', context),
            body: SingleChildScrollView(
              controller: _parentScrollController,
              child: Column(
                children: [
                  if (AppCubit.get(context).lastUsers.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SizedBox(
                        height: 45,
                        child: Card(
                          elevation: 0,
                          child: TextField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search Your Friend...'),
                            onChanged: (val) {
                              setState(() {
                                name = val;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  NotificationListener(
                      onNotification: (ScrollNotification notification) {
                        if (notification is ScrollUpdateNotification) {
                          if (notification.metrics.pixels ==
                              notification.metrics.maxScrollExtent) {
                            debugPrint('Reached the bottom');
                            _parentScrollController.animateTo(
                                _parentScrollController
                                    .position.maxScrollExtent,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeIn);
                          } else if (notification.metrics.pixels ==
                              notification.metrics.minScrollExtent) {
                            debugPrint('Reached the top');
                            _parentScrollController.animateTo(
                                _parentScrollController
                                    .position.minScrollExtent,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeIn);
                          }
                        }
                        return true;
                      },
                      child: AppCubit.get(context).lastUsers.isNotEmpty
                          ? ListView.separated(
                              addAutomaticKeepAlives: true,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 0,
                                      color: AppColors.myGrey,
                                    ),
                                  ),
                              itemCount: AppCubit.get(context).lastUsers.length,
                              itemBuilder: (context, index) {
                                //  as Map<String, dynamic>;

                                if (name.isEmpty) {
                                  return InkWell(
                                      onTap: () {
                                        AppCubit.get(context).messages = [];
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatDetails(
                                              userName: AppCubit.get(context)
                                                      .lastUsers[index]
                                                  ['recevierName'],
                                              userId: AppCubit.get(context)
                                                      .lastUsers[index]
                                                  ['recevierId'],
                                              userImage: AppCubit.get(context)
                                                      .lastUsers[index]
                                                  ['recevierImage'],
                                            ),
                                          ),
                                        );
                                        // print('users length 1111111111111111 ${AppCubit.get(context).lastUsers.length}');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 13, right: 13, bottom: 5),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .08,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .9,
                                          decoration: BoxDecoration(
                                              color: AppColors.myGrey
                                                  .withOpacity(.3)),
                                          child: Center(
                                            child: ListTile(
                                              title: Text(
                                                AppCubit.get(context)
                                                        .lastUsers[index]
                                                    ['recevierName']!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: AppColors.myWhite,
                                                    fontFamily:
                                                        AppStrings.appFont,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              leading: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    AppCubit.get(context)
                                                            .lastUsers[index]
                                                        ['recevierImage']!),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ));
                                }
                                if (AppCubit.get(context)
                                    .lastUsers[index]['recevierName']!
                                    .toString()
                                    .toLowerCase()
                                    .startsWith(name.toLowerCase())) {
                                  return InkWell(
                                      onTap: () {
                                        AppCubit.get(context).messages = [];

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatDetails(
                                                      userName: AppCubit.get(
                                                                  context)
                                                              .lastUsers[index]
                                                          ['recevierName'],
                                                      userId: AppCubit.get(
                                                                  context)
                                                              .lastUsers[index]
                                                          ['recevierId'],
                                                      userImage: AppCubit.get(
                                                                  context)
                                                              .lastUsers[index]
                                                          ['recevierImage'],
                                                    )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 13, right: 13, bottom: 5),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .9,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .08,
                                          decoration: BoxDecoration(
                                              color: AppColors.myGrey
                                                  .withOpacity(.3)),
                                          child: Center(
                                            child: ListTile(
                                              title: Text(
                                                AppCubit.get(context)
                                                        .lastUsers[index]
                                                    ['recevierName']!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: AppColors.myWhite,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        AppStrings.appFont,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              leading: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    AppCubit.get(context)
                                                            .lastUsers[index]
                                                        ['recevierImage']),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ));
                                }
                                return Container();
                              })
                          : Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                  ),
                                  Lottie.asset('assets/images/empty_chat.json',
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .4),
                                  const Text(
                                    'No Chats Yet',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            )
                      // StreamBuilder<QuerySnapshot>(
                      //   stream: FirebaseFirestore.instance.collection('users').snapshots(),
                      //   builder: (context, snapshots) {
                      //     return (snapshots.connectionState == ConnectionState.waiting)
                      //         ? Center(
                      //       child: CircularProgressIndicator(),
                      //     )
                      //         : ListView.separated(
                      //         addAutomaticKeepAlives: true,
                      //       shrinkWrap: true,
                      //         separatorBuilder: (context,index)=>Padding(
                      //           padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                      //           child: Container(
                      //             width: double.infinity,
                      //             height: 0,
                      //             color: AppColors.myGrey,
                      //           ),
                      //         ),
                      //         itemCount: AppCubit.get(context).lastUsers.length,
                      //
                      //         itemBuilder: (context, index) {
                      //
                      //           //  as Map<String, dynamic>;
                      //
                      //
                      //           if (name.isEmpty) {
                      //             return InkWell(
                      //               onTap: (){
                      //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      //                     ChatDetails(
                      //                       userName:AppCubit.get(context).lastUsers[index]['recevierName'],
                      //                       userId: AppCubit.get(context).lastUsers[index]['recevierId'],
                      //                       userImage: AppCubit.get(context).lastUsers[index]['recevierImage'],                                        )));
                      //                 print('users length 1111111111111111 ${AppCubit.get(context).lastUsers.length}');
                      //               },
                      //               child: Padding(
                      //                 padding: EdgeInsets.only(left: 13,right: 13,bottom: 5),
                      //                 child: Container(
                      //                   height: MediaQuery.of(context).size.height*.08,
                      //                   width: MediaQuery.of(context).size.width*.9,
                      //                   decoration: BoxDecoration(
                      //                     color: AppColors.myGrey.withOpacity(.3)
                      //                   ),
                      //                   child: Center(
                      //                     child: ListTile(
                      //                       title: Text(
                      //                         AppCubit.get(context).lastUsers[index]['recevierName']!,
                      //                         maxLines: 1,
                      //                         overflow: TextOverflow.ellipsis,
                      //                         style: TextStyle(
                      //                             color: AppColors.myWhite,
                      //                             fontFamily: AppStrings.appFont,
                      //                             fontSize: 16,
                      //                             fontWeight: FontWeight.bold),
                      //                       ),
                      //                       leading: CircleAvatar(
                      //                         backgroundImage: NetworkImage(AppCubit.get(context).lastUsers[index]['recevierImage']!),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               )
                      //             );
                      //           }
                      //           if (AppCubit.get(context).lastUsers[index]['recevierName']!
                      //               .toString()
                      //               .toLowerCase()
                      //               .startsWith(name.toLowerCase())) {
                      //             return InkWell(
                      //               onTap: (){
                      //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatDetails(
                      //                   userName:AppCubit.get(context).lastUsers[index]['recevierName'],
                      //                   userId: AppCubit.get(context).lastUsers[index]['recevierId'],
                      //                   userImage: AppCubit.get(context).lastUsers[index]['recevierImage'],
                      //                 )));
                      //               },
                      //               child: Padding(
                      //                 padding: EdgeInsets.only(left:13,right: 13,bottom: 5),
                      //                 child: Container(
                      //                   width: MediaQuery.of(context).size.width*.9,
                      //                   height: MediaQuery.of(context).size.height*.08,
                      //                   decoration: BoxDecoration(
                      //                     color: AppColors.myGrey.withOpacity(.3)
                      //                   ),
                      //                   child: Center(
                      //                     child: ListTile(
                      //                       title: Text(
                      //                         AppCubit.get(context).lastUsers[index]['recevierName']!,
                      //                         maxLines: 1,
                      //                         overflow: TextOverflow.ellipsis,
                      //                         style: TextStyle(
                      //                             color: AppColors.myWhite,
                      //                             fontSize: 16,
                      //                             fontFamily: AppStrings.appFont,
                      //                             fontWeight: FontWeight.bold),
                      //                       ),
                      //
                      //                       leading: CircleAvatar(
                      //                         backgroundImage: NetworkImage(AppCubit.get(context).lastUsers[index]['recevierImage']),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               )
                      //             );
                      //           }
                      //           return Container();
                      //         });
                      //   },
                      // ),
                      ),
                ],
              ),
            ));
      },
    );
  }

  Widget buildChatItem(UserModel model, context, index) => InkWell(
        splashColor: AppColors.primaryColor1,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetails(
                userName: AppCubit.get(context).lastUsers[index]
                    ['recevierName'],
                userId: AppCubit.get(context).lastUsers[index]['recevierId'],
                userImage: AppCubit.get(context).lastUsers[index]
                    ['recevierImage'],
              ),
            ),
          );
          // print('kkkkkkkkkkkkkkkkkkkkkkkkkkk${model.uId}');
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${model.image}'),
                radius: 25,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.username}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppStrings.appFont),
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
