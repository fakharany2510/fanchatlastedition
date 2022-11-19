// ignore_for_file: prefer_typing_uninitialized_variables, unused_element

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/public_chat_model.dart';
import 'package:fanchat/presentation/screens/show_home_image.dart';
import 'package:fanchat/presentation/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voice_message_package/voice_message_package.dart';

typedef _Fn = void Function();
Future<String> _getTempPath(String path) async {
  var tempDir = await getTemporaryDirectory();
  var tempPath = tempDir.path;
  return '$tempPath/$path';
}

class PublicChatScreen extends StatefulWidget {
  final onSendMessage;
  const PublicChatScreen({super.key, this.onSendMessage});

  @override
  State<PublicChatScreen> createState() => _PublicChatScreenState();
}

class _PublicChatScreenState extends State<PublicChatScreen> {
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
    if (AppCubit.get(context).publicChatController.hasClients) {
      AppCubit.get(context).publicChatController.animateTo(
          AppCubit.get(context).publicChatController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear);
    }
    isWriting = false;
  }

  @override
  dispose() {
    AppCubit.get(context).publicChatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
    // return ConditionalBuilder(
    //   builder: (context)=>Builder(
    //       builder: (context) {
    //         if(AppCubit.get(context).publicChatController.hasClients){
    //           AppCubit.get(context).publicChatController.animateTo(AppCubit.get(context).publicChatController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.linear);
    //         }
    //         AppCubit.get(context).getPublicChat();
    //         return BlocConsumer<AppCubit,AppState>(
    //           listener: (context,state){
    //             if(state is PickPostImageSuccessState ){
    //               Navigator.push(context, MaterialPageRoute(builder: (context)=>SendImagePublicChat()));
    //             }
    //
    //             if(state is PickPrivateChatViedoSuccessState ){
    //               Navigator.push(context, MaterialPageRoute(builder: (context)=>SendVideoPublicChat()));
    //             }
    //           },
    //           builder: (context,state){
    //             if(AppCubit.get(context).publicChatController.hasClients){
    //               AppCubit.get(context).publicChatController.animateTo(AppCubit.get(context).publicChatController.position.maxScrollExtent, duration: const Duration(milliseconds:100), curve: Curves.linear);
    //             }
    //             return Scaffold(
    //               backgroundColor: Colors.white,
    //               body: Stack(
    //                 children: [
    //                   Container(
    //                       height: MediaQuery.of(context).size.height,
    //                       width: MediaQuery.of(context).size.width,
    //                       child:const Opacity(
    //                         opacity: 1,
    //                         child:  Image(
    //                           image: AssetImage('assets/images/public_chat_image.jpeg'),
    //                           fit: BoxFit.cover,
    //
    //                         ),
    //                       )
    //                   ),
    //                   ConditionalBuilder(
    //                     builder: (context)=>Column(
    //                       children: [
    //                         Expanded(
    //                           child: Container(
    //                             height:MediaQuery.of(context).size.height*.83,
    //
    //                             padding: const EdgeInsets.all(10),
    //                             child: ListView.separated(
    //
    //                                 addAutomaticKeepAlives: true,
    //                                 controller: AppCubit.get(context).publicChatController,
    //                                 physics: const BouncingScrollPhysics(),
    //                                 itemBuilder: (context , index)
    //                                 {
    //                                   var publicChat =AppCubit.get(context).publicChat[index];
    //                                   if(AppCubit.get(context).userModel!.uId == publicChat.senderId)
    //                                     //send message
    //                                     return  SenderPublicChatWidget(index: index);
    //                                   //receive message
    //                                   return MyMessagePublicChatWidget(index: index,);
    //                                 },
    //                                 separatorBuilder: (context , index)=>const SizedBox(height: 15,),
    //                                 itemCount: AppCubit.get(context).publicChat.length),
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
    //                                         icon:RecordMp3.instance.status == RecordStatus.PAUSE ?Icon(
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
    //                                           AppCubit.get(context).publicChatController.animateTo(
    //                                             AppCubit.get(context).publicChatController.position.maxScrollExtent,
    //                                             duration: const Duration(milliseconds: 300),
    //                                             curve: Curves.easeOut,
    //                                           );
    //                                           // toogleRecord();
    //                                         },
    //
    //                                         icon:  Icon(
    //                                           Icons.send,
    //                                           color: AppColors.primaryColor1,
    //                                           size: 20,
    //                                         )
    //                                     ),
    //                                   ),
    //
    //                                 ],
    //                               )
    //                             ],
    //                           ) ,
    //                         ):
    //                         Padding(
    //                             padding: const EdgeInsets.all(8),
    //                             child: Row(
    //                               crossAxisAlignment: CrossAxisAlignment.end,
    //
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
    //                                         onChanged: (v){
    //                                           setState((){
    //                                             isWriting=true;
    //                                           });
    //                                         },
    //                                         style: TextStyle(
    //                                             color: AppColors.myWhite
    //                                         ),
    //                                         keyboardType: TextInputType.multiline,
    //                                         maxLines: null,
    //                                         controller: textMessage,
    //                                         decoration:  InputDecoration(
    //                                           border: InputBorder.none,
    //                                           hintText: 'Write your message...',
    //                                           hintStyle: TextStyle(
    //                                                 color:  const Color(0xffeef1ff).withOpacity(.9),
    //
    //                                           )
    //
    //                                         ),
    //                                       )
    //                                   ),
    //                                 ),
    //                                 const SizedBox(width: 5,),
    //                                 Padding(
    //                                   padding: const EdgeInsets.only(bottom: 10,left: 5),
    //                                   child: Container(
    //                                       width:37,
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
    //                                                 AppCubit.get(context).getPublicChat()
    //                                               }
    //                                                   :AppCubit.get(context).sendPublicChat(
    //                                                   dateTime: DateTime.now().toUtc().toString(),
    //                                                   text: textMessage.text);
    //                                               textMessage.clear();
    //                                             },
    //                                             color: AppColors.primaryColor1,
    //                                             icon: AppCubit.get(context).isSend? const CircularProgressIndicator(color: Colors.white,):  textMessage.text==""?const Icon(Icons.mic,color: Colors.white,size: 18):const Icon(Icons.send,color: Colors.white,size: 18)
    //                                         ),
    //                                       )
    //                                   ),
    //                                 ),
    //                                 const SizedBox(width: 5,),
    //                               ],
    //                             )
    //                         ),
    //
    //                       ],
    //                     ),
    //                     condition:AppCubit.get(context).publicChat.length >=0 ,
    //                     fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
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
    //                     animatedIcon: AnimatedIcons.menu_close,
    //                     elevation: 1,
    //                     visible: recording==false?true:false,
    //
    //                     overlayColor: AppColors.myWhite,
    //                     overlayOpacity: 0.0001,
    //                     children: [
    //
    //
    //                       SpeedDialChild(
    //                         onTap: (){
    //                           AppCubit.get(context).pickPostImage();
    //                         },
    //                         child: const Icon(Icons.image,color: Colors.green,size: 22,),
    //                         backgroundColor: AppColors.myWhite,
    //                       ),
    //
    //
    //                       SpeedDialChild(
    //                           onTap: (){
    //                             AppCubit.get(context).pickPostVideo4();
    //                           },
    //                           child: const Icon(Icons.video_collection_sharp,color: Colors.red,size: 22),
    //                           backgroundColor: AppColors.myWhite
    //                       ),
    //
    //                       SpeedDialChild(
    //                         onTap: (){
    //                           AppCubit.get(context).pickPostCamera();
    //                         },
    //                         child:Icon(Icons.camera_alt,color: AppColors.primaryColor1,size: 22,),
    //                         backgroundColor: AppColors.myWhite,
    //                       ),
    //                       SpeedDialChild(
    //                           onTap: (){
    //                             AppCubit.get(context).pickPostVideoCameraPublic4();
    //                           },
    //                           child: const Icon(Icons.video_camera_back,color: Colors.blue,size: 22),
    //                           backgroundColor: AppColors.myWhite
    //                       ),
    //
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         );
    //       }
    //   ),
    //   condition: AppCubit.get(context).userModel !=null,
    //   fallback: (context)=>const Center(child: CircularProgressIndicator()),
    // );
  }

  Widget buildMyMessages(PublicChatModel model, context, index) => Align(
        alignment: Alignment.topRight,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return UserProfile(
                      userId: model.senderId!,
                      userImage: model.senderImage!,
                      userName: model.senderName!);
                }));
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.myGrey,
                child: CircleAvatar(
                  backgroundImage: NetworkImage('${model.senderImage}'),
                  radius: 17,
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                (model.text != "")
                    ? Container(
                        width: MediaQuery.of(context).size.width * .74,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.myGrey,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${model.senderName}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9,
                                  color: AppColors.primaryColor1,
                                  fontFamily: AppStrings.appFont),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${model.text}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: AppStrings.appFont),
                            )
                          ],
                        ),
                      )
                    : (model.image != "")
                        ? Container(
                            width: MediaQuery.of(context).size.width * .74,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.myGrey,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${model.senderName}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 9,
                                      color: AppColors.primaryColor1,
                                      fontFamily: AppStrings.appFont),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Material(
                                  shadowColor: AppColors.myGrey,
                                  elevation: 100,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowHomeImage(
                                                      image: model.image)));
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .28,
                                      width: MediaQuery.of(context).size.width *
                                          .70,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        // border: Border.all(color: AppColors.primaryColor1,width: 4),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: CachedNetworkImage(
                                        cacheManager:
                                            AppCubit.get(context).manager,
                                        imageUrl: "${model.image}",
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        // maxHeightDiskCache:75,
                                        width: 200,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .2,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width * .60,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.myGrey,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${model.senderName}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 9,
                                      color: AppColors.primaryColor1,
                                      fontFamily: AppStrings.appFont),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                VoiceMessage(
                                  audioSrc:
                                      '${AppCubit.get(context).publicChat[index].voice}',
                                  played: true, // To show played badge or not.
                                  me: true, // Set message side.
                                  contactBgColor: AppColors.myGrey,

                                  contactFgColor: Colors.white,
                                  contactPlayIconColor: AppColors.primaryColor1,
                                  onPlay:
                                      () {}, // Do something when voice played.
                                ),
                              ],
                            ),
                          )
              ],
            ),
          ],
        ),
      );

  /*
  * :(model.image!="")
                  ?Container(
                height: MediaQuery.of(context).size.height*.28,
                width: MediaQuery.of(context).size.width*.70,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor1,width: 4),
                    borderRadius: BorderRadius.circular(3),
                ),
                  child:CachedNetworkImage(
                  cacheManager: AppCubit.get(context).manager,
                  imageUrl: "${model.image}",
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  // maxHeightDiskCache:75,
                  width: 200,
                  height: MediaQuery.of(context).size.height*.2,
                  fit: BoxFit.cover,
                ),
              )
                  :VoiceMessage(

                audioSrc: '${AppCubit.get(context).publicChat[index].voice}',
                played: true, // To show played badge or not.
                me: true, // Set message side.
                contactBgColor:AppColors.primaryColor1 ,
                contactFgColor: Colors.white,
                contactPlayIconColor: AppColors.primaryColor1,
                onPlay: () {

                }, // Do something when voice played.
              ),
  *
  * */

  //----------------------------
  Widget builsRecievedMessages(PublicChatModel model, context, index) => Align(
        alignment: Alignment.topRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (model.text != "")
                    ? Container(
                        width: MediaQuery.of(context).size.width * .74,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor1,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppCubit.get(context).userModel!.username}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9,
                                  color: AppColors.myWhite,
                                  fontFamily: AppStrings.appFont),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${model.text}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: AppColors.myWhite,
                                  fontFamily: AppStrings.appFont),
                            )
                          ],
                        ),
                      )
                    : (model.image != '')
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShowHomeImage(image: model.image)));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * .74,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor1,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${AppCubit.get(context).userModel!.username}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 9,
                                        color: AppColors.myWhite,
                                        fontFamily: AppStrings.appFont),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Material(
                                    elevation: 100,
                                    shadowColor: AppColors.myGrey,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .28,
                                      width: MediaQuery.of(context).size.width *
                                          .70,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        // border: Border.all(color: AppColors.myGrey,width: 4),
                                      ),
                                      child: CachedNetworkImage(
                                        cacheManager:
                                            AppCubit.get(context).manager,
                                        imageUrl: "${model.image}",
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        // maxHeightDiskCache:75,
                                        width: 200,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .2,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width * .60,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor1,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppCubit.get(context).userModel!.username}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 9,
                                      color: AppColors.myWhite,
                                      fontFamily: AppStrings.appFont),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                VoiceMessage(
                                  contactBgColor: AppColors.primaryColor1,
                                  contactFgColor: Colors.white,
                                  contactPlayIconColor: AppColors.primaryColor1,
                                  audioSrc:
                                      '${AppCubit.get(context).publicChat[index].voice}',
                                  played: true, // To sh
                                  // ow played badge or not.
                                  me: false, // Set message side.
                                  onPlay:
                                      () {}, // Do something when voice played.
                                ),
                              ],
                            ),
                          )
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primaryColor1,
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage('${AppCubit.get(context).userModel!.image}'),
                radius: 17,
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      );

  //////////////////////////voice functions////////////////////

  // _Fn getRecorderFn() {
  //   /* if (!_mRecorderIsInited || !_mPlayer.isStopped) {
  //     return () {};
  //   }*/
  //   return recording ? stopRecord : startRecord;
  // }
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
  // // 2- start recors
  // void startRecord() async {
  //   bool hasPermission = await checkPermission();
  //   if (hasPermission) {
  //     statusText = "Recording...";
  //     recordFilePath = await getFilePath();
  //     setState(() {
  //       recording=true;
  //     });
  //     isComplete = false;
  //     RecordMp3.instance.start(recordFilePath!, (type) {
  //       statusText = "Record error--->$type";
  //       setState(() {
  //       });
  //     });
  //   } else {
  //     statusText = "No microphone permission";
  //   }
  //   setState(() {});
  // }
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
  // // 4- stop record
  // stopRecord() async {
  //   print("startRecord11");
  //   setState(() {
  //     recording=false;
  //     uploadingRecord=true;
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
  //     }
  //     else
  //     {
  //       print("stopRecord111");
  //     }
  //   }
  // }
  // 5- upload record to firebase
  // Future uploadRecord(
  //     {
  //       String? dateTime,
  //       required File voice,
  //       String? senderId,
  //       String? senderName,
  //       String? senderImage,
  //
  //     }
  //
  //     ) async {
  //   Size size = MediaQuery.of(context).size;
  //   print("permission uploadRecord1");
  //   var uuid = const Uuid().v4();
  //   Reference storageReference =firebase_storage.FirebaseStorage.instance.ref().child('publicChat/${Uri.file(voice.path).pathSegments.last}');
  //   await storageReference.putFile(voice).then((value){
  //     AppCubit.get(context).createVoicePublicChat(
  //       dateTime: DateTime.now().toString(),
  //       voice: voice.path,
  //     );
  //     print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyeeeeeeeeeeeeeeeessssssssss');
  //   }).catchError((error){
  //     print('nnnnnnnnnnnnnnnnnnnooooooooooooooooooo');
  //     print(error.toString());
  //
  //   });
  //   var url = await storageReference.getDownloadURL();
  //   print("recording file222");
  //   print(url);
  //   widget.onSendMessage(url, "voice", size);
  //
  //   setState(() {
  //     uploadingRecord = false;
  //   });
  //
  // }
  // Future uploadRecord(
  //     {
  //       String? dateTime,
  //       required File voice,
  //       String? senderId,
  //       String? senderName,
  //       String? senderImage,
  //
  //     }
  //
  //     ) async {
  //   Size size = MediaQuery.of(context).size;
  //   print("permission uploadRecord1");
  //   var uuid = const Uuid().v4();
  //   Reference storageReference =firebase_storage.FirebaseStorage.instance.ref().child('publicChatVoices/${Uri.file('${voice}').pathSegments.last}');
  //   await storageReference.putFile(voice).then((value){
  //     value.ref.getDownloadURL().then((value){
  //       AppCubit.get(context).createVoicePublicChat(
  //         dateTime: DateTime.now().toUtc().toString(),
  //         voice: value,
  //       );
  //       widget.onSendMessage(value, "voice", size);
  //       print(value);
  //       print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyeeeeeeeeeeeeeeeessssssssss2');
  //       print('nnnnnnnnnnnnnnnnnnnooooooooooooooooooo2');
  //       setState(() {
  //         uploadingRecord = false;
  //       });
  //     }).catchError((){});
  //     print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyeeeeeeeeeeeeeeeessssssssss');
  //   }).catchError((error){
  //     print('nnnnnnnnnnnnnnnnnnnooooooooooooooooooo');
  //     print(error.toString());
  //
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
