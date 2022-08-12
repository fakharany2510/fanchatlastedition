
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/sendimage_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../data/modles/message_model.dart';
import '../../data/modles/user_model.dart';

class ChatDetails extends StatefulWidget {
  UserModel userModel;
  ChatDetails({required this.userModel});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  var textMessage = TextEditingController();
  bool isWriting = false;

  @override
  void initState() {
    super.initState();
    isWriting = false;
  }
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      builder: (context)=>Builder(
          builder: (context) {
            AppCubit.get(context).getMessages(recevierId: widget.userModel.uId!);
            return BlocConsumer<AppCubit,AppState>(
              listener: (context,state){
                if(state is PickPostImageSuccessState ){
Navigator.push(context, MaterialPageRoute(builder: (context)=>SendImage(widget.userModel)));
                }
              },
              builder: (context,state){
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: AppColors.primaryColor1,
                    elevation: 0,
                    centerTitle: true,
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage:  NetworkImage('${widget.userModel.image}') as ImageProvider,
                          radius: 22,
                        ),
                        const SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('${widget.userModel.username}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    fontFamily: AppStrings.appFont
                                  ),
                                ),

                              ],
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: ConditionalBuilder(
                      builder: (context)=>Stack(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        children: [
                          Container(
                            color: AppColors.primaryColor1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:20),
                            child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50,left: 10,right: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      height:MediaQuery.of(context).size.height*.73,
                                      child: ListView.separated(
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context , index)
                                          {
                                            var message =AppCubit.get(context).messages[index];
                                            if(widget.userModel.uId == message.senderId)
                                              //send message
                                              return builsRecievedMessages(message,context);
                                            //receive message
                                            return buildMyMessages(message,context);
                                          },
                                          separatorBuilder: (context , index)=>const SizedBox(height: 15,),
                                          itemCount: AppCubit.get(context).messages.length),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width*.7,
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
                                                controller: textMessage,
                                                decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Write your message...',

                                                ),
                                              )
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: AppColors.primaryColor1
                                            ),
                                            child: Center(
                                              child: IconButton(
                                                onPressed: (){
                                                  textMessage.text==""
                                                  ?print('kfmlngkjgnkgjngkjgngkjngkjgng')
                                                      :AppCubit.get(context).sendMessage(
                                                      recevierId: widget.userModel.uId!,
                                                      dateTime: DateTime.now().toString(),
                                                      text: textMessage.text);
                                                },
                                                color: AppColors.primaryColor1,

                                                icon:isWriting
                                                ?Icon(Icons.send,color: Colors.white,size: 20)
                                                    :Icon(Icons.mic_rounded,color: Colors.white,size: 20)
                                              ),
                                            )
                                          ),
                                          SizedBox(width: 5,),
                                          Container(
                                              width: 40,
                                              height: 40,
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
                                                    size: 20,
                                                  ),
                                                ),
                                              )
                                          ),
                                        ],
                                      )
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      condition:AppCubit.get(context).messages.length >=0 ,
                      fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
                    ),
                  ),
                );
              },
            );
          }
      ),
      condition: widget.userModel !=null,
      fallback: (context)=>const Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildMyMessages(MessageModel model,context)=> Align(
    alignment:AlignmentDirectional.centerEnd,
    child: (model.text=="")
        ?Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            padding: EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height*.28,
            width: MediaQuery.of(context).size.height*.35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                image:  DecorationImage(
                    image: NetworkImage('${model.image}'),
                    fit: BoxFit.contain
                )
            ),
          ),
        )
        :Container(
      padding: const EdgeInsets.all(10),
      decoration:  BoxDecoration(
        color: AppColors.primaryColor1,
        borderRadius:const  BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Text('${model.text}',
        style:  TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Colors.white,
            fontFamily: AppStrings.appFont
        ),
      ),
    )
  );

  //----------------------------
  Widget builsRecievedMessages(MessageModel model,context)=>Align(
    alignment:AlignmentDirectional.centerStart,
    child: (model.text=="")
        ?Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            padding: EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height*.28,
            width: MediaQuery.of(context).size.height*.35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                image:  DecorationImage(
                    image: NetworkImage('${model.image}'),
                    fit: BoxFit.contain
                )
            ),
          ),
        )
        :Container(
      padding: const EdgeInsets.all(10),
      decoration:  BoxDecoration(
        color: AppColors.myGrey,
        borderRadius:const  BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Text('${model.text}',
        style:  TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: AppColors.primaryColor1,
            fontFamily: AppStrings.appFont
        ),
      ),
    )
  );
}
