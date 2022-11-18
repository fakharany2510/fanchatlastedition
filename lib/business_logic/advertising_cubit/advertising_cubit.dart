// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'dart:io';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/advertising_cubit/advertising_state.dart';
import 'package:fanchat/data/modles/advertising_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AdvertisingCubit extends Cubit<AdvertisingState> {
  AdvertisingCubit() : super(InitialState());

  static AdvertisingCubit get(context) => BlocProvider.of(context);

  final manager = CacheManager(Config(
    'customCacheKey',
    stalePeriod: const Duration(days: 15),
    maxNrOfCacheObjects: 100,
  ));

  double? imageWidth;
  double? imageHeight;
  var picker = ImagePicker();
  VideoPlayerController? videoPlayerController;
  CachedVideoPlayerController? controller;

  File? postVideo;
  void pickPostVideo2() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postVideo = File(pickedFile.path);
      controller = CachedVideoPlayerController.file(postVideo!)
        ..initialize().then((value) {
          controller!.pause();

          emit(PickAdvertisingPostImageErrorState());
        }).catchError((error) {
          // print('error picking video ${error.toString()}');
        });
    }
  }

  //////////////////////////////fanarea///////////////////////////////
  //pick fan image post
  File? AdvertisingPostImage;
  Future<void> pickAdvertisingPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      AdvertisingPostImage = File(pickedFile.path);
      var decodedImage =
          await decodeImageFromList(AdvertisingPostImage!.readAsBytesSync());
      // print(decodedImage.width);
      // print(decodedImage.height);
      imageWidth = double.parse('${decodedImage.width}');
      imageHeight = double.parse('${decodedImage.height}');
      emit(PickAdvertisingPostImageSuccessState());
    } else {
      // print('no AdvertisingPostImage selected');
      emit(PickAdvertisingPostImageErrorState());
    }
  }

/////////////////////////////////////
//pick fan post video
  File? AdvertisingPostVideo;

  void pickAdvertisingPostVideo() async {
    final pickedFile = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      AdvertisingPostVideo = File(pickedFile.path);
      videoPlayerController = VideoPlayerController.file(AdvertisingPostVideo!)
        ..initialize().then((value) {
          videoPlayerController!.pause();
          emit(PickAdvertisingPostVideoSuccessState());
        }).catchError((error) {
          // print('error picking  Advertising video ${error.toString()}');
          emit(PickAdvertisingPostVideoErrorState());
        });
    }
  }
////////////////////////////////////////

  var advertingImageLink = TextEditingController();
  var advertingVideoLink = TextEditingController();

//Create fan Post
  void createAdvertisingImagePost({
    required String? dateTime,
    required String? time,
    required String? timeSpam,
    required String? text,
    String? advertisingImage,
    required String? postLink,
  }) {
    emit(AdvertisingCreatePostLoadingState());

    AdvertisingModel model = AdvertisingModel(
      dateTime: dateTime,
      time: time,
      postImage: advertisingImage ?? '',
      postVideo: "",
      timeSmap: timeSpam,
      advertisingLink: postLink,
    );

    FirebaseFirestore.instance
        .collection('advertising')
        .add(model.toMap())
        .then((value) {
      // print('Create Image Advertisnig');
      emit(AdvertisingCreatePostSuccessState());
    }).catchError((error) {
      emit(AdvertisingCreatePostErrorState());
    });
  }
  ///////////////////////////////////////////
//upload fan post image

  void uploadAdvertisingPostImage({
    required String? time,
    required String? dateTime,
    required String? text,
    required String? timeSpam,
    required String? advertisingLink,
  }) {
    emit(AdvertisingUploadImagePostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
        //كدا بقوله انا فين في الstorage
        .ref()
        //كدا بقةله هتحرك ازاي جوا ال storage
        //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child(
            'advertising/${Uri.file(AdvertisingPostImage!.path).pathSegments.last}')
        //كدا بعمل رفع للصوره
        .putFile(AdvertisingPostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createAdvertisingImagePost(
          dateTime: dateTime,
          advertisingImage: value,
          text: text,
          time: time,
          timeSpam: timeSpam,
          postLink: advertisingLink,
        );
        getAdvertisingPosts();
        emit(AdvertisingUploadImagePostSuccessState());
      }).catchError((error) {
        // print('error while get advertising post ${error.toString()}');
        emit(AdvertisingUploadImagePostErrorState());
      });
    }).catchError((error) {
      // print('error while get advertising post ${error.toString()}');
      emit(AdvertisingUploadImagePostErrorState());
    });
  }

//////////////////////////////////////////////
//Create fan videoPost
  void createAdvertisingVideoPost({
    required String dateTime,
    required String? text,
    required String time,
    required String? timeSpam,
    required String? advertisingLink,
    String? postVideo,
    String? advertiseThumbnail,
  }) {
    emit(FanCreateVideoPostLoadingState());

    AdvertisingModel model = AdvertisingModel(
        dateTime: dateTime,
        postImage: '',
        postVideo: postVideo ?? '',
        advertiseThumbnail: advertiseThumbnail ?? "",
        time: time,
        timeSmap: timeSpam,
        advertisingLink: advertisingLink);

    FirebaseFirestore.instance
        .collection('advertising')
        .add(model.toMap())
        .then((value) {
      //getPosts();
      // // print('Create Video Advertising');
      emit(AdvertisingCreateVideoPostSuccessState());
    }).catchError((error) {
      emit(AdvertisingCreateVideoPostErrorState());
    });
  }

///////////////////////////////////////////////
//upload fan post video to storage
  void uploadAdvertisngPostVideo({
    String? video,
    required String dateTime,
    required String time,
    required String timeSpam,
    required String? text,
    required String? advertisngLink,
  }) {
    emit(AdvertisingUploadVideoPostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
        //كدا بقوله انا فين في الstorage
        .ref()
        //كدا بقةله هتحرك ازاي جوا ال storage
        //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child(
            'advertising/${Uri.file(AdvertisingPostVideo!.path).pathSegments.last}')
        //كدا بعمل رفع للصوره
        .putFile(AdvertisingPostVideo!)
        .then((value1) {
      value1.ref.getDownloadURL().then((value2) async {
        var thumbTempPath = await VideoThumbnail.thumbnailFile(
            video: value2,
            thumbnailPath: (await getTemporaryDirectory()).path,
            imageFormat: ImageFormat.PNG,
            //  maxHeight:, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
            quality: 100, // you can change the thumbnail quality here
            timeMs: 2);
        int counter = 1;
        // print('mmjhwdvghvcjyscgfcvjshcgs------->${thumbTempPath}');
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child(
                'counter/$counter/${Uri.file(thumbTempPath!).pathSegments.last}')
            .putFile(File(thumbTempPath))
            .then((value3) {
          value3.ref.getDownloadURL().then((value4) {
            // print('mmmmmmmmmmmmmmmmmmmmmmmmm${value4}');
            // print('mmmmmmmmmmmmmmmmmmmmmmmmm${value2}');
            createAdvertisingVideoPost(
                dateTime: dateTime,
                postVideo: value2,
                text: text,
                time: time,
                timeSpam: timeSpam,
                advertisingLink: advertisngLink,
                advertiseThumbnail: value4);
            getAdvertisingPosts();
            emit(AdvertisingUploadVideoPostSuccessState());
          });
        });
      }).catchError((error) {
        emit(AdvertisingUploadVideoPostErrorState());
      });
    }).catchError((error) {
      emit(AdvertisingUploadVideoPostErrorState());
    });
  }
////////////////////////////////////////////////////

  //get Posts
  List<AdvertisingModel> advertising = [];
  void getAdvertisingPosts() {
    advertising = [];

    emit(BrowiseGetAdvertisingPostsLoadingState());
    FirebaseFirestore.instance
        .collection('advertising')
        .orderBy('timeSmap', descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        advertising.add(AdvertisingModel.formJson(element.data()));
        // Delete a record
        // await database?.rawDelete('DELETE * FROM Posts');
      });
      emit(BrowiseGetAdvertisingPostsSuccessState());
      // print('Siiiiiiiiiiiiiiiiiiiiiiiiii I Here');
    }).catchError((error) {
      emit(BrowiseGetAdvertisingPostsErrorState());
      // print('error while getting Fan posts ${error.toString()}');
    });
  }

  Future<void> toAdvertisingLink({
    required String advertisingLink,
  }) async {
    String url = advertisingLink;
    await launch(url, forceSafariVC: false);
    emit(LaunchAdvertisingImageSuccessState());
  }
}
