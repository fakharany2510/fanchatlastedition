import 'package:fanchat/business_logic/advertising_cubit/advertising_cubit.dart';
import 'package:fanchat/business_logic/advertising_cubit/advertising_state.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class AdvertisingFullVideo extends StatefulWidget {
  AdvertisingFullVideo({Key? key,this.video,this.videoLink}) : super(key: key);

  String ?video;
  String ?videoLink;
  @override
  State<AdvertisingFullVideo> createState() => _AdvertisingFullVideoState();
}

class _AdvertisingFullVideoState extends State<AdvertisingFullVideo> {
  VideoPlayerController ?videoPlayerController;
  Future <void> ?intilize;
  @override
  void initState() {

    //////////////////////////////////
    videoPlayerController=VideoPlayerController.network(
        widget.video!
    );
    intilize=videoPlayerController!.initialize();
    videoPlayerController!.setLooping(true);
    videoPlayerController!.setVolume(1.0);    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdvertisingCubit , AdvertisingState>(
      listener: (context,state){

      },
      builder: (context , state){
        return Scaffold(
          backgroundColor:Colors.white,
          appBar: AppBar(
            systemOverlayStyle:  SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarColor: AppColors.primaryColor1,
            ),
            iconTheme: IconThemeData(
                color: AppColors.myWhite
            ),
            backgroundColor: AppColors.primaryColor1,
            title:Container(
              height: MediaQuery.of(context).size.height*02,
              width: MediaQuery.of(context).size.width*.4,
              child: Image(
                image: AssetImage('assets/images/appbarLogo.png'),

              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            actions: [
              IconButton(onPressed: (){}, constraints: BoxConstraints(),
                padding: EdgeInsets.only(right: 20),
                icon: ImageIcon(
                  AssetImage("assets/images/notification.png"),
                  color:AppColors.navBarActiveIcon,

                ),),

            ],
            leading: IconButton(
              onPressed: (){
                setState((){
                  videoPlayerController!.pause();
                });
                Navigator.pop(context);

              },
              icon: Icon(
                  Icons.arrow_back_ios
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 20,),

                Container(
                  height: MediaQuery.of(context).size.height*.6,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*.6,
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
                          right: 10,
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
                            child: videoPlayerController!.value.isPlaying?  CircleAvatar(radius: 15, child: Icon(Icons.pause,color: AppColors.primaryColor1,size: 15,)): CircleAvatar(radius: 15, child: Icon(Icons.play_arrow,color: AppColors.primaryColor1,size: 15,)),
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
