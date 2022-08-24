import 'dart:io';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/public_chat_model.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/screens/public_chat/send_image_public_chat.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:voice_message_package/voice_message_package.dart';



typedef _Fn = void Function();
Future<String> _getTempPath(String path) async {
  var tempDir = await getTemporaryDirectory();
  var tempPath = tempDir.path;
  return tempPath + '/' + path;
}
class PublicChatScreen extends StatefulWidget {


  final onSendMessage;
  PublicChatScreen({this.onSendMessage});

  @override
  State<PublicChatScreen> createState() => _PublicChatScreenState();
}

class _PublicChatScreenState extends State<PublicChatScreen> {
  var textMessage = TextEditingController();
  bool isWriting = false;
  String? recordFilePath;
  String statusText='';
  int i=0;
  bool recording=false;
  bool? isComplete;
  bool? uploadingRecord = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {

    super.initState();
    if(scrollController.hasClients){
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.linear);
    }
    isWriting = false;
  }
  @override
  Widget build(BuildContext context) {

    return ConditionalBuilder(
      builder: (context)=>Builder(
          builder: (context) {
            if(scrollController.hasClients){
              scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.linear);
            }
            AppCubit.get(context).getPublicChat();
            return BlocConsumer<AppCubit,AppState>(
              listener: (context,state){
                if(state is PickPostImageSuccessState ){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SendImagePublicChat()));
                }
              },
              builder: (context,state){
                if(scrollController.hasClients){
                  scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.linear);
                }
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: AppColors.primaryColor1,
                    elevation: 0,
                    titleSpacing: 0.0,
                    centerTitle: false,
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          backgroundImage:  NetworkImage('https://img.freepik.com/free-vector/messages-concept-illustration_114360-583.jpg?w=740&t=st=1661099337~exp=1661099937~hmac=2ae9e37e55c500b6273d2634baf01732ec2c36a9c59eb7e258a47e3c5b84bd34') as ImageProvider,
                          radius: 22,
                        ),
                        const SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('Public Chat',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: AppStrings.appFont
                                  ),
                                ),

                              ],
                            ),

                          ],
                        ),

                      ],
                    ),
                    leading: IconButton(
                      onPressed: (){
                        AppCubit.get(context).currentIndex=0;
                        Navigator.push(context, MaterialPageRoute(builder: (_){
                          return const HomeLayout();
                        }));
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.myWhite,
                      ),
                    ),
                  ),
                  body: ConditionalBuilder(
                    builder: (context)=>Column(
                      children: [
                        Expanded(
                          child: Container(
                            height:MediaQuery.of(context).size.height*.83,
                            color: Colors.white,
                            padding: const EdgeInsets.all(10),
                            child: ListView.separated(
                              controller: scrollController,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context , index)
                                {
                                  var publicChat =AppCubit.get(context).publicChat[index];
                                  if(AppCubit.get(context).userModel!.uId == publicChat.senderId)
                                    //send message
                                    return builsRecievedMessages(publicChat,context,index);
                                  //receive message
                                  return buildMyMessages(publicChat,context,index);
                                },
                                separatorBuilder: (context , index)=>const SizedBox(height: 15,),
                                itemCount: AppCubit.get(context).publicChat.length),
                          ),
                        ),
                        recording==true?
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor1
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 5,),
                              Text('${statusText}',style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppStrings.appFont,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                              ),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.myWhite,
                                    child:IconButton(
                                        onPressed: (){
                                          pauseRecord();
                                        },
                                        icon:   RecordMp3.instance.status == RecordStatus.PAUSE ?Icon(
                                          Icons.radio_button_unchecked_rounded,
                                          color: AppColors.primaryColor1,
                                          size: 20,
                                        ):Icon(
                                          Icons.pause,
                                          color: AppColors.primaryColor1,
                                          size: 20,
                                        )
                                    ),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width*.5,),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.myWhite,
                                    child:  IconButton(
                                        onPressed: (){
                                          setState(() {
                                            recording=false;
                                            AppCubit.get(context).isSend=true;
                                          });
                                          stopRecord();
                                          scrollController.animateTo(
                                            scrollController.position.maxScrollExtent,
                                            duration: const Duration(milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                          // toogleRecord();
                                        },
                                        icon:  Icon(
                                          Icons.send,
                                          color: AppColors.primaryColor1,
                                          size: 20,
                                        )
                                    ),
                                  ),

                                ],
                              )
                            ],
                          ) ,
                        ):
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*.74,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:AppColors.primaryColor1,
                                        width: 1
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: TextFormField(
                                        onChanged: (v){
                                          setState((){
                                            isWriting=true;
                                          });
                                        },
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        controller: textMessage,
                                        decoration:  InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Write your message...',
                                          suffixIcon: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                Container(
                                    width:35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.primaryColor1
                                    ),
                                    child: Center(
                                      child: IconButton(
                                          onPressed: (){
                                            textMessage.text==""
                                                ?{
                                              recording?stopRecord():startRecord(),
                                              AppCubit.get(context).getPublicChat()
                                            }
                                                :AppCubit.get(context).sendPublicChat(
                                                dateTime: DateTime.now().toString(),
                                                text: textMessage.text);
                                            textMessage.clear();
                                          },
                                          color: AppColors.primaryColor1,
                                          icon: AppCubit.get(context).isSend? CircularProgressIndicator(color: Colors.white,):  textMessage.text==""?Icon(Icons.mic,color: Colors.white,size: 17):Icon(Icons.send,color: Colors.white,size: 17)
                                      ),
                                    )
                                ),
                                const SizedBox(width: 5,),
                                Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.primaryColor1
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        onPressed: (){
                                          AppCubit.get(context).pickPostImage();

                                        },
                                        color: AppColors.primaryColor1,
                                        icon: const ImageIcon(
                                          AssetImage("assets/images/fanarea.png"),
                                          color:Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    )
                                ),
                                //                 Container(
                                //                     width: 40,
                                //                     height: 40,
                                //                     decoration: BoxDecoration(
                                //                         borderRadius: BorderRadius.circular(50),
                                //                         color: AppColors.primaryColor1
                                //                     ),
                                //                     child: Center(
                                //                       child: IconButton(
                                //                         icon: recording
                                //                             ? Icon(Icons.pause_outlined, color: Colors.red)
                                //                             : Icon(
                                //                           Icons.mic,
                                //                           color:Colors.white,
                                //                         ),
                                //                         onPressed: () =>{
                                //                            recording?stopRecord():startRecord(),
                                //                           AppCubit.get(context).getMessages(recevierId:widget.userModel.uId!)
                                // },
                                //                         color:Theme.of(context).primaryColor,
                                //                       ),
                                //                     )
                                //                 ),
                              ],
                            )
                        ),

                      ],
                    ),
                    condition:AppCubit.get(context).publicChat.length >=0 ,
                    fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
                  ),
                );
              },
            );
          }
      ),
      condition: AppCubit.get(context).userModel !=null,
      fallback: (context)=>const Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildMyMessages(PublicChatModel model,context,index)=> Align(
    alignment:Alignment.topRight,
    child: Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.myGrey,
          child: CircleAvatar(
            backgroundImage:  NetworkImage('${model.senderImage}' ),
            radius: 17,
            backgroundColor: Colors.blue,
          ),

        ),
        const SizedBox(width: 5,),
        Container(
          width: MediaQuery.of(context).size.width*.60,
          padding: const EdgeInsets.all(10),
          decoration:  BoxDecoration(
            color: AppColors.myGrey,
            borderRadius:const  BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.senderName}',
                style:  TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 9,
                    color: AppColors.primaryColor1,
                    fontFamily: AppStrings.appFont
                ),

              ),
              const SizedBox(height: 5,),
              (model.text!="")
                  ?Text('${model.text}',
                style:  const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: AppStrings.appFont
                ),
              )
                  :(model.image!="")
                  ?Container(
                height: MediaQuery.of(context).size.height*.28,
                width: MediaQuery.of(context).size.width*.55,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor1,width: 4),
                    borderRadius: BorderRadius.circular(3),
                    image:  DecorationImage(
                        image: NetworkImage('${model.image}'),
                        fit: BoxFit.fill
                    )
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
            ],
          ),
        ),
      ],
    ),
  );

  //----------------------------
  Widget builsRecievedMessages(PublicChatModel model,context,index)=>Align(
    alignment:Alignment.topRight,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width*.60,
          padding: const EdgeInsets.all(10),
          decoration:  BoxDecoration(
            color: AppColors.primaryColor1,
            borderRadius:const  BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${AppCubit.get(context).userModel!.username}',
                style:  TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 9,
                    color: AppColors.myWhite,
                    fontFamily: AppStrings.appFont
                ),
              ),
              const SizedBox(height: 5,),
              (model.text!="")
                  ?Text('${model.text}',
                style:  TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: AppColors.myWhite,
                    fontFamily: AppStrings.appFont
                ),
              )
                  :(model.image != '')
                  ?Container(
                height: MediaQuery.of(context).size.height*.28,
                width: MediaQuery.of(context).size.width*.55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: AppColors.myGrey,width: 4),
                    image:  DecorationImage(
                        image: NetworkImage('${model.image}'),
                        fit: BoxFit.fill
                    )
                ),
              )
                  :VoiceMessage(
                contactBgColor:AppColors.primaryColor1 ,
                contactFgColor: Colors.white,
                contactPlayIconColor: AppColors.primaryColor1,
                audioSrc: '${AppCubit.get(context).publicChat[index].voice}',
                played: true, // To show played badge or not.
                me: false, // Set message side.
                onPlay: () {}, // Do something when voice played.
              ),
            ],
          ),
        ),
        const SizedBox(width: 5,),
        CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.primaryColor1,
          child: CircleAvatar(
            backgroundImage:  NetworkImage('${AppCubit.get(context).userModel!.image}') as ImageProvider,
            radius: 17,
            backgroundColor: Colors.blue,
          ),

        ),

      ],
    ),
  );

  //////////////////////////voice functions////////////////////
  @override
  void dispose() {
    super.dispose();
  }
  _Fn getRecorderFn() {
    /* if (!_mRecorderIsInited || !_mPlayer.isStopped) {
      return () {};
    }*/
    return recording ? stopRecord : startRecord;
  }
  // 1- chech permission
  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
  // 2- start recors
  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      setState(() {
        recording=true;
      });
      isComplete = false;
      RecordMp3.instance.start(recordFilePath!, (type) {
        statusText = "Record error--->$type";
        setState(() {
        });
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }
  // 3- get file path
  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test1111_${i++}.mp3";
  }
  // 4- stop record
  stopRecord() async {
    print("startRecord11");
    setState(() {
      recording=false;
      uploadingRecord=true;
    });
    bool s = RecordMp3.instance.stop();
    if (s) {
      //statusText = "Record complete";
      //isComplete = true;
      setState(() {});
      if (recordFilePath != null && File(recordFilePath!).existsSync()) {
        print("stopRecord000");
        File recordFile = new File(recordFilePath!);
        uploadRecord(voice: recordFile);
      }
      else
      {
        print("stopRecord111");
      }
    }
  }
  // 5- upload record to firebase
  Future uploadRecord(
      {
        String? dateTime,
        required File voice,
        String? senderId,
        String? senderName,
        String? senderImage,

      }

      ) async {
    Size size = MediaQuery.of(context).size;
    print("permission uploadRecord1");
    var uuid = const Uuid().v4();
    Reference storageReference =firebase_storage.FirebaseStorage.instance.ref().child('publicChat/${Uri.file(voice.path).pathSegments.last}');
    await storageReference.putFile(voice).then((value){
      AppCubit.get(context).createVoicePublicChat(
        dateTime: DateTime.now().toString(),
        voice: voice.path,
      );
      print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyeeeeeeeeeeeeeeeessssssssss');
    }).catchError((error){
      print('nnnnnnnnnnnnnnnnnnnooooooooooooooooooo');
      print(error.toString());

    });
    var url = await storageReference.getDownloadURL();
    print("recording file222");
    print(url);
    widget.onSendMessage(url, "voice", size);

    setState(() {
      uploadingRecord = false;
    });

  }

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Recording...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Recording pause...";
        setState(() {});
      }
    }
  }

}

