// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:fanchat/business_logic/cubit/app_cubit.dart';
// import 'package:fanchat/constants/app_colors.dart';
// import 'package:fanchat/constants/app_strings.dart';
// import 'package:fanchat/presentation/screens/private_chat/send_notification_chat.dart';
// import 'package:fanchat/presentation/screens/private_chat/send_video_message.dart';
// import 'package:fanchat/presentation/screens/private_chat/sendimage_message.dart';
// import 'package:fanchat/presentation/screens/private_chat/my_widget.dart';
// import 'package:fanchat/presentation/screens/private_chat/sender_widget.dart';
// import 'package:fanchat/presentation/screens/user_profile.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// typedef _Fn = void Function();
// Future<String> _getTempPath(String path) async {
//   var tempDir = await getTemporaryDirectory();
//   var tempPath = tempDir.path;
//   return '$tempPath/$path';
// }

class ChatDetails extends StatefulWidget {
  String? userId;
  String? userImage;
  String? userName;
  final onSendMessage;
  ChatDetails(
      {super.key,
      required this.userId,
      required this.userName,
      required this.userImage,
      this.onSendMessage});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  var textMessage = TextEditingController();
  bool isWriting = false;
  String? recordFilePath;
  String statusText = '';
  int i = 0;
  bool recording = false;
  bool? isComplete;
  bool? uploadingRecord = false;

  @override
  void initState() {
    super.initState();

    isWriting = false;
    AppCubit.get(context).getMessages(recevierId: widget.userId!);

    if (AppCubit.get(context).privateScrollController.hasClients) {
      AppCubit.get(context).privateScrollController.animateTo(
          AppCubit.get(context).publicChatController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear);
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      if (AppCubit.get(context).privateScrollController.hasClients) {
        AppCubit.get(context).privateScrollController.animateTo(
            AppCubit.get(context).publicChatController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.linear);
      }
    });

    // Future.delayed(const Duration(milliseconds: 1500),(){
    //   if(AppCubit.get(context).privateScrollController.hasClients){
    //     AppCubit.get(context).privateScrollController.animateTo(AppCubit.get(context).publicChatController.position.maxScrollExtent, duration: const Duration(milliseconds:100), curve: Curves.linear);
    //   }
    // });
    //
    // Future.delayed(const Duration(milliseconds: 2500),(){
    //   if(AppCubit.get(context).privateScrollController.hasClients){
    //     AppCubit.get(context).privateScrollController.animateTo(AppCubit.get(context).publicChatController.position.maxScrollExtent, duration: const Duration(milliseconds:100), curve: Curves.linear);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(); // if(AppCubit.get(context).privateScrollController.hasClients){
    //   AppCubit.get(context).privateScrollController.animateTo(AppCubit.get(context).privateScrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.linear);
    // }
    // return ConditionalBuilder(
    //   builder: (context)=>Builder(
    //
    //       builder: (context) {
    //         if(AppCubit.get(context).privateScrollController.hasClients){
    //           AppCubit.get(context).privateScrollController.animateTo(AppCubit.get(context).privateScrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.linear);
    //         }
    //         return BlocConsumer<AppCubit,AppState>(
    //           listener: (context,state){
    //             if(state is PickChatImageSuccessState ){
    //               Navigator.push(context, MaterialPageRoute(builder: (context)=>SendImage(widget.userName,widget.userImage,widget.userId)));
    //             }
    //             if(state is PickPrivateChatViedoSuccessState ){
    //               Navigator.push(context, MaterialPageRoute(builder: (context)=>SendVideoMessage(userId: widget.userId,userImage: widget.userImage,userName: widget.userName, )));
    //             }
    //           },
    //           builder: (context,state){
    //             if(AppCubit.get(context).privateScrollController.hasClients){
    //               AppCubit.get(context).privateScrollController.animateTo(AppCubit.get(context).privateScrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.linear);
    //             }
    //             return Scaffold(
    //               backgroundColor: Colors.white,
    //               appBar: AppBar(
    //                 backgroundColor: AppColors.primaryColor1,
    //                 elevation: 0,
    //                 centerTitle: false,
    //                 leading: IconButton(
    //                   onPressed: (){
    //                      // controllerPrivate!.pause();
    //                       Navigator.pop(context);
    //                   },
    //                   icon: Icon(
    //                     Icons.arrow_back_ios_outlined,
    //                     color: AppColors.myWhite,
    //                   ),
    //                 ),
    //                 title: Row(
    //                   mainAxisSize: MainAxisSize.min,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     GestureDetector(
    //                       onTap: (){
    //                         AppCubit.get(context).getUserProfilePosts(id: '${widget.userId}').then((value) {
    //                           Navigator.push(context, MaterialPageRoute(builder: (_){
    //                             return UserProfile(
    //                               userId: '${widget.userId}',
    //                               userImage: '${widget.userImage}',
    //                               userName: '${widget.userName}',
    //
    //                             );
    //                           }));
    //                         });
    //                       },
    //                       child: CircleAvatar(
    //                         backgroundImage:  NetworkImage('${widget.userImage}'),
    //                         radius: 22,
    //                       ),
    //                     ),
    //                     const SizedBox(width: 15,),
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Row(
    //                           children: [
    //                             Text(widget.userName!,
    //                               style: const TextStyle(
    //                                   color: Colors.white,
    //                                   fontSize: 16,
    //                                   fontWeight: FontWeight.w500,
    //                                   fontFamily: AppStrings.appFont
    //                               ),
    //                             ),
    //
    //                           ],
    //                         ),
    //
    //                       ],
    //                     ),
    //
    //                   ],
    //                 ),
    //               ),
    //               body: Stack(
    //                 children: [
    //                   Container(
    //                       height: MediaQuery.of(context).size.height,
    //                       width: MediaQuery.of(context).size.width,
    //                       child:const Opacity(
    //                         opacity: 1,
    //                         child:  Image(
    //                           image: AssetImage('assets/images/chat_image.jpg'),
    //                           fit: BoxFit.cover,
    //
    //                         ),
    //                       )
    //                   ),
    //
    //                   ConditionalBuilder(
    //                     builder: (context)=>Column(
    //                       children: [
    //                         Expanded(
    //                           child: Container(
    //                             height:MediaQuery.of(context).size.height*.83,
    //                             padding: const EdgeInsets.all(10),
    //                             child: ListView.separated(
    //                                 controller: AppCubit.get(context).privateScrollController,
    //                                 physics: const BouncingScrollPhysics(),
    //                                 itemBuilder: (context , index)
    //                                 {
    //                                   var message =AppCubit.get(context).messages[index];
    //                                   if(widget.userId == message.senderId) {
    //                                     return SenderMessageWidget(index: index,);
    //                                   }
    //                                   //receive message
    //                                     return MyMessageWidget(index: index,);
    //                                 },
    //                                 separatorBuilder: (context , index)=>const SizedBox(height: 15,),
    //                                 itemCount: AppCubit.get(context).messages.length),
    //                           ),
    //                         ),
    //                         recording==true?
    //                         Container(
    //                           width: double.infinity,
    //                           height: 100,
    //                           decoration: BoxDecoration(
    //                               color: AppColors.primaryColor1
    //                           ),
    //                           child: Column(
    //                             children: [
    //                               const SizedBox(height: 5,),
    //                               Text('${statusText}',style: const TextStyle(
    //                                   color: Colors.white,
    //                                   fontFamily: AppStrings.appFont,
    //                                   fontSize: 18,
    //                                   fontWeight: FontWeight.w500
    //                               ),),
    //                               const SizedBox(height: 10,),
    //                               Row(
    //                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                                 children: [
    //                                   CircleAvatar(
    //                                     radius: 20,
    //                                     backgroundColor: AppColors.myWhite,
    //                                     child:IconButton(
    //                                         onPressed: (){
    //                                           setState(() {
    //                                             recording=false;
    //                                           });
    //                                           // pauseRecord();
    //                                         },
    //                                         icon:Icon(
    //                                           Icons.delete,
    //                                           color: AppColors.primaryColor1,
    //                                           size: 20,
    //                                         )
    //                                     ),
    //                                   ),
    //                                   CircleAvatar(
    //                                     radius: 20,
    //                                     backgroundColor: AppColors.myWhite,
    //                                     child:IconButton(
    //                                         onPressed: (){
    //                                           pauseRecord();
    //                                         },
    //                                         icon: RecordMp3.instance.status == RecordStatus.PAUSE ?Icon(
    //                                           Icons.radio_button_unchecked_rounded,
    //                                           color: AppColors.primaryColor1,
    //                                           size: 20,
    //                                         ):Icon(
    //                                           Icons.pause,
    //                                           color: AppColors.primaryColor1,
    //                                           size: 20,
    //                                         )
    //                                     ),
    //                                   ),
    //                                   CircleAvatar(
    //                                     radius: 20,
    //                                     backgroundColor: AppColors.myWhite,
    //                                     child:  IconButton(
    //                                         onPressed: (){
    //                                           setState(() {
    //                                             recording=false;
    //                                             AppCubit.get(context).isSend=true;
    //                                           });
    //                                           stopRecord();
    //                                           AppCubit.get(context).privateScrollController.animateTo(
    //                                             AppCubit.get(context).privateScrollController.position.maxScrollExtent,
    //                                             duration: const Duration(milliseconds: 300),
    //                                             curve: Curves.easeOut,
    //                                           );
    //                                           // toogleRecord();
    //                                         },
    //                                         icon:  Icon(
    //                                           Icons.send,
    //                                           color: AppColors.primaryColor1,
    //                                           size: 20,
    //                                         )
    //                                     ),
    //                                   ),
    //                                 ],
    //                               )
    //                             ],
    //                           ) ,
    //                         ):
    //                         Padding(
    //                             padding: const EdgeInsets.all(8),
    //                             child: Row(
    //                               crossAxisAlignment: CrossAxisAlignment.end,
    //                               children: [
    //                                 Container(
    //                                   width: MediaQuery.of(context).size.width*.70,
    //                                   clipBehavior: Clip.antiAliasWithSaveLayer,
    //                                   decoration: BoxDecoration(
    //                                     border: Border.all(
    //                                         color: const Color(0xff7895b2).withOpacity(.9),
    //                                         width: 1
    //                                     ),
    //                                     borderRadius: BorderRadius.circular(20),
    //                                   ),
    //                                   child: Padding(
    //                                       padding: const EdgeInsets.only(left: 8),
    //                                       child: TextFormField(
    //                                         style: TextStyle(
    //                                           color: Colors.white
    //                                         ),
    //                                         onChanged: (v){
    //                                           setState((){
    //                                             isWriting=true;
    //                                           });
    //                                         },
    //                                         keyboardType: TextInputType.multiline,
    //                                         maxLines: null,
    //                                         controller: textMessage,
    //                                         decoration:  InputDecoration(
    //                                           hintStyle: TextStyle(
    //                                             color:  Color(0xffeef1ff).withOpacity(.9),
    //                                           ),
    //                                           border: InputBorder.none,
    //                                           hintText: 'Write your message...',
    //                                         ),
    //                                       )
    //                                   ),
    //                                 ),
    //                                 const SizedBox(width: 5,),
    //                                 Padding(
    //                                   padding: const EdgeInsets.only(bottom: 10,left: 5),
    //                                   child: Container(
    //                                       width: 37,
    //                                       height: 37,
    //                                       decoration: BoxDecoration(
    //                                           borderRadius: BorderRadius.circular(50),
    //                                         color: const Color(0xff7895b2).withOpacity(.9),
    //                                       ),
    //                                       child: Center(
    //                                         child: IconButton(
    //                                             onPressed: (){
    //                                               HapticFeedback.vibrate();
    //                                               textMessage.text==""
    //                                                   ?{
    //                                                 recording?stopRecord():startRecord(),
    //                                                 AppCubit.get(context).getMessages(recevierId:widget.userId!)
    //                                               } :
    //                                               AppCubit.get(context).sendMessage(recevierId: widget.userId!, recevierImage:widget.userImage!, recevierName: widget.userName!, dateTime: DateTime.now().toUtc().toString(), text: textMessage.text);
    //                                               setState(() {
    //                                                  FirebaseFirestore.instance.collection('tokens').doc(widget.userId!).get().then((value) {
    //
    //                                                    callFcmApiSendPushNotificationsChat(
    //                                                      token: value.data()!['token'],
    //                                                      title: 'Check Your message',
    //                                                      description:textMessage.text,
    //                                                      imageUrl: widget.userImage!,
    //                                                      //  token:AppCubit.get(context).userToken
    //                                                    );
    //
    //                                                  });
    //                                               });
    //
    //                                               textMessage.clear();
    //                                             },
    //                                             color: const Color(0xff7895b2).withOpacity(.9),
    //                                             icon: AppCubit.get(context).isSend? const CircularProgressIndicator(color: Colors.white,):  textMessage.text==""?const Icon(Icons.mic,color: Colors.white,size: 18):const Icon(Icons.send,color: Colors.white,size: 18)
    //                                         ),
    //                                       )
    //                                   ),
    //                                 ),
    //                                 const SizedBox(width: 5,),
    //                               ],
    //                             )
    //                         ),
    //                       ],
    //                     ),
    //                     condition:AppCubit.get(context).messages.length >=0 ,
    //                     fallback:(context)=>const Center(child: CircularProgressIndicator()),
    //                   ),
    //                 ],
    //               ),
    //               floatingActionButton:Padding(
    //                 padding: const EdgeInsets.only(bottom:0,left:5),
    //                 child: Container(
    //                   width: MediaQuery.of(context).size.width*.10,
    //                   height: MediaQuery.of(context).size.height*.05,
    //
    //                   child: SpeedDial(
    //                     backgroundColor:recording==false? const Color(0xff7895b2).withOpacity(.9):AppColors.primaryColor1,
    //                   animatedIcon: AnimatedIcons.menu_close,
    //                   elevation: 1,
    //                     visible: recording==false?true:false,
    //                     overlayColor: AppColors.myWhite,
    //                   overlayOpacity: 0.0001,
    //                   children: [
    //                     SpeedDialChild(
    //                       onTap: (){
    //                         AppCubit.get(context).pickChatImage();
    //                       },
    //                       child: Icon(Icons.image,color: Colors.green,size: 22,),
    //                       backgroundColor: AppColors.myWhite,
    //                     ),
    //
    //
    //                     SpeedDialChild(
    //                         onTap: (){
    //                           AppCubit.get(context).pickPostVideo3();
    //                         },
    //                         child: Icon(Icons.video_collection_sharp,color: Colors.red,size: 22),
    //                         backgroundColor: AppColors.myWhite
    //                     ),
    //
    //                     SpeedDialChild(
    //                       onTap: (){
    //                         AppCubit.get(context).pickChatCamera();
    //                       },
    //                       child: Icon(Icons.camera_alt,color: AppColors.primaryColor1,size: 22,),
    //                       backgroundColor: AppColors.myWhite,
    //                     ),
    //
    //                     SpeedDialChild(
    //                         onTap: (){
    //                           AppCubit.get(context).pickPostVideoCameraPrivate3();
    //                         },
    //                         child: Icon(Icons.video_camera_back,color: Colors.blue,size: 22),
    //                         backgroundColor: AppColors.myWhite
    //                     ),
    //
    //                   ],
    //             ),
    //                 ),
    //               ),
    //             );
    //           },
    //         );
    //       }
    //   ),
    //   condition: widget.userName !=null,
    //   fallback: (context)=>const Center(child: CircularProgressIndicator()),
    // );
  }

  // @override
  // void dispose() {
  //   AppCubit.get(context).privateScrollController;
  //   super.dispose();
  // }
  //
  // _Fn getRecorderFn() {
  //   /* if (!_mRecorderIsInited || !_mPlayer.isStopped) {
  //     return () {};
  //   }*/
  //   return recording ? stopRecord : startRecord;
  // }
  //
  // // 1- chech permission
  // Future<bool> checkPermission() async {
  //   if (!await Permission.microphone.isGranted) {
  //     PermissionStatus status = await Permission.microphone.request();
  //     if (status != PermissionStatus.granted) {
  //       return false;
  //     }
  //   }
  //   return true;
  // }
  //
  // // 2- start recors
  // void startRecord() async {
  //   bool hasPermission = await checkPermission();
  //   if (hasPermission) {
  //     statusText = "Recording...";
  //     recordFilePath = await getFilePath();
  //     setState(() {
  //       recording = true;
  //     });
  //     isComplete = false;
  //     RecordMp3.instance.start(recordFilePath!, (type) {
  //       statusText = "Record error--->$type";
  //       setState(() {});
  //     });
  //   } else {
  //     statusText = "No microphone permission";
  //   }
  //   setState(() {});
  // }
  //
  // // 3- get file path
  // Future<String> getFilePath() async {
  //   Directory storageDirectory = await getApplicationDocumentsDirectory();
  //   String sdPath = storageDirectory.path + "/record";
  //   var d = Directory(sdPath);
  //   if (!d.existsSync()) {
  //     d.createSync(recursive: true);
  //   }
  //   return sdPath + "/test1111_${i++}.mp3";
  // }
  //
  // // 4- stop record
  // stopRecord() async {
  //   print("startRecord11");
  //   setState(() {
  //     recording = false;
  //     uploadingRecord = true;
  //   });
  //   bool s = RecordMp3.instance.stop();
  //   if (s) {
  //     //statusText = "Record complete";
  //     //isComplete = true;
  //     setState(() {});
  //     if (recordFilePath != null && File(recordFilePath!).existsSync()) {
  //       print("stopRecord000");
  //       File recordFile = new File(recordFilePath!);
  //       uploadRecord(voice: recordFile);
  //     } else {
  //       print("stopRecord111");
  //     }
  //   }
  // }
  //
  // // 5- upload record to firebase
  // Future uploadRecord({
  //   String? recevierId,
  //   String? dateTime,
  //   required File voice,
  //   String? senderId,
  // }) async {
  //   Size size = MediaQuery.of(context).size;
  //   print("permission uploadRecord1");
  //   var uuid = const Uuid().v4();
  //   Reference storageReference = firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('ali/${Uri.file('${voice}').pathSegments.last}');
  //   await storageReference.putFile(voice).then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       AppCubit.get(context).createVoiceMessage(
  //         recevierId: widget.userId!,
  //         recevierImage: widget.userImage!,
  //         recevierName: widget.userName!,
  //         dateTime: DateTime.now().toUtc().toString(),
  //         voice: value,
  //       );
  //       widget.onSendMessage(value, "voice", size);
  //
  //       setState(() {
  //         uploadingRecord = false;
  //       });
  //     }).catchError(() {});
  //     print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyeeeeeeeeeeeeeeeessssssssss');
  //   }).catchError((error) {
  //     print('nnnnnnnnnnnnnnnnnnnooooooooooooooooooo');
  //     print(error.toString());
  //   });
  // }
  //
  // void pauseRecord() {
  //   if (RecordMp3.instance.status == RecordStatus.PAUSE) {
  //     bool s = RecordMp3.instance.resume();
  //     if (s) {
  //       statusText = "Recording...";
  //       setState(() {});
  //     }
  //   } else {
  //     bool s = RecordMp3.instance.pause();
  //     if (s) {
  //       statusText = "Recording pause...";
  //       setState(() {});
  //     }
  //   }
  // }
}
