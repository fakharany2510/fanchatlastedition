import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/data/modles/create_post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class PostWidget extends StatefulWidget {
  int ?index;
  PostWidget({Key? key,this.index}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {


  VideoPlayerController ?videoPlayerController;
  Future <void> ?intilize;
  @override
  void initState() {
    videoPlayerController=VideoPlayerController.network(
        AppCubit.get(context).posts[widget.index!].postVideo!
    );
    intilize=videoPlayerController!.initialize();
    videoPlayerController!.setLooping(true);
    videoPlayerController!.setVolume(1.0);    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(listener: (context,state){
      if(state is NavigateScreenState){
            videoPlayerController!.pause();
      }

    },
      builder: (context,state){
       return Card(
         elevation: 2,
         shadowColor: Colors.grey[150],
         child: Padding(
           padding: const EdgeInsets.only(bottom: 0,),
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: Row(
                     children: [
                       CircleAvatar(
                         backgroundImage: NetworkImage('${AppCubit.get(context).posts[widget.index!].image}'),
                         radius: 18,
                       ),
                       const SizedBox(width: 7,),
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               children: [
                                 Expanded(
                                   child: Text('${AppCubit.get(context).posts[widget.index!].name}',
                                     overflow: TextOverflow.ellipsis,
                                     style: const TextStyle(
                                         color: Colors.black,
                                         fontSize: 14,
                                         fontWeight: FontWeight.w500
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ],
                         ),
                       ),
                       const Spacer(),
                       Text('${AppCubit.get(context).posts[widget.index!].dateTime}',
                         overflow: TextOverflow.ellipsis,
                         style: const TextStyle(
                             fontSize: 13,
                             color: Colors.grey
                         ),
                       ),
                     ],
                   ),
                 ),
                 const SizedBox(height:5),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 5,top: 5),
                   child: Container(
                       padding: const EdgeInsets.symmetric(horizontal: 10),
                       child: Text('${AppCubit.get(context).posts[widget.index!].text}',
                         style: const TextStyle(
                           fontSize: 14,
                           fontWeight: FontWeight.w700,
                           height: 1.2,
                         ),
                       )),
                 ),
                 (AppCubit.get(context).posts[widget.index!].postImage!="")
                 ?Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: Container(
                     height: MediaQuery.of(context).size.height*.2,
                     width: double.infinity,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(3),
                         image:  DecorationImage(
                             image: NetworkImage('${AppCubit.get(context).posts[widget.index!].postImage}'),
                             fit: BoxFit.cover
                         )
                     ),
                   ),
                 ):
                 Stack(
                   children: [
                     Container(
                       height: MediaQuery.of(context).size.height*.2,
                       width: double.infinity,
                       child: FutureBuilder(
                         future: intilize,
                         builder: (context,snapshot){
                           if(snapshot.connectionState == ConnectionState.done){
                             return AspectRatio(
                               aspectRatio: videoPlayerController!.value.aspectRatio,
                               child: VideoPlayer(videoPlayerController!),
                             );
                           }
                           else{
                             return const Center(
                               child: CircularProgressIndicator(),
                             );
                           }
                         },



                       ),
                     ),
                     Positioned(
                         top: 10,
                         right: 20,
                         child: InkWell(
                           onTap: (){
                             setState((){
                               if(videoPlayerController!.value.isPlaying){
                                 videoPlayerController!.pause();
                               }else{
                                 videoPlayerController!.play();
                               }
                             });
                           },
                           child:  CircleAvatar(
                             backgroundColor: AppColors.primaryColor1,
                             child: Icon(Icons.play_arrow),
                             radius: 20,
                           ),
                         )
                     ),
                   ],
                 ),
                 SizedBox(height: 3,),
                 Divider(color: Colors.grey,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     InkWell(
                       onTap: (){
                         AppCubit.get(context).likePosts((AppCubit.get(context).postsId[widget.index!])).then((value) {
                         });
                       },
                       child: Container(
                         width: MediaQuery.of(context).size.width*.3,
                         height: MediaQuery.of(context).size.height*.05,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text('55',
                               style: TextStyle(
                                   color: Colors.grey,
                                   fontSize: 13,
                                   fontWeight: FontWeight.w500
                               ),),
                             SizedBox(width: 3,),
                             Icon(Icons.favorite_border_outlined,size:22,
                               color: Colors.grey,
                             )
                           ],
                         ),
                       ),

                     ),
                     SizedBox(width: MediaQuery.of(context).size.width*.1,),
                     Container(
                       color: Colors.grey,
                       height: 25,
                       width: 1,

                     ),
                     SizedBox(width: MediaQuery.of(context).size.width*.1,),
                     InkWell(
                       onTap: (){},
                       child: Container(
                         width: MediaQuery.of(context).size.width*.3,
                         height: MediaQuery.of(context).size.height*.05,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text('300',
                               style: TextStyle(
                                   color: Colors.grey,
                                   fontSize: 13,
                                   fontWeight: FontWeight.w500
                               ),),
                             SizedBox(width: 3,),
                             Icon(Icons.comment,size:22,
                               color: Colors.grey,
                             )

                           ],
                         ),
                       ),

                     ),
                   ],
                 )
               ],
             ),
           ),
         ),
       );
      },
    );
  }
}
