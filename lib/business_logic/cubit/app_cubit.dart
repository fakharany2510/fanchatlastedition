// ignore_for_file: deprecated_member_use, unused_element, avoid_function_literals_in_foreach_calls, unused_local_variable, non_constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/data/modles/cheering_model.dart';
import 'package:fanchat/data/modles/fan_model.dart';
import 'package:fanchat/data/modles/matches_model.dart';
import 'package:fanchat/data/modles/post_report.dart';
import 'package:fanchat/data/modles/profile_model.dart';
import 'package:fanchat/data/modles/public_chat_model.dart';
import 'package:fanchat/data/modles/teamchat.dart';
import 'package:fanchat/data/modles/user_report.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/user_model.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../data/modles/comment_model.dart';
import '../../data/modles/create_post_model.dart';
import '../../data/modles/message_model.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  TextEditingController changeUserNameController = TextEditingController();
  TextEditingController changeUserBioController = TextEditingController();
  TextEditingController changeUserPhoneController = TextEditingController();
  TextEditingController changeYoutubeLinkController = TextEditingController();
  TextEditingController changeFacebookLinkController = TextEditingController();
  TextEditingController changeTwitterLinkController = TextEditingController();
  TextEditingController changeInstagramLinkController = TextEditingController();

//caching manager
  final manager = CacheManager(Config(
    'customCacheKey',
    stalePeriod: const Duration(days: 15),
    maxNrOfCacheObjects: 100,
  ));

  List screensTitles = [
    'Home Screen',
    'Match Details',
    'Fan Area',
    'Chat Screen',
    'public chat',
    'More Screen',
  ];

  final List<String> groupsImages = [
    'https://img.freepik.com/premium-photo/flag-france_135932-1458.jpg?w=740',
    'https://img.freepik.com/free-vector/illustration-usa-flag_53876-18165.jpg?w=996&t=st=1658517048~exp=1658517648~hmac=cbe565f23062c2297398122d1ead56d1031b7e446121a0e059be5be3158769c1',
    'https://img.freepik.com/premium-photo/argentinian-flag-close-up-view_625455-806.jpg?w=740',
    'https://img.freepik.com/free-photo/flag-senegal_1401-216.jpg?w=740&t=st=1658517102~exp=1658517702~hmac=a88fc9ccc784e74dd5c943332ac630c1bc6f92a9b12b52508cadd9be633e91e5',
    'https://img.freepik.com/free-photo/flags-germany_1232-3061.jpg?w=740&t=st=1658517131~exp=1658517731~hmac=352aa05f783a371e423a860f42e468a9184cab9ceed0464b2057f9a87c918e83',
    'https://img.freepik.com/free-photo/spanish-flag-white_144627-24632.jpg?w=740&t=st=1658517149~exp=1658517749~hmac=732a5f5e8dd887cffca58dfff1f851995fe7aff724739594ae00244e8978d59d',
    'https://img.freepik.com/free-photo/beautiful-greek-flag_23-2149323079.jpg?w=740&t=st=1658517166~exp=1658517766~hmac=3810542fd47f4156cdf46be69b54ad40c0ce6b9e2e12d2ea8814e3911b40965d',
    'https://img.freepik.com/free-photo/closeup-shot-realistic-flag-cameroon-with-interesting-textures_181624-9536.jpg?w=900&t=st=1658516966~exp=1658517566~hmac=2c7791265b0bce21be9e81157202febf6b6a1fc85ac15774fc47fc8702e11144',
  ];

  List<String> nationalTitles = [
    'France',
    'USA',
    'Argentinian',
    'Senegal',
    'Germany',
    'Spanish',
    'Greek',
    'Cameroon',
  ];

  List carouselImage = [
    'https://mostaql.hsoubcdn.com/uploads/thumbnails/1014251/60c7b6a350d3d/%D8%A7%D9%84%D8%AA%D8%B5%D9%85%D9%8A%D9%85.jpg',
    'https://pbs.twimg.com/media/Bp_KtB2CQAAo2FG?format=jpg&name=900x900',
    'https://economickey.com/wp-content/uploads/2021/12/images-2021-12-09T123459.676.jpeg',
    'https://images.netdirector.co.uk/gforces-auto/image/upload/w_1349,h_450,q_auto,c_fill,f_auto,fl_lossy/auto-client/07057d0e6193c6b928e53a2ec37e91ef/mg_hs_cover.png'
  ];

  ScrollController publicChatController = ScrollController();

  ScrollController privateScrollController = ScrollController();

  int currentIndex = 0;
  void navigateScreen(int index, context) {
    currentIndex = index;
    if (currentIndex == 4) {
      if (AppCubit.get(context).publicChatController.hasClients) {
        AppCubit.get(context).publicChatController.animateTo(
            AppCubit.get(context).publicChatController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.linear);
        emit(UploadVideoPublicChatLoadingState());
      }

      Future.delayed(const Duration(milliseconds: 500), () {
        if (AppCubit.get(context).publicChatController.hasClients) {
          AppCubit.get(context).publicChatController.animateTo(
              AppCubit.get(context)
                  .publicChatController
                  .position
                  .maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear);
          emit(UploadProfileImageSuccessState());
        }
      });

      Future.delayed(const Duration(milliseconds: 1500), () {
        if (AppCubit.get(context).publicChatController.hasClients) {
          AppCubit.get(context).publicChatController.animateTo(
              AppCubit.get(context)
                  .publicChatController
                  .position
                  .maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear);
          emit(UploadProfileImageSuccessState());
        }
      });

      Future.delayed(const Duration(milliseconds: 2500), () {
        if (AppCubit.get(context).publicChatController.hasClients) {
          AppCubit.get(context).publicChatController.animateTo(
              AppCubit.get(context)
                  .publicChatController
                  .position
                  .maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear);
          emit(UploadProfileImageSuccessState());
        }
      });
    }
    if (currentIndex == 3) {
      getAllUsers();
      getLastUsers();
    }
    if (currentIndex == 2) {
      //getFanPosts();
    }
    if (currentIndex == 1) {
      //getFanPosts();
      AppCubit.get(context).isDay = List.generate(28, (index) => false);
      isDay.first = true;
      getAllMatches(doc: '20 Nov');
    }
    if (currentIndex == 0) {
      String getTimeDifferenceFromNow(DateTime dateTime) {
        Duration difference = DateTime.now().difference(dateTime);
        if (difference.inSeconds < 5) {
          return "Just now";
        } else if (difference.inMinutes < 1) {
          return "${difference.inSeconds}s ago";
        } else if (difference.inHours < 1) {
          return "${difference.inMinutes}m ago";
        } else if (difference.inHours < 24) {
          return "${difference.inHours}h ago";
        } else {
          return "${difference.inDays}d ago";
        }
      }
      // getPosts();
    }
    emit(NavigateScreenState());
  }

  List<bool> isLike = List.generate(30, (index) => false);

  List<bool> isLikeFan = List.generate(30, (index) => false);

  bool checkValue = false;

  bool postVideoPLay = false;

  void checkBox(value) {
    checkValue = value;
    emit(CheckBoxState());
  }

  List isDay = List.generate(28, (index) => false);

  void throwState() {
    emit(PauseVideoState());
  }

  UserModel? userModel;
  List<UserModel> users = [];
  //get all uers
  String profileId = '';
  String profileFace = '';
  String profileTwitter = '';
  String profileInstagram = '';
  String profileYoutube = '';
  Future<void> getAllUsers() async {
    users = [];
    emit(GetAllUsersDataLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != AppStrings.uId) {
          users.add(UserModel.formJson(element.data()));
        }

        if (profileId == element.data()['uId']) {
          profileFace = element.data()['facebookLink'];
          profileTwitter = element.data()['twitterLink'];
          profileYoutube = element.data()['youtubeLink'];
          profileInstagram = element.data()['instagramLink'];
        }
      });

      emit(GetAllUsersDataSuccessfulState());
    }).catchError((error) {
      emit(GetAllUsersDataErrorState());
      // print('error while getting all users ${error.toString()}');
    });
  }
  //get one user

  Future<void> getUser(context) async {
    if (AppStrings.uId != null) {
      emit(GetUserDataLoadingState());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(AppStrings.uId)
          .get()
          .then((value) async {
        userModel = UserModel.formJson(value.data()!);
        printMessage('${userModel!.email}');
        changeUserNameController.text = '${userModel!.username}';
        changeUserPhoneController.text = '${userModel!.phone}';
        changeUserBioController.text = '${userModel!.bio}';
        changeYoutubeLinkController.text = '${userModel!.youtubeLink}';
        changeInstagramLinkController.text = '${userModel!.instagramLink}';
        changeTwitterLinkController.text = '${userModel!.twitterLink}';
        changeFacebookLinkController.text = '${userModel!.facebookLink}';
        await getCountries();
        await getProfilePosts();
        await getPosts();
        await getAllUsers();
        await getFanPosts();
        await getUserIds();
        await periodic();
        await getLastUsers();
        await getUserIds();
        await getAllMatches(doc: '20 Nov');
        emit(GetUserDataSuccessfulState());
      }).catchError((error) {
        printMessage('Error in get user is ${error.toString()}');
        emit(GetUserDataErrorState());
      });
    }
  }

  Future<void> getUserWithId(
    context,
    String id,
  ) async {
    emit(GetUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
      // userModel = UserModel.formJson(value.data()!);
      // printMessage('${userModel!.email}');
      // changeUserNameController.text='${userModel!.username}';
      // changeUserPhoneController.text='${userModel!.phone}';
      // changeUserBioController.text='${userModel!.bio}';
      // changeYoutubeLinkController.text='${userModel!.youtubeLink}';
      // changeInstagramLinkController.text='${userModel!.instagramLink}';
      // changeTwitterLinkController.text='${userModel!.twitterLink}';
      // changeFacebookLinkController.text='${userModel!.facebookLink}';

      emit(GetUserDataSuccessfulState());
    }).catchError((error) {
      printMessage('Error in get user is ${error.toString()}');
      emit(GetUserDataErrorState());
    });
  }

  File? coverImage;

  ImageProvider cover = const AssetImage('assets/images/profile.png');

  var coverPicker = ImagePicker();

  Future<void> getCoverImage() async {
    final pickedFile = await coverPicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      cover = FileImage(coverImage!);
      // print('Path is ${pickedFile.path}');
      emit(UploadCoverImageSuccessState());
    } else {
      // print('No Image selected.');
      emit(UploadCoverImageErrorState());
    }
  }

  Future<void> getCoverImageFirstTime() async {
    final pickedFile = await coverPicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      cover = FileImage(coverImage!);
      // print('Path is ${pickedFile.path}');
      emit(UploadCoverImageSuccessState());
      emit(GetCoverImageFirstTimeSuccessState());
    } else {
      // print('No Image selected.');
      emit(UploadCoverImageErrorState());
    }
  }

  File? profileImage;

  ImageProvider profile = const AssetImage('assets/images/profile.png');

  var picker = ImagePicker();

  Future<void> getProfileImageFirstTime(context) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      profile = FileImage(profileImage!);
      // print('Path is ${pickedFile.path}');
      // Navigator.push(context, MaterialPageRoute(builder: (_){
      //   return EditImage();
      // }));
      emit(UploadProfileImageSuccessState());
      emit(GetProfileImageFirstTimeSuccessState());
    } else {
      // print('No Image selected.');
      emit(UploadProfileImageErrorState());
    }
  }

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      profile = FileImage(profileImage!);
      // print('Path is ${pickedFile.path}');
      emit(UploadProfileImageSuccessState());
    } else {
      // print('No Image selected.');
      emit(UploadProfileImageErrorState());
    }
  }

  String? profilePath;

  Future uploadUserImage({
    String? name,
    String? phone,
    String? bio,
    String? youtubeLink,
    String? facebookLink,
    String? instagramLink,
    String? twitterLink,
  }) {
    emit(GetProfileImageLoadingState());
    return firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        printMessage('Upload Success');
        profilePath = value;
        updateProfile(
            name: name,
            bio: bio,
            image: profilePath,
            facebookLink: facebookLink ?? 'Enter your facebook link',
            instagramLink: instagramLink ?? 'Enter your instagram link',
            twitterLink: twitterLink ?? 'Enter your twitter link',
            youtubeLink: youtubeLink ?? 'Enter your youtube link');
        emit(GetProfileImageSuccessState());
      }).catchError((error) {
        // print('Error in Upload profileImage ${error.toString()}');
        emit(GetProfileImageErrorState());
      });
    }).catchError((error) {
      // print('Error in Upload profileImage ${error.toString()}');
      emit(GetProfileImageErrorState());
    });
  }

  String? coverPath;
  Future uploadUserCover({
    String? name,
    String? bio,
    String? youtubeLink,
    String? facebookLink,
    String? instagramLink,
    String? twitterLink,
  }) {
    emit(GetCoverImageLoadingState());
    return firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        printMessage('Upload Success');
        coverPath = value;
        updateProfile(
            name: name,
            bio: bio,
            cover: coverPath,
            facebookLink: facebookLink ?? 'Enter your facebook link',
            instagramLink: instagramLink ?? 'Enter your instagram link',
            twitterLink: twitterLink ?? 'Enter your twitter link',
            youtubeLink: youtubeLink ?? 'Enter your youtube link');
        emit(GetCoverImageSuccessState());
      }).catchError((error) {
        // print('Error in Upload profileImage ${error.toString()}');
        emit(GetCoverImageErrorState());
      });
    }).catchError((error) {
      // print('Error in Upload profileImage ${error.toString()}');
      emit(GetCoverImageErrorState());
    });
  }

  Future updateProfile({
    context,
    String? image,
    String? cover,
    required String? name,
    required String? bio,
    required String? youtubeLink,
    required String? instagramLink,
    required String? twitterLink,
    required String? facebookLink,
  }) async {
    emit(UpdateUserLoadingState());

    UserModel model = UserModel(
        username: name,
        bio: bio,
        uId: AppStrings.uId,
        image: image ?? userModel!.image,
        cover: cover ?? userModel!.cover,
        facebookLink: facebookLink ?? 'Enter your facebook link',
        instagramLink: instagramLink ?? 'Enter your instagram link',
        twitterLink: twitterLink ?? 'Enter your twitter link',
        youtubeLink: youtubeLink ?? 'Enter your youtube link');
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .update(model.toMap())
        .then((value) {
      getUser(context);
      emit(UpdateUserSuccessState());
    }).catchError((error) {
      printMessage('Error in Update is ${error.toString()}');
      emit(UpdateUserErrorState());
    });
  }

  //-----------------------------------------------------------------
//create new post
//----
  //Any Image Picker
// Pick post image from camera
  Future<void> pickPostImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PickPostImageSuccessState());
    } else {
      // print('no postImage selected');
      emit(PickPostImageErrorState());
    }
  }
//-------------------------------------e;

  //-----------------------------------------------------------------
//create new post
//----
  //Any Image Picker
// Pick post image
  double? imageWidth;
  double? imageHeight;
  File? postImage;
  Future<void> pickPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      var decodedImage =
          await decodeImageFromList(postImage!.readAsBytesSync());
      // print(decodedImage.width);
      // print(decodedImage.height);
      imageWidth = double.parse('${decodedImage.width}');
      imageHeight = double.parse('${decodedImage.height}');
      emit(PickPostImageSuccessState());
    } else {
      // print('no postImage selected');
      emit(PickPostImageErrorState());
    }
  }
//-------------------------------------e;

  ///////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> pickPostCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      var decodedImage =
          await decodeImageFromList(postImage!.readAsBytesSync());
      // print(decodedImage.width);
      // print(decodedImage.height);
      imageWidth = double.parse('${decodedImage.width}');
      imageHeight = double.parse('${decodedImage.height}');
      emit(PickPostImageSuccessState());
    } else {
      // print('no postImage selected');
      emit(PickPostImageErrorState());
    }
  }

  //////////////////////////////////////////////////////
  File? chatImage;
  Future<void> pickChatImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      var decodedImage =
          await decodeImageFromList(chatImage!.readAsBytesSync());
      // print(decodedImage.width);
      // print(decodedImage.height);
      imageWidth = double.parse('${decodedImage.width}');
      imageHeight = double.parse('${decodedImage.height}');
      emit(PickChatImageSuccessState());
    } else {
      // print('no chatImage selected');
      emit(PickChatImageErrorState());
    }
  }

  //////////////////////////////////////////////
  Future<void> pickChatCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      var decodedImage =
          await decodeImageFromList(chatImage!.readAsBytesSync());
      // print(decodedImage.width);
      // print(decodedImage.height);
      imageWidth = double.parse('${decodedImage.width}');
      imageHeight = double.parse('${decodedImage.height}');
      emit(PickChatImageSuccessState());
    } else {
      // print('no chatImage selected');
      emit(PickChatImageErrorState());
    }
  }

  /////////////////////////////////////////////////////////////////////
  // change viseo upload
  bool videoButtonTapped = false;
  void isVideoButtonTapped() {
    videoButtonTapped = !videoButtonTapped;
    emit(ChangeTap());
  }

///////////////////////////////////////////////////////
  // Pick post video
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

          emit(PickPostVideoSuccessState());
        }).catchError((error) {
          // print('error picking video ${error.toString()}');
        });
    }
  }

  //////////////////////////////////////////////////////////////
  void pickPostVideoCamera2() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      postVideo = File(pickedFile.path);
      controller = CachedVideoPlayerController.file(postVideo!)
        ..initialize().then((value) {
          controller!.pause();

          emit(PickPostVideoSuccessState());
        }).catchError((error) {
          // print('error picking video ${error.toString()}');
        });
    }
  }

  //////////////////////////////////////////////////////
  File? postVideo3;
  void pickPostVideo3() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postVideo3 = File(pickedFile.path);
      // var decodedVideo = await decodeImageFromList(postVideo3!.readAsBytesSync());
      controller = CachedVideoPlayerController.file(postVideo3!)
        ..initialize().then((value) {
          controller!.pause();
          //  videoWidth3=double.parse('${decodedVideo.width}');
          // videoHeight3=double.parse('${decodedVideo.height}');
          emit(PickPrivateChatViedoSuccessState());
        }).catchError((error) {
          // print('error picking video ${error.toString()}');
        });
    }
  }

  //////////////////////////////////////////////////
  void pickPostVideoCameraPrivate3() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      postVideo3 = File(pickedFile.path);
      // var decodedVideo = await decodeImageFromList(postVideo3!.readAsBytesSync());
      controller = CachedVideoPlayerController.file(postVideo3!)
        ..initialize().then((value) {
          controller!.pause();
          //  videoWidth3=double.parse('${decodedVideo.width}');
          // videoHeight3=double.parse('${decodedVideo.height}');
          emit(PickPrivateChatViedoSuccessState());
        }).catchError((error) {
          // print('error picking video ${error.toString()}');
        });
    }
  }

/////////////////////////////////////////////////////
//   void pickPostVideo() async {
//     final pickedFile =
//     await picker.pickVideo(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       postVideo = File(pickedFile.path);
//       videoPlayerController = VideoPlayerController.file(postVideo!)
//         ..initialize().then((value) {
//           videoPlayerController!.play();
//           emit(PickPostVideoSuccessState());
//         }).catchError((error) {
// //           print('error picking video ${error.toString()}');
//         });
//     }
//   }
  ////////////////////////////////////////
  //format time
  String getTimeDifferenceFromNow(DateTime dateTime) {
    Duration difference = DateTime.now().toUtc().difference(dateTime);
    if (difference.inSeconds < 5) {
      return "Just now";
    } else if (difference.inMinutes < 1) {
      return "${difference.inSeconds}s ago";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }

///////////////////////////////////////////
//upload post image
  void uploadPostImage({
    String? userId,
    String? name,
    String? image,
    required String? time,
    required String? dateTime,
    required String? text,
    required String? timeSpam,
  }) {
    emit(BrowiseUploadImagePostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
        //كدا بقوله انا فين في الstorage
        .ref()
        //كدا بقةله هتحرك ازاي جوا ال storage
        //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        //كدا بعمل رفع للصوره
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createImagePost(
          dateTime: dateTime,
          postImage: value,
          text: text,
          time: time,
          timeSpam: timeSpam,
        );
        emit(BrowiseUploadImagePostSuccessState());
        getPosts();
      }).catchError((error) {
        emit(BrowiseUploadImagePostErrorState());
      });
    }).catchError((error) {
      emit(BrowiseUploadImagePostErrorState());
    });
  }

  //////////////////////////////////////////////
//Create Post
  void createImagePost({
    required String? dateTime,
    required String? time,
    required String? timeSpam,
    required String? text,
    String? postImage,
  }) {
    emit(BrowiseCreatePostLoadingState());

    BrowisePostModel model = BrowisePostModel(
      name: userModel!.username,
      image: userModel!.image,
      userId: userModel!.uId,
      dateTime: dateTime,
      time: time,
      postImage: postImage ?? '',
      postVideo: "",
      timeSmap: timeSpam,
      text: text,
      likes: 0,
      comments: 0,
      postId: AppStrings.postUid,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      printMessage(value.id);
      AppStrings.postUid = value.id;
      FirebaseFirestore.instance
          .collection('posts')
          .doc(AppStrings.postUid)
          .update({'postId': AppStrings.postUid}).then((value) {
        emit(BrowiseCreatePostSuccessState());
      });
      uploadPostImage(
        text: text,
        dateTime: time,
        time: time,
        timeSpam: time,
        image: postImage,
        name: userModel!.username,
        userId: userModel!.uId,
      );
      //  getPosts();
    }).catchError((error) {
      emit(BrowiseCreatePostErrorState());
    });
  }

/////////////////////////////////////////////////
//upload post video to storage
  BrowisePostModel? postModel;
  void uploadPostVideo({
    String? userId,
    String? name,
    String? video,
    required String dateTime,
    required String time,
    required String timeSpam,
    required String? text,
  }) {
    emit(BrowiseUploadVideoPostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
        //كدا بقوله انا فين في الstorage
        .ref()
        //كدا بقةله هتحرك ازاي جوا ال storage
        //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('posts/${Uri.file(postVideo!.path).pathSegments.last}')
        //كدا بعمل رفع للصوره

        .putFile(postVideo!)
        .then((value1) async {
      value1.ref.getDownloadURL().then((value2) async {
        var thumbTempPath = await VideoThumbnail.thumbnailFile(
            video: value2,
            thumbnailPath: (await getTemporaryDirectory()).path,
            imageFormat: ImageFormat.PNG,
            //  maxHeight:, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
            quality: 100, // you can change the thumbnail quality here
            timeMs: 2);
        int counter = 1;
        // print(';mmjhwdvghvcjyscgfcvjshcgs------->$thumbTempPath');
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child(
                'counter/$counter/${Uri.file(thumbTempPath!).pathSegments.last}')
            .putFile(File(thumbTempPath))
            .then((value3) {
          value3.ref.getDownloadURL().then((value4) {
            // print(';mmmmmmmmmmmmmmmmmmmmmmmmm$value4');
            // print(';mmmmmmmmmmmmmmmmmmmmmmmmm$value2');

            createVideoPost(
              dateTime: dateTime,
              postVideo: value2,
              text: text,
              time: time,
              timeSpam: timeSpam,
              thumbnail: value4,
            );
            getPosts();
            emit(BrowiseUploadVideoPostSuccessState());
            counter++;
            // print('sjkjjjjjhhhhhhhhhhhhh$counter');
          });
        });

        // final uint8list = await VideoThumbnail.thumbnailData(
        //   video: value,
        //   imageFormat: ImageFormat.JPEG,
        //   maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        //   quality: 25,
        // );
      }).catchError((error) {
        emit(BrowiseUploadVideoPostErrorState());
      });
    }).catchError((error) {
      emit(BrowiseUploadVideoPostErrorState());
    });
  }

  ////////////////////////////////////////////////////
//Create Post
  void createVideoPost(
      {required String dateTime,
      required String? text,
      required String time,
      required String? timeSpam,
      String? postVideo,
      String? thumbnail}) {
    emit(BrowiseCreateVideoPostLoadingState());

    BrowisePostModel model = BrowisePostModel(
        name: userModel!.username,
        image: userModel!.image,
        userId: userModel!.uId,
        dateTime: dateTime,
        postImage: '',
        postVideo: postVideo ?? '',
        thumbnail: thumbnail ?? "",
        time: time,
        text: text,
        timeSmap: timeSpam,
        likes: 0,
        comments: 0,
        postId: AppStrings.postUid);

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      //getPosts();
      AppStrings.postUid = value.id;
      FirebaseFirestore.instance
          .collection('posts')
          .doc(AppStrings.postUid)
          .update({'postId': AppStrings.postUid}).then((value) {
        emit(BrowiseCreateVideoPostSuccessState());
      });
      emit(BrowiseCreateVideoPostSuccessState());
    }).catchError((error) {
      emit(BrowiseCreateVideoPostErrorState());
    });
  }

  ///////////////////////////////////////////////
  //create text post
  void createTextPost({
    required String? dateTime,
    required String? text,
    required String? time,
    required String? timeSpam,
  }) {
    emit(BrowiseCreateTextPostLoadingState());

    BrowisePostModel model = BrowisePostModel(
        name: userModel!.username,
        image: userModel!.image,
        userId: userModel!.uId,
        dateTime: dateTime,
        postImage: '',
        postVideo: '',
        text: text,
        time: time,
        timeSmap: timeSpam,
        likes: 0,
        comments: 0,
        postId: AppStrings.postUid);

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      AppStrings.postUid = value.id;
      FirebaseFirestore.instance
          .collection('posts')
          .doc(AppStrings.postUid)
          .update({'postId': AppStrings.postUid}).then((value) {
        emit(BrowiseCreateTextPostSuccessState());
      });
      getPosts();
    }).catchError((error) {
      emit(BrowiseCreateTextPostErrorState());
    });
  }

  ////////////////////////////////
//upload post text
  void uploadText({
    String? userId,
    String? name,
    String? image,
    required String? dateTime,
    required String? time,
    required String? text,
    required String? timeSpam,
  }) {
    emit(BrowiseUploadImagePostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
        //كدا بقوله انا فين في الstorage
        .ref()
        //كدا بقةله هتحرك ازاي جوا ال storage
        //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('posts')
        //كدا بعمل رفع للصوره
        .putString(text!)
        .then((value) {
      createImagePost(
          dateTime: dateTime, text: text, time: time, timeSpam: timeSpam);
      getPosts();
      emit(BrowiseUploadTextPostSuccessState());
    }).catchError((error) {
      emit(BrowiseUploadTextPostErrorState());
    });
  }

//////////////////////////////////////////////
  /////////////////////////
  //get Posts
  List<BrowisePostModel> posts = [];
  List<BrowisePostModel> postThumbnail = [];
  List<String> postsId = [];
  List<String> myPostsId = [];
  List<int> likes = [];

  Future<void> getPosts() async {
    posts = [];
    postsId = [];
    likes = [];
    emit(BrowiseGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('timeSmap', descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        posts.add(BrowisePostModel.fromJson(element.data()));
        if (userModel!.uId ==
            BrowisePostModel.fromJson(element.data()).userId) {
          myPostsId.add(BrowisePostModel.fromJson(element.data()).postId!);
        }
      });

      for (var element in myPostsId) {
        FirebaseFirestore.instance.collection('posts').doc(element).update({
          'image': userModel!.image,
          'name': userModel!.username
        }).then((value) {});
      }
      emit(BrowiseGetPostsSuccessState());
    }).catchError((error) {
      emit(BrowiseGetPostsErrorState());
      // print('error while getting posts ${error.toString()}');
    });
  }
  /////////////////////////////////////////////////
  //post likes

//
  void likePosts(String postId, int Likes) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'likes': true,
    }).then((value) {
      // testLikes();
      emit(CreateLikesSuccessState());
      testLikes(postId, Likes);
    }).catchError((error) {
      emit(CreateLikesErrorState());
    });
  }

  /////////////////////////////////////////////////////////
// Create Comment
  /////////////////////////////////////
  List<int> commentIndex = [];
  List<CommentModel> comments = [];
  void commentHomePost(String postId, String comment) {
    CommentModel model = CommentModel(
        username: userModel!.username,
        userImage: userModel!.image!,
        userId: userModel!.uId,
        comment: comment,
        date: DateTime.now().toString());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      // print('Comment Add');
      // getComment(postId);
      // testComments(postId);
      // commentIndex.length++;
      emit(CreateCommentsSuccessState());
    }).catchError((error) {
      // print('Error When set comment in home : ${error.toString()}');
      emit(CreateCommentsErrorState());
    });
  }

/////////////////////////////////////////
  //get comments
  void getComment(String postId) {
    comments = [];
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('date', descending: true)
        .get()
        .then((value) {
      // print('Get Comments Success');
      comments = [];
      value.docs.forEach((element) {
        comments.add(CommentModel.fromFire(element.data()));
      });
      emit(GetCommentsSuccessState());
    }).catchError((error) {
      // print('Error When set comment in home : ${error.toString()}');
      emit(GetCommentsErrorState());
    });
  }
  //////////////////////////////////////////////////////////
// get likes number
  /////////////////////////////////////

  void testLikes(postId, int Likes) {
    // posts=[];
    postsId = [];
    likes = [];
    FirebaseFirestore.instance.collection('posts').snapshots().listen((event) {
      event.docs.forEach((element) {
        element.reference.collection('likes').snapshots().listen((event) {
          // postsId.add(element.id);
          if (postId == element.id) {
            Likes = event.docs.length;
            FirebaseFirestore.instance
                .collection('posts')
                .doc(postId)
                .update({'likes': Likes}).then((value) {
              // print(Likes);
              // print(event.docs.length);
              // print('Siiiiiiiiiiiiiiiiiiiiiiii');
              printMessage('postId is $postId');
              // print('Siiiiiiiiiiiiiiiiiiiiiiii');
              printMessage('elementId is ${element.id}');

              emit(TestLikesSuccessState());
            });
          }
          likes.add(event.docs.length);
          emit(TestLikesSuccessState());
        });
      });
    });
  }

  Color? iconColor = Colors.grey;

  void changeIconColor() {
    iconColor = Colors.blue;
    emit(ChangeColorSuccessState());
  }

  void returnIconColor() {
    iconColor = Colors.grey;
    emit(ChangeColorSuccessState());
  }

//
//   // //get comments number
//   // /////////////////////////
  List<int> commentNum = [];
  int? Comments = 0;
  void testComments(postId) {
    // posts=[];
    postsId = [];
    commentNum = [];
    FirebaseFirestore.instance.collection('posts').snapshots().listen((event) {
      event.docs.forEach((element) {
        element.reference.collection('comments').snapshots().listen((event) {
          event.docs.forEach((element1) {
            // postsId.add(element.id);
            // print(event.docs.length);
            // print(Comments);
            // print('Siiiiiiiiiiiiiiiiiiiiiiii');
            printMessage('postId is $postId');
            // print('Siiiiiiiiiiiiiiiiiiiiiiii');
            printMessage('elementId is ${element.id}');
            if (postId == element.id) {
              // print('hhhhhhhhhhhhhhhhhhhh');
              Comments = event.docs.length;
              // print(Comments);
              // print(event.docs.length);
              FirebaseFirestore.instance
                  .collection('posts')
                  .doc(postId)
                  .update({'comments': Comments}).then((value) {
                // print(Comments);
                // print(event.docs.length);
                // print('Siiiiiiiiiiiiiiiiiiiiiiii');
                printMessage('postId is $postId');
                // print('Siiiiiiiiiiiiiiiiiiiiiiii');
                printMessage('elementId is ${element.id}');

                emit(TestCommentsSuccessState());
              });
            }
            commentNum.add(event.docs.length);
            emit(TestCommentsSuccessState());
          });
        });
      });
    });
  }

  ////////////////////////////////////////////
  //sign out
  ///////////////////////////////////////////
  Future<void> signOut() async {
    CashHelper.removeData(key: 'uid').then((value) async {
      await FirebaseAuth.instance.signOut();
    });

    emit(SignoutSuccessState());
  }

///////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  void createImageMessage({
    required String recevierId,
    required String recevierName,
    required String recevierImage,
    required String dateTime,
    String? messageImage,
    String? senderId,
  }) {
    emit(CreateImagePrivateLoadingState());
    MessageModel model = MessageModel(
        image: messageImage,
        text: "",
        dateTime: dateTime,
        recevierId: recevierId,
        recevierName: recevierName,
        recevierImage: recevierImage,
        senderId: AppStrings.uId);

    MessageModel myModel = MessageModel(
        image: messageImage,
        text: "",
        dateTime: dateTime,
        recevierId: userModel!.uId,
        recevierName: userModel!.username,
        recevierImage: userModel!.image,
        senderId: recevierId);

    //Set My Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .doc(recevierId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(CreateImagePrivateSuccessState());
    }).catchError((error) {
      emit(CreateImagePrivateErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .doc(recevierId)
        .set(model.toMap())
        .then((value) {
      emit(CreateImagePrivateSuccessState());
    }).catchError((error) {
      emit(CreateImagePrivateErrorState());
    });
    //Set Reciever Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(recevierId)
        .collection('chats')
        .doc(AppStrings.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(CreateImagePrivateSuccessState());
    }).catchError((error) {
      emit(CreateImagePrivateErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(recevierId)
        .collection('chats')
        .doc(AppStrings.uId)
        .set(myModel.toMap())
        .then((value) {
      emit(CreateImagePrivateSuccessState());
    }).catchError((error) {
      emit(CreateImagePrivateErrorState());
    });
  }

//////////////////////////////////////////
  void uploadMessageImage(
      {required String recevierId,
      required String recevierName,
      required String recevierImage,
      required String dateTime,
      required String text,
      required String senderId}) {
    emit(UploadImagePrivateLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
        //كدا بقوله انا فين في الstorage
        .ref()
        //كدا بقةله هتحرك ازاي جوا ال storage
        //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('MessageImages/${Uri.file(chatImage!.path).pathSegments.last}')
        //كدا بعمل رفع للصوره
        .putFile(chatImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createImageMessage(
            messageImage: value,
            recevierId: recevierId,
            recevierName: recevierName,
            recevierImage: recevierImage,
            dateTime: dateTime,
            senderId: AppStrings.uId);

        emit(UploadImagePrivateSuccessState());
      }).catchError((error) {
        emit(UploadImagePrivateErrorState());
      });
    }).catchError((error) {
      emit(UploadImagePrivateErrorState());
    });
  }
  ///////////////////////////////////messages////////////////////////////
//send Messages

  void sendMessage({
    required String recevierId,
    required String recevierName,
    required String recevierImage,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        recevierId: recevierId,
        senderId: AppStrings.uId,
        dateTime: dateTime,
        text: text,
        recevierImage: recevierImage,
        recevierName: recevierName);

    MessageModel myModel = MessageModel(
        recevierId: AppStrings.uId,
        senderId: recevierId,
        dateTime: dateTime,
        text: text,
        recevierImage: userModel!.image,
        recevierName: userModel!.username);
    //Set My Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .doc(recevierId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    //last user
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .doc(recevierId)
        .set(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    //Set Reciever Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(recevierId)
        .collection('chats')
        .doc(AppStrings.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    //last user
    FirebaseFirestore.instance
        .collection('users')
        .doc(recevierId)
        .collection('chats')
        .doc(AppStrings.uId)
        .set(myModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  ////////////////////////
//get messages
  List<MessageModel> messages = [];
  void getMessages({
    required String recevierId,
  }) {
    messages = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .doc(recevierId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add((MessageModel.fromJson(element.data())));
      });
      emit(GetMessageSuccessState());
    });
  }

  List lastUsers = [];
  Future<void> getLastUsers() async {
    lastUsers = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      lastUsers = [];
      event.docs.forEach((element) {
        lastUsers.add((element.data()));
        // print('llllllllll');
      });
      emit(GetMessageSuccessState());
    });
  }

  ///////////////////////
  bool isWritingMessage = false;
  void changeIcon() {
    isWritingMessage != isWritingMessage;
    emit(ChangeIconSuccessState());
  }

  bool isSend = false;
  ///////////////////////////////voice message
  void createVoiceMessage({
    required String recevierId,
    required String recevierName,
    required String recevierImage,
    required String dateTime,
    required String voice,
  }) {
    emit(StopLoadingState());

    MessageModel model = MessageModel(
        text: "",
        dateTime: dateTime,
        recevierId: recevierId,
        recevierName: recevierName,
        recevierImage: recevierImage,
        senderId: AppStrings.uId,
        voice: voice);

    MessageModel myModel = MessageModel(
        text: "",
        dateTime: dateTime,
        recevierId: userModel!.uId,
        recevierName: userModel!.username,
        recevierImage: userModel!.image,
        senderId: recevierId,
        voice: voice);
    emit(StopLoadingState());
    //Set My Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .doc(recevierId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(StopLoadingState());
      isSend = false;
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
      // print(error.toString());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .doc(recevierId)
        .set(model.toMap())
        .then((value) {
      emit(StopLoadingState());
      isSend = false;
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
      // print(error.toString());
    });

    //Set Reciever Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(recevierId)
        .collection('chats')
        .doc(AppStrings.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
      // print(error.toString());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(recevierId)
        .collection('chats')
        .doc(AppStrings.uId)
        .set(myModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
      // print(error.toString());
    });
  }

  //////////////////////////////fanarea///////////////////////////////
  //pick fan image post
  File? fanPostImage;
  Future<void> pickFanPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      fanPostImage = File(pickedFile.path);
      var decodedImage =
          await decodeImageFromList(fanPostImage!.readAsBytesSync());
      // print(decodedImage.width);
      // print(decodedImage.height);
      imageWidth = double.parse('${decodedImage.width}');
      imageHeight = double.parse('${decodedImage.height}');
      emit(PickFanPostImageSuccessState());
    } else {
      // print('no fanPostImage selected');
      emit(PickFanPostImageErrorState());
    }
  }

/////////////////////////////////////
//pick fan post video
  File? fanPostVideo;
  void pickFanPostVideo() async {
    final pickedFile = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      fanPostVideo = File(pickedFile.path);
      videoPlayerController = VideoPlayerController.file(fanPostVideo!);
      await videoPlayerController!.initialize().then((value) {
        videoPlayerController!.pause();
        emit(PickFanPostVideoSuccessState());
      }).catchError((error) {
        // print('error picking  fan video ${error.toString()}');
        emit(PickFanPostVideoErrorState());
      });
    }
  }

////////////////////////////////////////
//Create fan Post
  void createFanImagePost({
    required String? dateTime,
    required String? time,
    required String? timeSpam,
    required String? text,
    String? postImage,
  }) {
    emit(FanCreatePostLoadingState());

    FanModel model = FanModel(
      name: userModel!.username,
      image: userModel!.image,
      userId: userModel!.uId,
      dateTime: dateTime,
      time: time,
      postImage: postImage ?? '',
      postVideo: "",
      timeSmap: timeSpam,
      likes: 0,
      postId: AppStrings.postUid,
    );

    FirebaseFirestore.instance
        .collection('fan')
        .add(model.toMap())
        .then((value) {
      printMessage(value.id);
      AppStrings.postUid = value.id;
      FirebaseFirestore.instance
          .collection('fan')
          .doc(AppStrings.postUid)
          .update({'postId': AppStrings.postUid}).then((value) {
        emit(FanCreatePostSuccessState());
      });
      //  getPosts();
      emit(FanCreatePostSuccessState());
    }).catchError((error) {
      emit(FanCreatePostErrorState());
    });
  }

  ///////////////////////////////////////////
//upload fan post image
  void uploadFanPostImage({
    String? userId,
    String? name,
    String? image,
    required String? time,
    required String? dateTime,
    required String? text,
    required String? timeSpam,
  }) {
    emit(FanUploadImagePostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
        //كدا بقوله انا فين في الstorage
        .ref()
        //كدا بقةله هتحرك ازاي جوا ال storage
        //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('fan/${Uri.file(fanPostImage!.path).pathSegments.last}')
        //كدا بعمل رفع للصوره
        .putFile(fanPostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createFanImagePost(
          dateTime: dateTime,
          postImage: value,
          text: text,
          time: time,
          timeSpam: timeSpam,
        );
        getFanPosts();
        // print(fans[1].postImage);
        emit(FanUploadImagePostSuccessState());
      }).catchError((error) {
        // print('error while get fan post ${error.toString()}');
        emit(FanUploadImagePostErrorState());
      });
    }).catchError((error) {
      // print('error while get fan post ${error.toString()}');
      emit(FanUploadImagePostErrorState());
    });
  }

//////////////////////////////////////////////
//Create fan videoPost
  void createFanVideoPost({
    required String dateTime,
    required String? text,
    required String time,
    required String? timeSpam,
    String? thumbnailFanPost,
    String? postVideo,
  }) {
    emit(FanCreateVideoPostLoadingState());

    FanModel model = FanModel(
        name: userModel!.username,
        image: userModel!.image,
        userId: userModel!.uId,
        dateTime: dateTime,
        postImage: '',
        thumbnailFanPosts: thumbnailFanPost ?? "",
        postVideo: postVideo ??
            'https://firebasestorage.googleapis.com/v0/b/fanchat-7db9e.appspot.com/o/fanvideo%2F2022-10-27%2012%3A18%3A53.634007%2FVRQI86oYZSZgh7Mh3xXqQDX9dxR2?alt=media&token=2c4850fd-e48f-4b7d-a90f-9eff05450531',
        time: time,
        timeSmap: timeSpam,
        likes: 0,
        postId: AppStrings.postUid);

    FirebaseFirestore.instance
        .collection('fan')
        .add(model.toMap())
        .then((value) {
      //getPosts();
      AppStrings.postUid = value.id;
      FirebaseFirestore.instance
          .collection('fan')
          .doc(AppStrings.postUid)
          .update({'postId': AppStrings.postUid}).then((value) {
        // emit(FanCreateVideoPostSuccessState());
      });
      emit(FanCreateVideoPostSuccessState());
    }).catchError((error) {
      emit(FanCreateVideoPostErrorState());
    });
  }

///////////////////////////////////////////////
//upload fan post video to storage
  firebase_storage.SettableMetadata metadata =
      firebase_storage.SettableMetadata(contentType: 'video/mp4');
  Future uploadFanPostVideo({
    String? userId,
    String? name,
    String? video,
    required String dateTime,
    required String time,
    required String timeSpam,
    required String? text,
  }) async {
    try {
      emit(FanUploadVideoPostLoadingState());
      // print('1');
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("fanvideo")
          .child(timeSpam)
          .child('${AppStrings.uId}');
      // print('2');
      firebase_storage.UploadTask uploadTask = ref.putFile(
          fanPostVideo!, metadata); //<- this content type does the trick
      // print('3');

      uploadTask.then((res) async {
        Uri downloadUrl = Uri.parse(await res.ref.getDownloadURL());
        ///////////////////////////////////////////////////////////
        var thumbTempPath = await VideoThumbnail.thumbnailFile(
            video: '$downloadUrl',
            thumbnailPath: (await getTemporaryDirectory()).path,
            imageFormat: ImageFormat.PNG,
            //  maxHeight:, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
            quality: 100, // you can change the thumbnail quality here
            timeMs: 2);
        int counter = 1;
        // print(';mmjhwdvghvcjyscgfcvjshcgs------->$thumbTempPath');
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child(
                'counter/$counter/${Uri.file(thumbTempPath!).pathSegments.last}')
            .putFile(File(thumbTempPath))
            .then((value3) {
          value3.ref.getDownloadURL().then((value4) {
            createFanVideoPost(
              dateTime: dateTime,
              postVideo: '$downloadUrl',
              text: text,
              time: time,
              timeSpam: timeSpam,
              thumbnailFanPost: value4,
            );
            emit(FanUploadVideoPostSuccessState());
            videoPlayerController!.dispose();
          });
        });
      }).catchError((error) {
        emit(FanUploadVideoPostErrorState());
        videoPlayerController!.dispose();
        // print(error);
      });
      // Uri downloadUrl = (await uploadTask).downloadUrl;
      // print('4');

      //final String url = downloadUrl.toString();

      // print(url);
      //
    } catch (error) {
      // print('error while uploading video $error');
    }
  }

  List<FanModel> fans = [];
  Future<void> getFanPosts() async {
    fans = [];
    postsId = [];
    likes = [];
    emit(BrowiseGetFanPostsLoadingState());
    await FirebaseFirestore.instance
        .collection('fan')
        .orderBy('timeSmap', descending: true)
        .get()
        .then((value) {
      fans = [];
      value.docs.forEach((element) async {
        fans.add(FanModel.fromJson(element.data()));
        // print('============== link fan ==========');
        // print(element.data()['postVideo']);
        // print('============== link fan ==========');

        // Delete a record
        // await database?.rawDelete('DELETE * FROM Posts');
        emit(BrowiseGetFanPostsSuccessState());
      });
    }).catchError((error) {
      emit(BrowiseGetFanPostsErrorState());
      // print('error while getting Fan posts ${error.toString()}');
    });
  }
////// Public Chat ////////////////////////////////////////

  void createImagePublicChat({
    required String dateTime,
    String? messageImage,
    String? senderId,
    String? senderName,
    String? senderImage,
  }) {
    emit(BrowiseCreatePostLoadingState());
    PublicChatModel model = PublicChatModel(
      image: messageImage,
      text: "",
      dateTime: dateTime,
      senderId: AppStrings.uId,
      senderName: senderName,
      senderImage: senderImage,
    );

    //Set My Chat
    FirebaseFirestore.instance
        .collection('publicChat')
        .add(model.toMap())
        .then((value) {
      // print('createImagePublicChat success');
      emit(SendPublicChatSuccessState());
    }).catchError((error) {
      // print('Error is ${error.toString()}');
      emit(SendPublicChatErrorState());
    });
  }
//////////////////////////////////////////

  void uploadPublicChatImage({
    required String dateTime,
    required String text,
    required String senderId,
    required String senderName,
    required String senderImage,
  }) {
    emit(BrowiseUploadImagePostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
        //كدا بقوله انا فين في الstorage
        .ref()
        //كدا بقةله هتحرك ازاي جوا ال storage
        //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child(
            'PublicChatImages/${Uri.file(postImage!.path).pathSegments.last}')
        //كدا بعمل رفع للصوره
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createImagePublicChat(
          messageImage: value,
          dateTime: dateTime,
          senderId: AppStrings.uId,
          senderName: userModel!.username,
          senderImage: userModel!.image,
        );

        emit(BrowiseUploadImagePostSuccessState());
      }).catchError((error) {
        emit(BrowiseUploadImagePostErrorState());
      });
    }).catchError((error) {
      emit(BrowiseUploadImagePostErrorState());
    });
  }
  ///////////////////////////////////messages////////////////////////////
//send Messages

  void sendPublicChat({
    required String dateTime,
    required String text,
  }) {
    PublicChatModel model = PublicChatModel(
        senderId: AppStrings.uId,
        dateTime: dateTime,
        text: text,
        senderName: userModel!.username,
        senderImage: userModel!.image);
    //Set My Chat
    FirebaseFirestore.instance
        .collection('publicChat')
        .add(model.toMap())
        .then((value) {
      // print(isSend);
      emit(SendPublicChatSuccessState());
    }).catchError((error) {
      emit(SendPublicChatErrorState());
    });
  }

  ////////////////////////
//get messages
  List<PublicChatModel> publicChat = [];
  void getPublicChat() {
    FirebaseFirestore.instance
        .collection('publicChat')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      publicChat = [];
      event.docs.forEach((element) {
        publicChat.add((PublicChatModel.fromJson(element.data())));
        // print('llllllllll');
        // print(publicChat[0].voice);
      });
      emit(GetPublicChatSuccessState());
    });
  }

  bool isWritingPublicChat = false;
  void changeIconPublicChat() {
    isWritingPublicChat != isWritingPublicChat;
    emit(ChangeIconPublicChatSuccessState());
  }

  ///////////////////////////////voice message
  void createVoicePublicChat({
    required String dateTime,
    required String voice,
  }) {
    PublicChatModel model = PublicChatModel(
        text: "",
        dateTime: dateTime,
        senderId: AppStrings.uId,
        senderImage: userModel!.image,
        senderName: userModel!.username,
        voice: voice);

    //Set My Chat
    FirebaseFirestore.instance
        .collection('publicChat')
        .add(model.toMap())
        .then((value) {
      isSend = false;

      emit(SendPublicChatSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(SendPublicChatErrorState());
    });
  }
  ///////////////////////////////////////////////////////

////// Team Chat ////////////////////////////////////////

  void createImageTeamChat({
    required String dateTime,
    String? countryName,
    String? messageImage,
    String? senderId,
    String? senderName,
    String? senderImage,
  }) {
    emit(BrowiseCreatePostLoadingState());
    PublicChatModel model = PublicChatModel(
      image: messageImage,
      text: "",
      dateTime: dateTime,
      senderId: AppStrings.uId,
      senderName: senderName,
      senderImage: senderImage,
    );

    //Set My Chat
    FirebaseFirestore.instance
        .collection('$countryName')
        .add(model.toMap())
        .then((value) {
      // print('createImagePublicChat success');
      emit(SendTeamChatSuccessState());
    }).catchError((error) {
      // print('Error is ${error.toString()}');
      emit(SendTeamChatErrorState());
    });
  }
//////////////////////////////////////////

  void uploadTeamChatImage({
    required String dateTime,
    required String text,
    required String senderId,
    required String senderName,
    required String senderImage,
    required String countryName,
  }) {
    emit(BrowiseUploadImagePostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
        //كدا بقوله انا فين في الstorage
        .ref()
        //كدا بقةله هتحرك ازاي جوا ال storage
        //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('TeamChatImages/${Uri.file(postImage!.path).pathSegments.last}')
        //كدا بعمل رفع للصوره
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createImageTeamChat(
            messageImage: value,
            dateTime: dateTime,
            senderId: AppStrings.uId,
            senderName: userModel!.username,
            senderImage: userModel!.image,
            countryName: countryName);

        emit(BrowiseUploadImagePostSuccessState());
      }).catchError((error) {
        emit(BrowiseUploadImagePostErrorState());
      });
    }).catchError((error) {
      emit(BrowiseUploadImagePostErrorState());
    });
  }
  ///////////////////////////////////messages////////////////////////////
//send Messages

  void sendTeamChat({
    required String dateTime,
    required String text,
    required String countryName,
  }) {
    PublicChatModel model = PublicChatModel(
        senderId: AppStrings.uId,
        dateTime: dateTime,
        text: text,
        senderName: userModel!.username,
        senderImage: userModel!.image);
    //Set My Chat
    FirebaseFirestore.instance
        .collection(countryName)
        .add(model.toMap())
        .then((value) {
      // print(isSend);
      emit(SendTeamChatSuccessState());
    }).catchError((error) {
      emit(SendTeamChatErrorState());
    });
  }

  ////////////////////////
//get messages
  List<TeamChatModel> teamChat = [];
  void getTeamChat(String countryName) {
    teamChat = [];
    FirebaseFirestore.instance
        .collection(countryName)
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      teamChat = [];
      event.docs.forEach((element) {
        teamChat.add((TeamChatModel.fromJson(element.data())));
        // print('llllllllll');
        // print(teamChat[0].voice);
      });
      emit(GetTeamChatSuccessState());
    });
  }

  bool isWritingTeamChat = false;
  void changeIconTeamChat() {
    isWritingTeamChat != isWritingTeamChat;
    emit(ChangeIconTeamChatSuccessState());
  }

  ///////////////////////////////voice message
  void createVoiceTeamChat({
    required String dateTime,
    required String voice,
    required String countryName,
  }) {
    PublicChatModel model = PublicChatModel(
        text: "",
        dateTime: dateTime,
        senderId: AppStrings.uId,
        senderImage: userModel!.image,
        senderName: userModel!.username,
        voice: voice);

    //Set My Chat
    FirebaseFirestore.instance
        .collection(countryName)
        .add(model.toMap())
        .then((value) {
      isSend = false;

      emit(SendTeamChatSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(SendTeamChatErrorState());
    });
  }
///////////////////////////////////////////////////////

///////////////////////// Fan Likes

  List<int> fanLikes = [];
  List<String> fanId = [];

  void likeFans(String fanId, int Likes) {
    FirebaseFirestore.instance
        .collection('fan')
        .doc(fanId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'likes': true,
    }).then((value) {
      emit(CreateFanLikesSuccessState());
      testFanLikes(fanId, Likes);
    }).catchError((error) {
      emit(CreateFanLikesErrorState());
    });
  }

  void testFanLikes(fanId, int Likes) {
    // posts=[];
    fanId = [];
    fanLikes = [];
    FirebaseFirestore.instance.collection('fan').snapshots().listen((event) {
      event.docs.forEach((element) {
        element.reference.collection('likes').snapshots().listen((event) {
          // postsId.add(element.id);
          if (fanId == element.id) {
            Likes = event.docs.length;
            FirebaseFirestore.instance
                .collection('fan')
                .doc(fanId)
                .update({'likes': Likes}).then((value) {
              // print(Likes);
              // print(event.docs.length);
              // print('Siiiiiiiiiiiiiiiiiiiiiiii');
              printMessage('postId is $fanId');
              // print('Siiiiiiiiiiiiiiiiiiiiiiii');
              printMessage('elementId is ${element.id}');

              emit(TestLikesSuccessState());
            });
          }
          likes.add(event.docs.length);
          emit(TestFanLikesSuccessState());
        });
      });
    });
  }

  //Create Cheering
  Future<void> createCheeringPost({
    required String? time,
    required String? countryName,
    required String? timeSpam,
    required String? text,
  }) async {
    CheeringModel model = CheeringModel(
        time: time,
        timeSpam: timeSpam,
        uId: userModel!.uId,
        username: userModel!.username,
        userImage: userModel!.image,
        text: text);

    emit(CreateCheeringLoadingState());

    FirebaseFirestore.instance
        .collection('$countryName')
        .doc('1')
        .collection('cheering')
        .add(model.toMap())
        .then((value) {
      // getCheeringPost();
      // isLast=false;

      // print('Upload Cheering message');
      emit(CreateCheeringSuccessState());
    }).catchError((error) {
      emit(CreateCheeringErrorState());
    });
  }

  bool isWaiting = false;

  void getWaitingCheering({
    required String? countryName,
  }) {
    FirebaseFirestore.instance
        .collection('watingCheering')
        .doc('$countryName')
        .collection('$countryName')
        .doc('1')
        .get()
        .then((value) {
      isWaiting = value['isWaiting'];
      // print(isWaiting);
      emit(GetWaitingSuccessState());
    });
  }

  void updateWaitingCheering({
    required String? countryName,
  }) {
    FirebaseFirestore.instance
        .collection('watingCheering')
        .doc('$countryName')
        .collection('$countryName')
        .doc('1')
        .update({'isWaiting': isWaiting}).then((value) {
      // print('uPDATE Waiting success');
      emit(UpdateWaitingSuccessState());
    }).catchError((error) {
      // print('${error.toString()}');
      emit(UpdateWaitingSuccessState());
    });
  }

  bool isLast = true;
  int count = 15;

  List<CheeringModel> cheering = [];

  List<CheeringModel> waitingList = [];

  int indexCheeringList = 0;
  Future<void> getCheeringPost({
    required String? countryName,
  }) async {
    FirebaseFirestore.instance
        .collection('$countryName')
        .doc('1')
        .collection('cheering')
        .orderBy('timeSpam', descending: true)
        .snapshots()
        .listen((event) {
      cheering = [];
      event.docs.forEach((element) {
        cheering.add(CheeringModel.formJson(element.data()));
        // print('Get Cheering message');
        // print('///////////////////////////////////////////');
        // print(cheering.length);
        // print('///////////////////////////////////////////');
        emit(GetCheeringSuccessState());
      });
      // print( cheering.first.text);
      isLast = false;
      indexCheeringList += indexCheeringList;
      // print(isLast);
    });
  }

  Future<void> deleteCheeringPost({required String countryName}) async {
    var collection = FirebaseFirestore.instance
        .collection(countryName)
        .doc('1')
        .collection('cheering');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    emit(DeletePostSuccessState());
  }

  Future<void> deletePost({required String postId}) async {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      // print('===================== Delete Success =================');
      // getPosts();
      emit(DeletePostSuccessState());
    }).catchError((error) {
      emit(DeletePostErrorState());
    });
  }

  Future<void> toPayPal() async {
    String url = "https://paypal.me/tamerelsayed73?country.x=QA&locale.x=en_US";
    await launch(url, forceSafariVC: false);
    emit(LaunchPayPalSuccessState());
  }

  // BrowisePostModel? postModel;
  void uploadPrivateVideo(
      {required String recevierId,
      required String recevierName,
      required String recevierImage,
      required String dateTime,
      required String text,
      required String senderId}) {
    emit(BrowiseUploadVideoPostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
        //كدا بقوله انا فين في الstorage
        .ref()
        //كدا بقةله هتحرك ازاي جوا ال storage
        //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('privatechat/${Uri.file(postVideo3!.path).pathSegments.last}')
        //كدا بعمل رفع للصوره
        .putFile(postVideo3!)
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
        // print(';mmjhwdvghvcjyscgfcvjshcgs------->$thumbTempPath');
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child(
                'counter/$counter/${Uri.file(thumbTempPath!).pathSegments.last}')
            .putFile(File(thumbTempPath))
            .then((value3) {
          value3.ref.getDownloadURL().then((value4) {
            // print(';mmmmmmmmmmmmmmmmmmmmmmmmm$value4');
            // print(';mmmmmmmmmmmmmmmmmmmmmmmmm$value2');

            createVideoPrivate(
                messageViedo: value2,
                recevierId: recevierId,
                recevierName: recevierName,
                recevierImage: recevierImage,
                dateTime: dateTime,
                senderId: AppStrings.uId,
                privateChatSumbnail: value4);
            getPosts();
            emit(BrowiseUploadVideoPostSuccessState());
          });
        });
      }).catchError((error) {
        emit(BrowiseUploadVideoPostErrorState());
      });
    }).catchError((error) {
      emit(BrowiseUploadVideoPostErrorState());
    });
  }

  ////////////////////////////////////////////////////
//Create Post
  void createVideoPrivate({
    required String recevierId,
    required String recevierName,
    required String recevierImage,
    required String dateTime,
    String? messageViedo,
    String? senderId,
    String? privateChatSumbnail,
  }) {
    emit(BrowiseCreateVideoPostLoadingState());

    MessageModel model = MessageModel(
        video: messageViedo,
        text: "",
        dateTime: dateTime,
        recevierId: recevierId,
        recevierName: recevierName,
        recevierImage: recevierImage,
        privateChatSumbnail: privateChatSumbnail,
        senderId: AppStrings.uId);

    MessageModel myModel = MessageModel(
        video: messageViedo,
        text: "",
        dateTime: dateTime,
        recevierId: AppStrings.uId,
        recevierName: userModel!.username,
        recevierImage: userModel!.image,
        privateChatSumbnail: privateChatSumbnail,
        senderId: recevierId);

    //Set My Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .doc(recevierId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .doc(recevierId)
        .set(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    //Set Reciever Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(recevierId)
        .collection('chats')
        .doc(AppStrings.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(recevierId)
        .collection('chats')
        .doc(AppStrings.uId)
        .set(myModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List countries = [];

  Future<void> getCountries() async {
    await FirebaseFirestore.instance
        .collection('countries')
        .orderBy('name')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        countries.add(element.data());
      });
      // print('///////////////////////////////////////////////////////');
      // print(countries[0]['name']);
      // print('///////////////////////////////////////////////////////');
      emit(GetCountriesSuccessState());
    });

    emit(GetCountriesErrorState());
  }

  int? timerCheering;

  periodic() {
    Timer.periodic(const Duration(seconds: 1), (Timer time) {
      //print("time ${time.tick}");
      timerCheering = time.tick;
      if (time.tick == 5) {
        time.cancel();
        //print("Timer Cancelled");
      }
    });
    emit(GetTimerSuccessState());
  }

  Future<void> toYoutube({
    required String youtubeLink,
  }) async {
    String url = youtubeLink;
    await launch(url, forceSafariVC: false);
    emit(LaunchYoutubeSuccessState());
  }

  Future<void> toTwitter({
    required String twitterLink,
  }) async {
    String url = twitterLink;
    await launch(url, forceSafariVC: false);
    emit(LaunchTwitterSuccessState());
  }

  Future<void> toFacebook({
    required String facebookLink,
  }) async {
    String url = facebookLink;
    await launch(url, forceSafariVC: false);
    emit(LaunchFacebookSuccessState());
  }

  Future<void> toInstagram({
    required String instagramLink,
  }) async {
    String url = instagramLink;
    await launch(url, forceSafariVC: false);
    emit(LaunchInstagramSuccessState());
  }

  //--------------------------------- Public Chat Video

  File? postVideo4;
  void pickPostVideo4() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postVideo4 = File(pickedFile.path);
      controller = CachedVideoPlayerController.file(postVideo4!)
        ..initialize().then((value) {
          controller!.pause();
          emit(PickPrivateChatViedoSuccessState());
        }).catchError((error) {
          // print('error picking video ${error.toString()}');
        });
    }
  }

  ////////////////////////////////
  void pickPostVideoCameraPublic4() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      postVideo4 = File(pickedFile.path);
      videoPlayerController = VideoPlayerController.file(postVideo4!)
        ..initialize().then((value) {
          videoPlayerController!.pause();
          emit(PickPrivateChatViedoSuccessState());
        }).catchError((error) {
          // print('error picking video ${error.toString()}');
        });
    }
  }

  void uploadPublicChatVideo({
    required String dateTime,
    required String text,
    required String senderId,
    required String senderName,
    required String senderImage,
  }) {
    emit(UploadVideoPublicChatLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
        //كدا بقوله انا فين في الstorage
        .ref()
        //كدا بقةله هتحرك ازاي جوا ال storage
        //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('publicchat/${Uri.file(postVideo4!.path).pathSegments.last}')
        //كدا بعمل رفع للصوره
        .putFile(postVideo4!)
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
        // print(';mmjhwdvghvcjyscgfcvjshcgs------->$thumbTempPath');
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child(
                'counter/$counter/${Uri.file(thumbTempPath!).pathSegments.last}')
            .putFile(File(thumbTempPath))
            .then((value3) {
          value3.ref.getDownloadURL().then((value4) {
            // print(';mmmmmmmmmmmmmmmmmmmmmmmmm$value4');
            // print(';mmmmmmmmmmmmmmmmmmmmmmmmm$value2');

            createVideoPublicChat(
              messageViedo: value2,
              dateTime: dateTime,
              senderId: AppStrings.uId,
              senderName: senderName,
              senderImage: senderImage,
              publicChatThumbnail: value4,
            );
            emit(UploadVideoPublicChatSuccessState());
          });
        });
      }).catchError((error) {
        emit(UploadVideoPublicChatErrorState());
      });
    }).catchError((error) {
      emit(UploadVideoPublicChatErrorState());
    });
  }

  ////////////////////////////////////////////////////
//Create Post
  void createVideoPublicChat({
    required String dateTime,
    String? messageViedo,
    String? senderId,
    String? senderName,
    String? senderImage,
    String? publicChatThumbnail,
  }) {
    emit(CreateVideoPublicChatLoadingState());

    PublicChatModel model = PublicChatModel(
      video: messageViedo,
      text: "",
      dateTime: dateTime,
      senderId: AppStrings.uId,
      senderName: senderName,
      senderImage: senderImage,
      publicChatThumbnail: publicChatThumbnail ?? "",
    );

    //Set My Chat
    FirebaseFirestore.instance
        .collection('publicChat')
        .add(model.toMap())
        .then((value) {
      emit(CreateVideoPublicChatSuccessState());
    }).catchError((error) {
      emit(CreateVideoPublicChatErrorState());
    });
  }

  //--------------------------------- Public Chat Video

  File? postVideo5;
  void pickPostVideo5() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postVideo5 = File(pickedFile.path);
      controller = CachedVideoPlayerController.file(postVideo5!)
        ..initialize().then((value) {
          controller!.pause();
          emit(PickTeamChatVideoSuccessState());
        }).catchError((error) {
          // print('error picking video ${error.toString()}');
        });
    }
  }

  ////////////////////

  void pickPostVideoCamera5() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      postVideo5 = File(pickedFile.path);
      controller = CachedVideoPlayerController.file(postVideo5!)
        ..initialize().then((value) {
          controller!.pause();
          emit(PickTeamChatVideoSuccessState());
        }).catchError((error) {
          // print('error picking video ${error.toString()}');
        });
    }
  }

  void uploadTeamChatVideo({
    required String dateTime,
    required String text,
    required String senderId,
    required String senderName,
    required String senderImage,
    String? countryName,
  }) {
    emit(UploadVideoTeamChatLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
        //كدا بقوله انا فين في الstorage
        .ref()
        //كدا بقةله هتحرك ازاي جوا ال storage
        //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('teamchat/${Uri.file(postVideo5!.path).pathSegments.last}')
        //كدا بعمل رفع للصوره
        .putFile(postVideo5!)
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
        // print(';mmjhwdvghvcjyscgfcvjshcgs------->$thumbTempPath');
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child(
                'counter/$counter/${Uri.file(thumbTempPath!).pathSegments.last}')
            .putFile(File(thumbTempPath))
            .then((value3) {
          value3.ref.getDownloadURL().then((value4) {
            // print(';mmmmmmmmmmmmmmmmmmmmmmmmm$value4');
            // print(';mmmmmmmmmmmmmmmmmmmmmmmmm$value2');

            createVideoTeamChat(
                messageViedo: value2,
                dateTime: dateTime,
                senderName: senderName,
                senderImage: senderImage,
                senderId: AppStrings.uId,
                countryName: countryName,
                teamChatThumbnail: value4);
            getPosts();
            emit(UploadVideoTeamChatSuccessState());
          });
        });
      }).catchError((error) {
        emit(UploadVideoTeamChatErrorState());
      });
    }).catchError((error) {
      emit(UploadVideoTeamChatErrorState());
    });
  }

  ////////////////////////////////////////////////////
//Create Post
  void createVideoTeamChat({
    required String dateTime,
    String? messageViedo,
    String? senderId,
    String? senderName,
    String? senderImage,
    String? countryName,
    String? teamChatThumbnail,
  }) {
    emit(CreateVideoTeamChatLoadingState());

    TeamChatModel model = TeamChatModel(
      video: messageViedo,
      text: "",
      dateTime: dateTime,
      senderId: AppStrings.uId,
      senderName: senderName,
      senderImage: senderImage,
      teamChatThumbnail: teamChatThumbnail ?? "",
    );

    //Set My Chat
    FirebaseFirestore.instance
        .collection('$countryName')
        .add(model.toMap())
        .then((value) {
      emit(CreateVideoTeamChatSuccessState());
    }).catchError((error) {
      emit(CreateVideoTeamChatErrorState());
    });
  }

  void saveToken(String token) {
    FirebaseFirestore.instance
        .collection('tokens')
        .doc('${AppStrings.uId}')
        .set({"token": token}).then((value) {
      emit(SaveTokenSuccessState());
    });
  }

  // add advertising --------------------------------------

  File? uploadAdvertisingImage;
  var pickerAdvertising = ImagePicker();

  Future<void> getAdvertisingImage() async {
    final pickedFile = await pickerAdvertising.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      uploadAdvertisingImage = File(pickedFile.path);
      emit(PickAdvertisingImageSuccessState());
    } else {
      // print('No Image selected.');
    }
  }

  void increasNumberOfPosts(int index) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .update({'numberOfPosts': index}).then((value) {
      emit(IncreaseNumberOfPostsSuccessState());
    });
  }

  // var advertisingLink = TextEditingController();
  //
  // Future<void> createAdvertisingImage({
  //
  //   String ?image,
  //   String ?link,
  //
  //  })async{
  //   AdvertisingModel advertisingModel =AdvertisingModel(
  //     advertisingImage: image,
  //     advertisingLink: link,
  //   );
  //
  //   FirebaseFirestore.instance.collection('advertising').add(advertisingModel.toMap()).then((value) {
  //
  // //     print('Create Advertising');
  //     getAdvertisings();
  //     emit(CreateAdvertisingImageSuccessState());
  //   }).catchError((error){
  //
  // //     print('Error in createAdvertisingImage is ${error.toString()}');
  //     emit(CreateAdvertisingImageErrorState());
  //
  //   });
  //
  //
  // }
  // Future uploadAdvertising({
  //
  //   required String advertisingLink,
  //
  // }){
  //
  //   emit(UploadAdvertisingImageLoadingState());
  //   return firebase_storage.FirebaseStorage.instance.ref()
  //       .child('advertisingImage/${Uri.file(uploadAdvertisingImage!.path).pathSegments.last}')
  //       .putFile(uploadAdvertisingImage!).then((value) {
  //
  //     value.ref.getDownloadURL().then((value) {
  //
  //       debugPrint('uploadAdvertisingImage Success');
  //       createAdvertisingImage(
  //           image: value,
  //           link: advertisingLink,
  //       );
  //       uploadAdvertisingImage=null;
  //       advertisingLink='';
  //       emit(UploadAdvertisingImageSuccessState());
  //
  //     }).catchError((error){
  //
  //       debugPrint('Error in UploadAdvertisingImage ${error.toString()}');
  //       emit(UploadAdvertisingImageErrorState());
  //
  //     });
  //
  //   }).catchError((error){
  //
  //     debugPrint('Error in Upload NationalId ${error.toString()}');
  //     emit(UploadAdvertisingImageErrorState());
  //   });
  //
  //
  // }
  //
  // List <AdvertisingModel> advertisingModel=[];
  //
  // Future<void>  getAdvertisings()
  // async{
  //   advertisingModel=[];
  //   FirebaseFirestore.instance.collection('advertising').get().then((value) {
  //
  // //     print('siiiiiiiiiiiiiiiiiiiiiiiiiiii');
  //
  //     for (var element in value.docs) {
  //
  //       advertisingModel.add(AdvertisingModel.formJson(element.data()));
  //
  //     }
  // //     print('siiiiiiiiiiiiiiiiiiiiiiiiiiii');
  //
  //     emit(GetAdvertisingImageSuccessState());
  //
  //   }).catchError((error){
  //
  // //     print('Error is ${error.toString()}');
  //     emit(GetAdvertisingImageErrorState());
  //
  //   });
  // }
  //
  // Future <void> toAdvertisingLink({
  //   required String advertisingLink,
  // })async
  // {
  //   String url= advertisingLink;
  //   await launch(url , forceSafariVC: false);
  //   emit(LaunchAdvertisingImageSuccessState());
  // }

///////////////////////////////////////////////////////////profile//////////////////
//////////////////////////////fanarea///////////////////////////////
//pick fan image post
  File? profilePostImage;
  Future<void> pickProfilePostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profilePostImage = File(pickedFile.path);
      var decodedImage =
          await decodeImageFromList(profilePostImage!.readAsBytesSync());
      emit(PickProfilePostImageSuccessState());
    } else {
      // print('no fanPostImage selected');
      emit(PickProfilePostImageErrorState());
    }
  }

/////////////////////////////////////
////////////////////////////////////////
//Create fan Post
  void createProfileImagePost({
    required String? dateTime,
    required String? time,
    required String? timeSpam,
    required String? text,
    String? postImage,
  }) {
    emit(FanCreatePostLoadingState());

    ProfileModel model = ProfileModel(
      name: userModel!.username,
      image: userModel!.image,
      userId: userModel!.uId,
      dateTime: dateTime,
      time: time,
      postImage: postImage ?? '',
      postVideo: "",
      timeSmap: timeSpam,
      likes: 0,
      postId: AppStrings.postUid,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc('${AppStrings.uId}')
        .collection('profileImages')
        .add(model.toMap())
        .then((value) {
      printMessage(value.id);
      AppStrings.postUid = value.id;
      FirebaseFirestore.instance
          .collection('profileImages')
          .doc(AppStrings.postUid)
          .update({'postId': AppStrings.postUid}).then((value) {
        emit(ProfileCreatePostSuccessState());
      });
      //  getPosts();
      emit(ProfileCreatePostSuccessState());
    }).catchError((error) {
      emit(ProfileCreatePostErrorState());
    });
  }

///////////////////////////////////////////
//upload fan post image
  void uploadProfilePostImage({
    String? userId,
    String? name,
    String? image,
    required String? time,
    required String? dateTime,
    required String? text,
    required String? timeSpam,
  }) {
    emit(ProfileUploadImagePostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
        //كدا بقوله انا فين في الstorage
        .ref()
        //كدا بقةله هتحرك ازاي جوا ال storage
        //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('profile/${Uri.file(profilePostImage!.path).pathSegments.last}')
        //كدا بعمل رفع للصوره
        .putFile(profilePostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createProfileImagePost(
          dateTime: dateTime,
          postImage: value,
          text: text,
          time: time,
          timeSpam: timeSpam,
        );
        getProfilePosts();
        emit(ProfileUploadImagePostSuccessState());
      }).catchError((error) {
        // print('error while get fan post ${error.toString()}');
        emit(ProfileUploadImagePostErrorState());
      });
    }).catchError((error) {
      // print('error while get fan post ${error.toString()}');
      emit(FanUploadImagePostErrorState());
    });
  }
//////////////////////////////////////////////

  File? ProfilePostVideo;

  void pickProfilePostVideo() async {
    final pickedFile = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      ProfilePostVideo = File(pickedFile.path);
      videoPlayerController = VideoPlayerController.file(ProfilePostVideo!)
        ..initialize().then((value) {
          videoPlayerController!.play();
          emit(PickProfilePostVideoSuccessState());
        }).catchError((error) {
          // print('error picking  prfile video ${error.toString()}');
          emit(PickProfilePostVideoErrorState());
        });
    }
  }

////////////////////////////////////////
//////////////////////////////////////////////
//Create fan videoPost
  void createProfileVideoPost({
    required String dateTime,
    required String? text,
    required String time,
    required String? timeSpam,
    String? postVideo,
  }) {
    emit(FanCreateVideoPostLoadingState());

    ProfileModel model = ProfileModel(
        name: userModel!.username,
        image: userModel!.image,
        userId: userModel!.uId,
        dateTime: dateTime,
        postImage: '',
        postVideo: postVideo ?? '',
        time: time,
        timeSmap: timeSpam,
        likes: 0,
        postId: AppStrings.postUid);

    FirebaseFirestore.instance
        .collection('profileImages')
        .add(model.toMap())
        .then((value) {
      //getPosts();
      AppStrings.postUid = value.id;
      FirebaseFirestore.instance
          .collection('profileImages')
          .doc(AppStrings.postUid)
          .update({'postId': AppStrings.postUid}).then((value) {
        emit(ProfileCreateVideoPostSuccessState());
      });
      emit(ProfileCreateVideoPostSuccessState());
    }).catchError((error) {
      emit(ProfileCreateVideoPostErrorState());
    });
  }

///////////////////////////////////////////////
//upload fan post video to storage
  void uploadProfilePostVideo({
    String? userId,
    String? name,
    String? video,
    required String dateTime,
    required String time,
    required String timeSpam,
    required String? text,
  }) {
    emit(ProfileUploadVideoPostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
        //كدا بقوله انا فين في الstorage
        .ref()
        //كدا بقةله هتحرك ازاي جوا ال storage
        //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('profile/${Uri.file(ProfilePostVideo!.path).pathSegments.last}')
        //كدا بعمل رفع للصوره
        .putFile(ProfilePostVideo!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createProfileVideoPost(
          dateTime: dateTime,
          postVideo: value,
          text: text,
          time: time,
          timeSpam: timeSpam,
        );
        getProfilePosts();
        emit(FanUploadVideoPostSuccessState());
      }).catchError((error) {
        emit(FanUploadVideoPostErrorState());
      });
    }).catchError((error) {
      emit(FanUploadVideoPostErrorState());
    });
  }
////////////////////////////////////////////////////
////////////////////////////////////////////////////

//get Posts
  List<ProfileModel> profileImages = [];
  Future<void> getProfilePosts() async {
    profileImages = [];
    postsId = [];
    likes = [];
    emit(BrowiseGetProfilePostsLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc('${AppStrings.uId}')
        .collection('profileImages')
        .orderBy('timeSmap', descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        profileImages.add(ProfileModel.fromJson(element.data()));
        // Delete a record
        // await database?.rawDelete('DELETE * FROM Posts');
        emit(BrowiseGetProfilePostsSuccessState());
      });
    }).catchError((error) {
      emit(BrowiseGetFanPostsErrorState());
      // print('error while getting profile posts ${error.toString()}');
    });
  }

  // get user posts

  List<ProfileModel> userProfileImages = [];
  Future<void> getUserProfilePosts({
    required String id,
  }) async {
    userProfileImages = [];
    postsId = [];
    likes = [];
    emit(BrowiseGetProfilePostsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('profileImages')
        .orderBy('timeSmap', descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        userProfileImages.add(ProfileModel.fromJson(element.data()));
        // Delete a record
        // await database?.rawDelete('DELETE * FROM Posts');
        emit(BrowiseGetProfilePostsSuccessState());
      });
    }).catchError((error) {
      emit(BrowiseGetFanPostsErrorState());
      // print('error while getting profile posts ${error.toString()}');
    });
  }

  void onPressCheckBox(bool value) {
    value = true;
    emit(ChangeCheckBoxSuccessState());
  }

  String? singleViedo;
  Future<void> getSingleVideo({
    required int index,
  }) async {
    // print('');
    emit(GetSingleVideoLoadingState());

    await FirebaseFirestore.instance
        .collection('singleVideo')
        .doc('$index')
        .get()
        .then((value) {
      singleViedo = value.data()!['video'];
      emit(GetSingleVideoSuccessState());
    }).catchError((error) {
      // print('============================= error================');
      // print(error.toString());
      // print('============================= error================');
      emit(GetSingleVideoErrorState());
    });
  }

  List<String> userIds = [];

  Future<void> getUserIds() async {
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        userIds.add(element.data()['uId']);
        // print(userIds.first);
      }
      // print('============================== all user here========================');
      // print('Get All User Is');
      emit(GetUserIdsSuccessState());
    }).catchError((error) {
      // print('Error is ${error.toString()}');
      emit(GetUserIdsErrorState());
    });
  }

  bool isFound = false;

  List<MatchesModel> allMatches = [];

  Future<void> getAllMatches({required String doc}) async {
    emit(GetAllMatchesLoadingState());
    FirebaseFirestore.instance
        .collection('matches')
        .doc(doc)
        .collection('matches')
        .get()
        .then((value) {
      allMatches = [];

      value.docs.forEach((element) {
        allMatches.add(MatchesModel.fromJson(element.data()));
      });

      // print('============== lenght ===============');
      // print(allMatches.length);

      emit(GetAllMatchesSuccessState());
    }).catchError((error) {
      // print('Error is ${error.toString()}');
      emit(GetAllMatchesErrorState());
    });
  }

  Future<void> sendPostReport({
    required String reportType,
    required String senderReport,
    required String postOwner,
    required String postId,
    required String postText,
    required String postImage,
    required String postVideo,
  }) async {
    PostReportModel postReportModel = PostReportModel(
        postVideo: postVideo,
        postImage: postImage,
        postId: postId,
        postOwner: postOwner,
        postText: postText,
        reportType: reportType,
        senderReport: senderReport);

    FirebaseFirestore.instance
        .collection('PostReport')
        .add(postReportModel.toMap())
        .then((value) {
      emit(SendPostReportSuccessState());
    }).catchError((error) {
      // print('Error in seb=nd repost ${error.toString()}');
      emit(SendPostReportErrorState());
    });
  }

  Future<void> sendUserReport(
      {required String senderReportId,
      required String senderReportName,
      required String senderReportImage,
      required String userId,
      required String userName,
      required String userImage}) async {
    UserReportModel userReportModel = UserReportModel(
        userId: userId,
        senderReportId: senderReportId,
        senderReportImage: senderReportImage,
        senderReportName: senderReportName,
        userImage: userImage,
        userName: userName);

    FirebaseFirestore.instance
        .collection('UserReport')
        .add(userReportModel.toMap())
        .then((value) {
      emit(SendUserReportSuccessState());
    }).catchError((error) {
      // print('Error in send user repost ${error.toString()}');
      emit(SendUserReportErrorState());
    });
  }
}
