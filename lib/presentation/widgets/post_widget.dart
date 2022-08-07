import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../../constants/app_strings.dart';
import '../screens/comment_screen.dart';

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
          color: AppColors.primaryColor1,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0,),
            child: Padding(
              padding: const EdgeInsets.all(0),
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
                                      style:  TextStyle(
                                          color: AppColors.myWhite,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: AppStrings.appFont
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
                          style:  TextStyle(
                              fontSize: 13,
                              color: AppColors.myWhite,
                              fontFamily: AppStrings.appFont
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
                          style:  TextStyle(
                              color: AppColors.myWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                              fontFamily: AppStrings.appFont
                          ),
                        )),
                  ),
                  (AppCubit.get(context).posts[widget.index!].postImage!="")
                      ?Material(
                    elevation: 1000,
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height*.25,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            image:  DecorationImage(
                                image: NetworkImage('${AppCubit.get(context).posts[widget.index!].postImage}'),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),
                  )
                      : (AppCubit.get(context).posts[widget.index!].postVideo!="")
                      ?Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*.25,
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
                            child: CircleAvatar(
                              backgroundColor: AppColors.primaryColor1,
                              radius: 20,
                              child: videoPlayerController!.value.isPlaying? const Icon(Icons.pause):const Icon(Icons.play_arrow),
                            ),
                          )
                      ),
                    ],
                  )
                      :SizedBox(width: 0,),
                  SizedBox(height: 3,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text('8',
                              style: TextStyle(
                                  color: AppColors.myWhite,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppStrings.appFont
                              ),),
                            IconButton(
                              padding:EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed:(){
                              },
                              icon: Icon(Icons.favorite_outline,color: AppColors.myGrey,size: 20),)
                          ],
                        ),
                        SizedBox(width: 15,),
                        Row(
                          children: [
                            //  Text('${AppCubit.get(context).commentNum[widget.index!]}',
                            //  style: TextStyle(
                            // color: AppColors.myWhite,
                            // fontSize: 13,
                            //      fontWeight: FontWeight.w500,
                            //      fontFamily: AppStrings.appFont
                            // ),),
                            IconButton(
                              padding:EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed:(){},
                              icon: Icon(Icons.mode_comment_outlined,color: AppColors.myGrey,size: 20),)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage('${AppCubit.get(context).posts[widget.index!].image}'),
                          radius: 18,
                        ),
                        const SizedBox(width: 7,),
                        InkWell(
                          onTap: (){
                            AppCubit.get(context).getComment( AppCubit.get(context).postsId[widget.index!]);
                            Navigator.push(context, MaterialPageRoute(builder: (_){
                              return CommentScreen(postId: AppCubit.get(context).postsId[widget.index!] ,);
                            }));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*.74,
                            height: MediaQuery.of(context).size.height*.04,
                            padding: EdgeInsets.all(9),
                            decoration: BoxDecoration(
                                color: AppColors.myGrey,
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Text(
                              'Write a comment ...',style: TextStyle(
                                color: AppColors.primaryColor1,
                                fontSize: 13,
                                fontFamily: AppStrings.appFont
                            ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}