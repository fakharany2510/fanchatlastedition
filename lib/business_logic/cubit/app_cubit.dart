import 'dart:async';
import 'dart:io';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/data/modles/advertising_model.dart';
import 'package:fanchat/data/modles/cheering_model.dart';
import 'package:fanchat/data/modles/fan_model.dart';
import 'package:fanchat/data/modles/public_chat_model.dart';
import 'package:fanchat/presentation/screens/public_chat/public_chat_screen.dart';
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
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player/video_player.dart';
import '../../data/modles/comment_model.dart';
import '../../data/modles/create_post_model.dart';
import '../../data/modles/message_model.dart';
part 'app_state.dart';
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context)=> BlocProvider.of(context);

  TextEditingController changeUserNameController= TextEditingController();
  TextEditingController changeUserBioController= TextEditingController();
  TextEditingController changeUserPhoneController= TextEditingController();
  TextEditingController changeYoutubeLinkController= TextEditingController();
  TextEditingController changeFacebookLinkController= TextEditingController();
  TextEditingController changeTwitterLinkController= TextEditingController();
  TextEditingController changeInstagramLinkController= TextEditingController();

//caching manager
   final manager=CacheManager(Config(
    'customCacheKey',
    stalePeriod: const Duration(days: 15),maxNrOfCacheObjects: 100,));
  List screensTitles=[

    'Home Screen',
    'Match Details' ,
    'Fan Area' ,
    'Chat Screen',
    'public chat',
    'More Screen',

  ];


  final List <String> groupsImages=[

    'https://img.freepik.com/premium-photo/flag-france_135932-1458.jpg?w=740',
    'https://img.freepik.com/free-vector/illustration-usa-flag_53876-18165.jpg?w=996&t=st=1658517048~exp=1658517648~hmac=cbe565f23062c2297398122d1ead56d1031b7e446121a0e059be5be3158769c1' ,
    'https://img.freepik.com/premium-photo/argentinian-flag-close-up-view_625455-806.jpg?w=740',
    'https://img.freepik.com/free-photo/flag-senegal_1401-216.jpg?w=740&t=st=1658517102~exp=1658517702~hmac=a88fc9ccc784e74dd5c943332ac630c1bc6f92a9b12b52508cadd9be633e91e5',
    'https://img.freepik.com/free-photo/flags-germany_1232-3061.jpg?w=740&t=st=1658517131~exp=1658517731~hmac=352aa05f783a371e423a860f42e468a9184cab9ceed0464b2057f9a87c918e83',
    'https://img.freepik.com/free-photo/spanish-flag-white_144627-24632.jpg?w=740&t=st=1658517149~exp=1658517749~hmac=732a5f5e8dd887cffca58dfff1f851995fe7aff724739594ae00244e8978d59d',
    'https://img.freepik.com/free-photo/beautiful-greek-flag_23-2149323079.jpg?w=740&t=st=1658517166~exp=1658517766~hmac=3810542fd47f4156cdf46be69b54ad40c0ce6b9e2e12d2ea8814e3911b40965d',
    'https://img.freepik.com/free-photo/closeup-shot-realistic-flag-cameroon-with-interesting-textures_181624-9536.jpg?w=900&t=st=1658516966~exp=1658517566~hmac=2c7791265b0bce21be9e81157202febf6b6a1fc85ac15774fc47fc8702e11144',

  ];

  List <String> nationalTitles=[

    'France',
    'USA' ,
    'Argentinian',
    'Senegal',
    'Germany',
    'Spanish',
    'Greek',
    'Cameroon',

  ];

  List carouselImage=[
    'https://mostaql.hsoubcdn.com/uploads/thumbnails/1014251/60c7b6a350d3d/%D8%A7%D9%84%D8%AA%D8%B5%D9%85%D9%8A%D9%85.jpg',
 'https://pbs.twimg.com/media/Bp_KtB2CQAAo2FG?format=jpg&name=900x900',
    'https://economickey.com/wp-content/uploads/2021/12/images-2021-12-09T123459.676.jpeg',
    'https://images.netdirector.co.uk/gforces-auto/image/upload/w_1349,h_450,q_auto,c_fill,f_auto,fl_lossy/auto-client/07057d0e6193c6b928e53a2ec37e91ef/mg_hs_cover.png'
  ];

  List fanImages=[
    'https://img.freepik.com/free-photo/beautiful-tree-middle-field-covered-with-grass-with-tree-line-background_181624-29267.jpg?w=900&t=st=1659045801~exp=1659046401~hmac=504feac168c627bb796b580e3b468ca8d5325a36678dc17621bde464cd5d0772',
    'https://img.freepik.com/free-photo/sahara-desert-sunlight-blue-sky-morocco-africa_181624-19549.jpg?w=996&t=st=1659045804~exp=1659046404~hmac=5c76bce362790fab659ddab0c0a41863fa3f0dc531ac51446c71ae036924a763',
    'https://img.freepik.com/free-photo/empty-wooden-dock-lake-during-breathtaking-sunset-cool-background_181624-27469.jpg?w=740&t=st=1659045813~exp=1659046413~hmac=e3c81b3ac69beb13f9588398d3e16b10d170108d4b9d3cc18f4a7a14ad8eeca8',
    'https://img.freepik.com/free-photo/narrow-road-green-grassy-field-surrounded-by-green-trees-with-bright-sun-background_181624-9968.jpg?w=740&t=st=1659045814~exp=1659046414~hmac=4f98cde1a1c50474249a2231811857c77a05edb5175af945997af20ef7445ce7',
    'https://img.freepik.com/free-photo/nature-design-with-bokeh-effect_1048-1882.jpg?w=740&t=st=1659045819~exp=1659046419~hmac=ad9c886eeb0cd7dc1788e1daf28cf119b887ef66fd30040c80fbd2e98b5246da',
    'https://img.freepik.com/free-photo/vertical-shot-people-riding-camels-sand-dune-desert_181624-34974.jpg?w=740&t=st=1659044349~exp=1659044949~hmac=3f0c742eb4e47d6cdf45dc0ce3b37df273351228ddc2ca166458d2e6f2e92ca2'
  ];
  int currentIndex=0;
  void navigateScreen(int index,context){

    currentIndex=index;
    if(currentIndex==4){
      Navigator.push(context, MaterialPageRoute(builder: (_){
        return PublicChatScreen();
      }));
    }
    if(currentIndex==3){
      getAllUsers();
    }
    if(currentIndex==2){
     // getFanPosts();
    }
    emit(NavigateScreenState());
  }



  List <bool> isLike = List.generate(30, (index) => false);

  List <bool> isLikeFan = List.generate(30, (index) => false);


  bool checkValue=false;
  void checkBox(value){

    checkValue=value;
    emit(CheckBoxState());
  }

  UserModel? userModel;
  List<UserModel> users=[];
  //get all uers
  String profileId='';
  String profileFace='';
  String profileTwitter='';
  String profileInstagram='';
  String profileYoutube='';
  Future<void> getAllUsers()async{
    users=[];
    emit(GetAllUsersDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .get().then((value){
          value.docs.forEach((element) {
            if(element.data()['uId'] != AppStrings.uId)
              users.add(UserModel.formJson(element.data()));

            if(profileId== element.data()['uId'] ){

                profileFace=element.data()['facebookLink'];
                profileTwitter=element.data()['twitterLink'];
                profileYoutube=element.data()['youtubeLink'];
                profileInstagram=element.data()['instagramLink'];

            }
          });


            emit(GetAllUsersDataSuccessfulState());
    }).catchError((error){
      emit(GetAllUsersDataErrorState());
      print('error while getting all users ${error.toString()}');
    });
  }
  //get one user

  Future<void> getUser() async {
    emit(GetUserDataLoadingState());
   await  FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .get().then((value) {
          userModel = UserModel.formJson(value.data()!);
          printMessage('${userModel!.email}');
          changeUserNameController.text='${userModel!.username}';
          changeUserPhoneController.text='${userModel!.phone}';
          changeUserBioController.text='${userModel!.bio}';
          changeYoutubeLinkController.text='${userModel!.youtubeLink}';
          changeInstagramLinkController.text='${userModel!.instagramLink}';
          changeTwitterLinkController.text='${userModel!.twitterLink}';
          changeFacebookLinkController.text='${userModel!.facebookLink}';

          //getPosts();

          emit(GetUserDataSuccessfulState());
    }).catchError((error){

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
      print('Path is ${pickedFile.path}');
      emit(UploadCoverImageSuccessState());
    } else {
      print('No Image selected.');
      emit(UploadCoverImageErrorState());
    }
  }

  File? profileImage;

  ImageProvider profile = const AssetImage('assets/images/profile.png');

  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      profile = FileImage(profileImage!);
      print('Path is ${pickedFile.path}');
      emit(UploadProfileImageSuccessState());
    } else {
      print('No Image selected.');
      emit(UploadProfileImageErrorState());
    }

}




  String ?profilePath;

  Future uploadUserImage(
      {
        String ?name,
        String ?phone,
        String ?bio,
        String ?youtubeLink,
        String ?facebookLink,
        String ?instagramLink,
        String ?twitterLink,
      }
      ){

    emit(GetProfileImageLoadingState());
    return firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value) {

      value.ref.getDownloadURL().then((value) {

        printMessage('Upload Success');
        profilePath = value;
        updateProfile(name: name,
            phone: phone,
            bio: bio,
            cover: coverPath,
            facebookLink: facebookLink,
            instagramLink: instagramLink,
            twitterLink: twitterLink,
            youtubeLink: youtubeLink
        );
        emit(GetProfileImageSuccessState());

      }).catchError((error){

        print('Error in Upload profileImage ${error.toString()}');
        emit(GetProfileImageErrorState());

      });

    }).catchError((error){

      print('Error in Upload profileImage ${error.toString()}');
      emit(GetProfileImageErrorState());
    });
  }

  String ?coverPath;
  Future uploadUserCover(
      {
         String ?name,
         String ?phone,
         String ?bio,
         String ?youtubeLink,
         String ?facebookLink,
         String ?instagramLink,
         String ?twitterLink,

      }
      ){
    emit(GetCoverImageLoadingState());
    return firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value) {

      value.ref.getDownloadURL().then((value) {

        printMessage('Upload Success');
        coverPath = value;
        updateProfile(name: name,
            phone: phone,
            bio: bio,
            cover: coverPath,
            facebookLink: facebookLink,
            instagramLink: instagramLink,
            twitterLink: twitterLink,
            youtubeLink: youtubeLink
        );
        emit(GetCoverImageSuccessState());

      }).catchError((error){

        print('Error in Upload profileImage ${error.toString()}');
        emit(GetCoverImageErrorState());

      });

    }).catchError((error){

      print('Error in Upload profileImage ${error.toString()}');
      emit(GetCoverImageErrorState());
    });


  }


  Future updateProfile({

      String ?image,
      String ?cover,
      required String ?name,
      required String ?phone,
      required String ?bio,
      required String ?youtubeLink,
      required String ?instagramLink,
      required String ?twitterLink,
      required String ?facebookLink,
   })async{

    UserModel model= UserModel(
      username: name,
      bio: bio,
      uId: AppStrings.uId,
      image: image?? userModel!.image,
      cover: cover?? userModel!.cover,
      phone: phone,
      youtubeLink: youtubeLink,
      facebookLink: facebookLink,
      twitterLink: twitterLink,
      instagramLink: instagramLink,

    );
    emit(UpdateUserLoadingState());
    FirebaseFirestore.instance.
    collection('users').
    doc(AppStrings.uId).update(model.toMap()).then((value) {

      emit(UpdateUserSuccessState());
    }).catchError((error){

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
    final pickedFile  =
    await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      postImage=File(pickedFile.path);
      emit(PickPostImageSuccessState());
    } else {
      print('no postImage selected');
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
    final pickedFile  =
    await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage=File(pickedFile.path);
      var decodedImage = await decodeImageFromList(postImage!.readAsBytesSync());
      print(decodedImage.width);
      print(decodedImage.height);
      imageWidth=double.parse('${decodedImage.width}');
      imageHeight=double.parse('${decodedImage.height}');
      emit(PickPostImageSuccessState());
    } else {
      print('no postImage selected');
      emit(PickPostImageErrorState());
    }
  }
//-------------------------------------e;
  // change viseo upload
  bool videoButtonTapped = false;
  void isVideoButtonTapped(){
    videoButtonTapped = !videoButtonTapped;
    emit(ChangeTap());
  }
///////////////////////////////////////////////////////
  // Pick post video
  VideoPlayerController? videoPlayerController;
  CachedVideoPlayerController? controller;


  File? postVideo;
  void pickPostVideo2() async {
    final pickedFile =
    await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postVideo = File(pickedFile.path);
      controller = CachedVideoPlayerController.file(postVideo!)
        ..initialize().then((value) {
          controller!.pause();
          emit(PickPostVideoSuccessState());
        }).catchError((error) {
          print('error picking video ${error.toString()}');
        });
    }
  }

  File? postVideo3;
  void pickPostVideo3() async {
    final pickedFile =
    await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postVideo3 = File(pickedFile.path);
      controller = CachedVideoPlayerController.file(postVideo3!)
        ..initialize().then((value) {
          controller!.pause();
          emit(PickPrivateChatViedoSuccessState());
        }).catchError((error) {
          print('error picking video ${error.toString()}');
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
//           print('error picking video ${error.toString()}');
//         });
//     }
//   }
  ////////////////////////////////////////
  //format time
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
///////////////////////////////////////////
//upload post image
  void uploadPostImage({
    String? userId,
    String? name,
    String? image,
    required String ? time,
    required String? dateTime,
    required String? text,
    required String? timeSpam,
  }){
    emit(BrowiseUploadImagePostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
    //كدا بقوله انا فين في الstorage
        .ref()
    //كدا بقةله هتحرك ازاي جوا ال storage
    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
    //كدا بعمل رفع للصوره
        .putFile(postImage!).then((value){
      value.ref.getDownloadURL().then((value){
        createImagePost(
            dateTime: dateTime,
            postImage: value,
            text: text,
            time: time,
            timeSpam: timeSpam,

        );
        getPosts();
        emit(BrowiseUploadImagePostSuccessState());

      }).catchError((error){
        emit(BrowiseUploadImagePostErrorState());
      });
    }).catchError((error){
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
  }){
    emit(BrowiseCreatePostLoadingState());

    BrowisePostModel model=BrowisePostModel(
        name: userModel!.username,
        image:userModel!.image,
        userId:userModel!.uId,
        dateTime:dateTime,
        time: time,
        postImage:postImage??'',
        postVideo: "",
        timeSmap: timeSpam,
        text: text,
        likes: 0,
        comments:0,
        postId: AppStrings.postUid,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value){
          printMessage(value.id);
          AppStrings.postUid=value.id;
          FirebaseFirestore.instance
              .collection('posts')
              .doc(AppStrings.postUid)
               .update({
                'postId':AppStrings.postUid
              }).then((value){
            emit(BrowiseCreatePostSuccessState());
          });
        //  getPosts();
      emit(BrowiseCreatePostSuccessState());
    })
        .catchError((error){
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
  }){
    emit(BrowiseUploadVideoPostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
    //كدا بقوله انا فين في الstorage
        .ref()
    //كدا بقةله هتحرك ازاي جوا ال storage
    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('posts/${Uri.file(postVideo!.path).pathSegments.last}')
    //كدا بعمل رفع للصوره
        .putFile(postVideo!).then((value){
      value.ref.getDownloadURL().then((value){
        createVideoPost(
          dateTime:dateTime,
          postVideo: value,
          text: text,
          time: time,
          timeSpam:timeSpam,
        );
        getPosts();
        emit(BrowiseUploadVideoPostSuccessState());

      }).catchError((error){
        emit(BrowiseUploadVideoPostErrorState());
      });
    }).catchError((error){
      emit(BrowiseUploadVideoPostErrorState());
    });
  }
  ////////////////////////////////////////////////////
//Create Post
  void createVideoPost({
    required String dateTime,
    required String? text,
    required String time,
    required String? timeSpam,
    String? postVideo,
  }){
    emit(BrowiseCreateVideoPostLoadingState());

    BrowisePostModel model=BrowisePostModel(
      name: userModel!.username,
      image:userModel!.image,
      userId:userModel!.uId,
      dateTime:dateTime,
      postImage:'',
      postVideo: postVideo??'',
      time: time  ,
      text: text,
      timeSmap: timeSpam,
      likes: 0,
      comments:0,
      postId: AppStrings.postUid
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value){
          //getPosts();
      AppStrings.postUid=value.id;
      FirebaseFirestore.instance
          .collection('posts')
          .doc(AppStrings.postUid)
          .update({
        'postId':AppStrings.postUid
      }).then((value){
        emit(BrowiseCreateVideoPostSuccessState());
      });
      emit(BrowiseCreateVideoPostSuccessState());
    })
        .catchError((error){
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
  }){
    emit(BrowiseCreateTextPostLoadingState());

    BrowisePostModel model=BrowisePostModel(
        name: userModel!.username,
        image:userModel!.image,
        userId:userModel!.uId,
        dateTime:dateTime,
        postImage:'',
        postVideo: '',
        text: text,
        time: time,
        timeSmap: timeSpam,
        likes:0,
        comments:0,
        postId: AppStrings.postUid
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value){
      AppStrings.postUid=value.id;
      FirebaseFirestore.instance
          .collection('posts')
          .doc(AppStrings.postUid)
          .update({
        'postId':AppStrings.postUid
      }).then((value){
        emit(BrowiseCreateTextPostSuccessState());
      });
      getPosts();
      emit(BrowiseCreateTextPostSuccessState());
    })
        .catchError((error){
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
  }){
    emit(BrowiseUploadImagePostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
    //كدا بقوله انا فين في الstorage
        .ref()
    //كدا بقةله هتحرك ازاي جوا ال storage
    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('posts')
    //كدا بعمل رفع للصوره
        .putString(text!).then((value){
      createImagePost(
          dateTime: dateTime,
          text: text,
          time: time,
          timeSpam: timeSpam
      );
      getPosts();
      emit(BrowiseUploadTextPostSuccessState());

    }).catchError((error){
      emit(BrowiseUploadTextPostErrorState());
    });
  }
//////////////////////////////////////////////
  /////////////////////////
  //get Posts
    List<BrowisePostModel> posts=[];
  List<String> postsId=[];
  List<int> likes=[];

  void getPosts(){
    posts=[];
    postsId=[];
    likes=[];
    emit(BrowiseGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('timeSmap',descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) async{
        posts.add(BrowisePostModel.fromJson(element.data()));
        emit(BrowiseGetPostsSuccessState());

      });
    }
    )
        .catchError((error){
      emit(BrowiseGetPostsErrorState());
      print('error while getting posts ${error.toString()}');
    });
  }
  /////////////////////////////////////////////////
  //post likes

//
  void likePosts(String postId,int Likes){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'likes':true,
      }).then((value){
      // testLikes();
      emit(CreateLikesSuccessState());
      testLikes(postId,Likes);
    })
        .catchError((error){
      emit(CreateLikesErrorState()
      );
    });
  }
  /////////////////////////////////////////////////////////
// Create Comment
  /////////////////////////////////////
List<int> commentIndex=[];
  List <CommentModel> comments=[];
  void commentHomePost(String postId, String comment) {
    CommentModel model = CommentModel(
        username: userModel!.username,
        userImage: userModel!.image!,
        userId: userModel!.uId,
        comment: comment,
        date: DateTime.now().toString()
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      print('Comment Add');
      getComment(postId);
      testComments(postId);
      // commentIndex.length++;
      emit(CreateCommentsSuccessState());
    }).catchError((error) {
      print('Error When set comment in home : ${error.toString()}');
      emit(CreateCommentsErrorState());
    });
  }
/////////////////////////////////////////
  //get comments
  void getComment(String postId) {
    comments=[];
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
         .orderBy('date',descending: true)
        .get()
        .then((value) {
      print('Get Comments Success');
      comments=[];
      value.docs.forEach((element) {

        comments.add(CommentModel.fromFire(element.data()));

      });
      emit(GetCommentsSuccessState());
    }).catchError((error) {
      print('Error When set comment in home : ${error.toString()}');
      emit(GetCommentsErrorState());
    });
  }
  //////////////////////////////////////////////////////////
// get likes number
  /////////////////////////////////////

  void testLikes(postId,int Likes) {
    // posts=[];
    postsId = [];
    likes = [];
    FirebaseFirestore.instance
        .collection('posts')
        .snapshots().listen((event) {
      event.docs.forEach((element) {
        element.reference
            .collection('likes')
            .snapshots().listen((event) {
              // postsId.add(element.id);
           if(postId==element.id){
            Likes = event.docs.length;
            FirebaseFirestore.instance
                .collection('posts')
                .doc(postId)
                .update({
              'likes':Likes
            }).then((value){
              print(Likes);
              print(event.docs.length);
              print('Siiiiiiiiiiiiiiiiiiiiiiii');
              printMessage('postId is ${postId}');
              print('Siiiiiiiiiiiiiiiiiiiiiiii');
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



  Color ?iconColor = Colors.grey;

  void changeIconColor(){

    iconColor=Colors.blue;
    emit(ChangeColorSuccessState());


  }

  void returnIconColor(){

    iconColor=Colors.grey;
    emit(ChangeColorSuccessState());


  }


//
//   // //get comments number
//   // /////////////////////////
  List<int> commentNum=[];
  int ?Comments=0;
  void testComments(postId) {
   // posts=[];
    postsId = [];
    commentNum = [];
    FirebaseFirestore.instance
        .collection('posts')
        .snapshots().listen((event) {
      event.docs.forEach((element) {
        element.reference
            .collection('comments')
            .snapshots().listen((event) {
          event.docs.forEach((element1){
            // postsId.add(element.id);
            print(event.docs.length);
            print(Comments);
            print('Siiiiiiiiiiiiiiiiiiiiiiii');
            printMessage('postId is ${postId}');
            print('Siiiiiiiiiiiiiiiiiiiiiiii');
            printMessage('elementId is ${element.id}');
            if(postId==element.id){
              print('hhhhhhhhhhhhhhhhhhhh');
              Comments= event.docs.length;
              print(Comments);
              print(event.docs.length);
              FirebaseFirestore.instance
                  .collection('posts')
                  .doc(postId)
                  .update({
                'comments':Comments
              }).then((value){
                print(Comments);
                print(event.docs.length);
                print('Siiiiiiiiiiiiiiiiiiiiiiii');
                printMessage('postId is ${postId}');
                print('Siiiiiiiiiiiiiiiiiiiiiiii');
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
  Future<void> signOut() async{
     CashHelper.removeData(key: 'uid').then((value) async {
      await FirebaseAuth.instance.signOut();
    });

   emit(SignoutSuccessState());
  }
///////////////////////////////////////////////////////////
  //create posts functions
//-------------------------------------------------------
//1-create image post
//-------------------------------------------------------
  Database? database;
  void createDatabase()async
  {
    await openDatabase(
        'fan.db',
        version: 1,
        onCreate: (database, version) {
          print('Database Created');
          database.execute(
              'CREATE TABLE Posts (postId INTEGER PRIMARY KEY , userId text ,image text , name TEXT , postImage TEXT , postVideo Text , postText Text, time text , timeSamp text )'
          ).then((value) {
            print('Table Created');
          }).catchError((error) {
            print('error while creating database${error.toString()}');
          });
        },
        onOpen: (database) {
          getDatafromdatabase(database);
        }
    ).then((value){
      database =value;
      emit(CreateDatabaseState());
    });
  }
//------------------------------------------
  //insert to database
//------------------------------------------
  insertTOdatabase({
    required String postId,
    required String userId,
    required String image,
    required String name,
     String? postImage,
     String? postVideo,
     String? postText,
    required String time,
    required String timeSamp,

  })async{
    sqlposts=[];
    await database?.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO Posts(postId,userId,name,image,postImage,postVideo,postText,time,timeSamp) VALUES("$postId","$userId" ,"$name","$image","$postImage","$postVideo","$postText","$time","$timeSamp")')
          .then((value) {
        print('Task ${value}Inserted successfully');
        emit(InsertDatabaseSuccessState());
        getDatafromdatabase(database);
      }).catchError((error) {
        print('ERROR INSERT TO DB ${error.toString()}');
        emit(InsertDatabaseerrorState());
      });
    });
  }

//------------------------------------------
  //get data from database
//------------------------------------------
  List<Map>sqlposts=[];
  void getDatafromdatabase(database)async{
    List<Map>sqlposts=[];
    await database.rawQuery('SELECT * FROM Posts').then((value){
      value.forEach((element){
        sqlposts.add(element);
      });
      emit(GetDatabasState());
    });
  }
  /////////////////////////////////////////////////////////////////
  void createImageMessage({
    required String recevierId,
    required String dateTime,
    String? messageImage,
    String? senderId,
  }){
    emit(BrowiseCreatePostLoadingState());
    MessageModel model=MessageModel(
      image: messageImage,
      text: "",
      dateTime: dateTime,
      recevierId: recevierId,
      senderId: AppStrings.uId
    );

    //Set My Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .doc(recevierId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((error){
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
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((error){
      emit(SendMessageErrorState());
    });
  }
//////////////////////////////////////////
  void uploadMessageImage({
    required String recevierId,
    required String dateTime,
    required String text,
    required String senderId
  }){
    emit(BrowiseUploadImagePostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
    //كدا بقوله انا فين في الstorage
        .ref()
    //كدا بقةله هتحرك ازاي جوا ال storage
    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('MessageImages/${Uri.file(postImage!.path).pathSegments.last}')
    //كدا بعمل رفع للصوره
        .putFile(postImage!).then((value){
      value.ref.getDownloadURL().then((value){
        createImageMessage(
          messageImage: value,
          recevierId: recevierId,
          dateTime: dateTime,
          senderId: AppStrings.uId
        );

        emit(BrowiseUploadImagePostSuccessState());

      }).catchError((error){
        emit(BrowiseUploadImagePostErrorState());
      });
    }).catchError((error){
      emit(BrowiseUploadImagePostErrorState());
    });
  }
  ///////////////////////////////////messages////////////////////////////
//send Messages

  void sendMessage({
    required String recevierId,
    required String dateTime,
    required String text,

  }){
    MessageModel model =MessageModel(
      recevierId:recevierId,
      senderId: AppStrings.uId,
      dateTime: dateTime,
      text: text,
    );
    //Set My Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .doc(recevierId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((error){
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
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((error){
      emit(SendMessageErrorState());
    });
  }
  ////////////////////////
//get messages
  List<MessageModel> messages=[];
  void getMessages({
    required String recevierId,
  }){
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
        print('llllllllllllllllllllllllllllllllllllllllllllllllllllllllll');
        print(messages[0].voice);


      });
      emit(GetMessageSuccessState());

    });
  }
  bool isWritingMessage=false;
  void changeIcon(){
    isWritingMessage!=isWritingMessage;
    emit(ChangeIconSuccessState());
  }

  bool isSend=false;
  ///////////////////////////////voice message
  void createVoiceMessage({
     required String recevierId,
    required String dateTime,
   required String voice,

  }){
    emit(StopLoadingState());

    MessageModel model=MessageModel(
        image: "",
        text: "",
       dateTime: dateTime,
        recevierId: recevierId,
        senderId: AppStrings.uId,
        voice: voice
    );
    emit(StopLoadingState());

    //Set My Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .doc(recevierId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
      emit(StopLoadingState());
        isSend=false;
      emit(SendMessageSuccessState());
    })
        .catchError((error){
      emit(SendMessageErrorState());
      print(error.toString());
    });
    //Set Reciever Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(recevierId)
        .collection('chats')
        .doc(AppStrings.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((error){
      emit(SendMessageErrorState());
      print(error.toString());
    });
  }

  //////////////////////////////fanarea///////////////////////////////
  //pick fan image post
  File? fanPostImage;
  Future<void> pickFanPostImage() async {
    final pickedFile  =
      await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      fanPostImage=File(pickedFile.path);
      var decodedImage = await decodeImageFromList(fanPostImage!.readAsBytesSync());
      print(decodedImage.width);
      print(decodedImage.height);
      imageWidth=double.parse('${decodedImage.width}');
      imageHeight=double.parse('${decodedImage.height}');
      emit(PickFanPostImageSuccessState());
    } else {
      print('no fanPostImage selected');
      emit(PickFanPostImageErrorState());
    }
  }
/////////////////////////////////////
//pick fan post video
  File? fanPostVideo;

  void pickFanPostVideo() async {
    final pickedFile =
    await picker.pickVideo(source: ImageSource.gallery,);
    if (pickedFile != null) {
      fanPostVideo = File(pickedFile.path);
      videoPlayerController = VideoPlayerController.file(fanPostVideo!)
        ..initialize().then((value) {
          videoPlayerController!.play();
          emit(PickFanPostVideoSuccessState());
        }).catchError((error) {
          print('error picking  fan video ${error.toString()}');
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
  }){
    emit(FanCreatePostLoadingState());

    FanModel model=FanModel(
      name: userModel!.username,
      image:userModel!.image,
      userId:userModel!.uId,
      dateTime:dateTime,
      time: time,
      postImage:postImage??'',
      postVideo: "",
      timeSmap: timeSpam,
      likes: 0,
      postId: AppStrings.postUid,
    );

    FirebaseFirestore.instance
        .collection('fan')
        .add(model.toMap())
        .then((value){
      printMessage(value.id);
      AppStrings.postUid=value.id;
      FirebaseFirestore.instance
          .collection('fan')
          .doc(AppStrings.postUid)
          .update({
        'postId':AppStrings.postUid
      }).then((value){
        emit(FanCreatePostSuccessState());
      });
      //  getPosts();
      emit(FanCreatePostSuccessState());
    })
        .catchError((error){
      emit(FanCreatePostErrorState());
    });
  }
  ///////////////////////////////////////////
//upload fan post image
  void uploadFanPostImage({
    String? userId,
    String? name,
    String? image,
    required String ? time,
    required String? dateTime,
    required String? text,
    required String? timeSpam,
  }){
    emit(FanUploadImagePostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
    //كدا بقوله انا فين في الstorage
        .ref()
    //كدا بقةله هتحرك ازاي جوا ال storage
    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('fan/${Uri.file(fanPostImage!.path).pathSegments.last}')
    //كدا بعمل رفع للصوره
        .putFile(fanPostImage!).then((value){
      value.ref.getDownloadURL().then((value){
        createFanImagePost(
          dateTime: dateTime,
          postImage: value,
          text: text,
          time: time,
          timeSpam: timeSpam,

        );
        getFanPosts();
        print(fans[1].postImage);
        emit(FanUploadImagePostSuccessState());

      }).catchError((error){
        print('error while get fan post ${error.toString()}');
        emit(FanUploadImagePostErrorState());
      });
    }).catchError((error){
      print('error while get fan post ${error.toString()}');
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
    String? postVideo,
  }){
    emit(FanCreateVideoPostLoadingState());

    FanModel model=FanModel(
        name: userModel!.username,
        image:userModel!.image,
        userId:userModel!.uId,
        dateTime:dateTime,
        postImage:'',
        postVideo: postVideo??'',
        time: time  ,
        timeSmap: timeSpam,
        likes: 0,
        postId: AppStrings.postUid
    );

    FirebaseFirestore.instance
        .collection('fan')
        .add(model.toMap())
        .then((value){
      //getPosts();
      AppStrings.postUid=value.id;
      FirebaseFirestore.instance
          .collection('fan')
          .doc(AppStrings.postUid)
          .update({
        'postId':AppStrings.postUid
      }).then((value){
        emit(FanCreateVideoPostSuccessState());
      });
      emit(FanCreateVideoPostSuccessState());
    })
        .catchError((error){
      emit(FanCreateVideoPostErrorState());
    });
  }
///////////////////////////////////////////////
//upload fan post video to storage
  void uploadFanPostVideo({
    String? userId,
    String? name,
    String? video,
    required String dateTime,
    required String time,
    required String timeSpam,
    required String? text,
  }){
    emit(FanUploadVideoPostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
    //كدا بقوله انا فين في الstorage
        .ref()
    //كدا بقةله هتحرك ازاي جوا ال storage
    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('fan/${Uri.file(fanPostVideo!.path).pathSegments.last}')
    //كدا بعمل رفع للصوره
        .putFile(fanPostVideo!).then((value){
      value.ref.getDownloadURL().then((value){
        createFanVideoPost(
          dateTime:dateTime,
          postVideo: value,
          text: text,
          time: time,
          timeSpam:timeSpam,
        );
        getFanPosts();
        emit(FanUploadVideoPostSuccessState());

      }).catchError((error){
        emit(FanUploadVideoPostErrorState());
      });
    }).catchError((error){
      emit(FanUploadVideoPostErrorState());
    });
  }
////////////////////////////////////////////////////

  //get Posts
  List<FanModel> fans=[];
  void getFanPosts(){
    fans=[];
    postsId=[];
    likes=[];
    emit(BrowiseGetFanPostsLoadingState());
    FirebaseFirestore.instance
        .collection('fan')
        .orderBy('timeSmap',descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) async{
        fans.add(FanModel.fromJson(element.data()));
        // Delete a record
        // await database?.rawDelete('DELETE * FROM Posts');
        emit(BrowiseGetFanPostsSuccessState());

      });
    }
    )
        .catchError((error){
      emit(BrowiseGetFanPostsErrorState());
      print('error while getting Fan posts ${error.toString()}');
    });
  }
////// Public Chat ////////////////////////////////////////


  void createImagePublicChat({
    required String dateTime,
    String? messageImage,
    String? senderId,
    String? senderName,
    String? senderImage,

  }){
    emit(BrowiseCreatePostLoadingState());
    PublicChatModel model=PublicChatModel(
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
        .then((value){

      print('createImagePublicChat success');
      emit(SendPublicChatSuccessState());
    }).catchError((error){

      print('Error is ${error.toString()}');
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

  }){
    emit(BrowiseUploadImagePostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
    //كدا بقوله انا فين في الstorage
        .ref()
    //كدا بقةله هتحرك ازاي جوا ال storage
    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('PublicChatImages/${Uri.file(postImage!.path).pathSegments.last}')
    //كدا بعمل رفع للصوره
        .putFile(postImage!).then((value){
      value.ref.getDownloadURL().then((value){
        createImagePublicChat(
          messageImage: value,
          dateTime: dateTime,
          senderId: AppStrings.uId,
          senderName: userModel!.username,
          senderImage: userModel!.image,
        );

        emit(BrowiseUploadImagePostSuccessState());

      }).catchError((error){
        emit(BrowiseUploadImagePostErrorState());
      });
    }).catchError((error){
      emit(BrowiseUploadImagePostErrorState());
    });
  }
  ///////////////////////////////////messages////////////////////////////
//send Messages

  void sendPublicChat({
    required String dateTime,
    required String text,

  }){
    PublicChatModel model =PublicChatModel(
        senderId: AppStrings.uId,
        dateTime: dateTime,
        text: text,
        senderName:userModel!.username,
        senderImage: userModel!.image
    );
    //Set My Chat
    FirebaseFirestore.instance
        .collection('publicChat')
        .add(model.toMap())
        .then((value){
      print(isSend);
      emit(SendPublicChatSuccessState());
    })
        .catchError((error){
      emit(SendPublicChatErrorState());

    });

  }
  ////////////////////////
//get messages
  List<PublicChatModel> publicChat=[];
  void getPublicChat(){
    FirebaseFirestore.instance
        .collection('publicChat')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      publicChat = [];
      event.docs.forEach((element) {
        publicChat.add((PublicChatModel.fromJson(element.data())));
        print('llllllllllllllllllllllllllllllllllllllllllllllllllllllllll');
        print(publicChat[0].voice);


      });
      emit(GetPublicChatSuccessState());

    });
  }



  bool isWritingPublicChat=false;
  void changeIconPublicChat(){
    isWritingPublicChat!=isWritingPublicChat;
    emit(ChangeIconPublicChatSuccessState());
  }

  ///////////////////////////////voice message
  void createVoicePublicChat({
    required String dateTime,
    required String voice,

  }){

    PublicChatModel model=PublicChatModel(
        image: "",
        text: "",
        dateTime: dateTime,
        senderId: AppStrings.uId,
        senderImage: userModel!.image,
        senderName: userModel!.username,
        voice: voice
    );

    //Set My Chat
    FirebaseFirestore.instance
        .collection('publicChat')
        .add(model.toMap())
        .then((value){
      isSend=false;

      emit(SendPublicChatSuccessState());
    }).catchError((error){
      print(error.toString());
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

  }){
    emit(BrowiseCreatePostLoadingState());
    PublicChatModel model=PublicChatModel(
      image: messageImage,
      text: "",
      dateTime: dateTime,
      senderId: AppStrings.uId,
      senderName: senderName,
      senderImage: senderImage,

    );

    //Set My Chat
    FirebaseFirestore.instance
        .collection('${countryName}')
        .add(model.toMap())
        .then((value){

      print('createImagePublicChat success');
      emit(SendTeamChatSuccessState());
    }).catchError((error){

      print('Error is ${error.toString()}');
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

  }){
    emit(BrowiseUploadImagePostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
    //كدا بقوله انا فين في الstorage
        .ref()
    //كدا بقةله هتحرك ازاي جوا ال storage
    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('TeamChatImages/${Uri.file(postImage!.path).pathSegments.last}')
    //كدا بعمل رفع للصوره
        .putFile(postImage!).then((value){
      value.ref.getDownloadURL().then((value){
        createImageTeamChat(
          messageImage: value,
          dateTime: dateTime,
          senderId: AppStrings.uId,
          senderName: userModel!.username,
          senderImage: userModel!.image,
          countryName: countryName
        );

        emit(BrowiseUploadImagePostSuccessState());

      }).catchError((error){
        emit(BrowiseUploadImagePostErrorState());
      });
    }).catchError((error){
      emit(BrowiseUploadImagePostErrorState());
    });
  }
  ///////////////////////////////////messages////////////////////////////
//send Messages

  void sendTeamChat({
    required String dateTime,
    required String text,
    required String countryName,

  }){
    PublicChatModel model =PublicChatModel(
        senderId: AppStrings.uId,
        dateTime: dateTime,
        text: text,
        senderName:userModel!.username,
        senderImage: userModel!.image
    );
    //Set My Chat
    FirebaseFirestore.instance
        .collection('${countryName}')
        .add(model.toMap())
        .then((value){
      print(isSend);
      emit(SendTeamChatSuccessState());
    })
        .catchError((error){
      emit(SendTeamChatErrorState());

    });

  }
  ////////////////////////
//get messages
  List<PublicChatModel> teamChat=[];
  void getTeamChat(String countryName){
    teamChat=[];
    FirebaseFirestore.instance
        .collection('${countryName}')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      teamChat = [];
      event.docs.forEach((element) {
        teamChat.add((PublicChatModel.fromJson(element.data())));
        print('llllllllllllllllllllllllllllllllllllllllllllllllllllllllll');
        print(teamChat[0].voice);

      });
      emit(GetTeamChatSuccessState());
    });
  }



  bool isWritingTeamChat=false;
  void changeIconTeamChat(){
    isWritingTeamChat!=isWritingTeamChat;
    emit(ChangeIconTeamChatSuccessState());
  }

  ///////////////////////////////voice message
  void createVoiceTeamChat({
    required String dateTime,
    required String voice,
    required String countryName,

  }){

    PublicChatModel model=PublicChatModel(
        image: "",
        text: "",
        dateTime: dateTime,
        senderId: AppStrings.uId,
        senderImage: userModel!.image,
        senderName: userModel!.username,
        voice: voice
    );

    //Set My Chat
    FirebaseFirestore.instance
        .collection('${countryName}')
        .add(model.toMap())
        .then((value){
      isSend=false;

      emit(SendTeamChatSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SendTeamChatErrorState());
    });
  }
///////////////////////////////////////////////////////

///////////////////////// Fan Likes

  List <int>fanLikes=[];
  List <String>fanId=[];

  void likeFans(String fanId,int Likes){
    FirebaseFirestore.instance
        .collection('fan')
        .doc(fanId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'likes':true,
    }).then((value){
      emit(CreateFanLikesSuccessState());
      testFanLikes(fanId,Likes);
    }).catchError((error){

      emit(CreateFanLikesErrorState()
      );
    });
  }


  void testFanLikes(fanId,int Likes) {
    // posts=[];
    fanId = [];
    fanLikes = [];
    FirebaseFirestore.instance
        .collection('fan')
        .snapshots().listen((event) {
      event.docs.forEach((element) {
        element.reference
            .collection('likes')
            .snapshots().listen((event) {
          // postsId.add(element.id);
          if(fanId==element.id){
            Likes = event.docs.length;
            FirebaseFirestore.instance
                .collection('fan')
                .doc(fanId)
                .update({
              'likes':Likes
            }).then((value){
              print(Likes);
              print(event.docs.length);
              print('Siiiiiiiiiiiiiiiiiiiiiiii');
              printMessage('postId is ${fanId}');
              print('Siiiiiiiiiiiiiiiiiiiiiiii');
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
    required String? timeSpam,
    required String? text,

  })async{

    CheeringModel model=CheeringModel(
       time: time,
      timeSpam: timeSpam,
      uId: userModel!.uId,
      username: userModel!.username,
      userImage: userModel!.image,
      text: text
    );

    emit(CreateCheeringLoadingState());

    FirebaseFirestore.instance
        .collection('cheering')
        .add(model.toMap())
        .then((value){
          getCheeringPost();
          print('Upload Cheering message');
      emit(CreateCheeringSuccessState());
    })
        .catchError((error){
      emit(CreateCheeringErrorState());
    });
  }

  bool isLast=true;
  int count=15;


  List <CheeringModel> cheering=[];

  Future <void> getCheeringPost() async{
    cheering=[];
    FirebaseFirestore.instance
        .collection('cheering')
        .orderBy('timeSpam',descending: true)
        .snapshots().listen((event) {
                event.docs.forEach((element) {
                  cheering.add(CheeringModel.formJson(element.data()));
                  print('Get Cheering message');
                  emit(GetCheeringSuccessState());
                });
                print( cheering.first.text);
                isLast=false;
                print( isLast);
    });

  }

  Future <void> deleteCheeringPost() async{
    var collection = FirebaseFirestore.instance.collection('cheering');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    emit(DeletePostSuccessState());

  }


  //Create Cheering
  void deletePost({
    required String postId
  }){

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value){

      print('Post Delete');
      getPosts();
      emit(DeletePostSuccessState());
    })
        .catchError((error){
      emit(DeletePostErrorState());
    });
  }


  Future <void> toPayPal()async
  {
    String url= "https://paypal.me/tamerelsayed73?country.x=QA&locale.x=en_US";
    await launch(url , forceSafariVC: false);
    emit(LaunchPayPalSuccessState());
  }

  // BrowisePostModel? postModel;
  void uploadPrivateVideo({
    required String recevierId,
    required String dateTime,
    required String text,
    required String senderId
  }){
    emit(BrowiseUploadVideoPostLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
    //كدا بقوله انا فين في الstorage
        .ref()
    //كدا بقةله هتحرك ازاي جوا ال storage
    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('privatechat/${Uri.file(postVideo3!.path).pathSegments.last}')
    //كدا بعمل رفع للصوره
        .putFile(postVideo3!).then((value){
      value.ref.getDownloadURL().then((value){
        createVideoPrivate(
            messageViedo: value,
            recevierId: recevierId,
            dateTime: dateTime,
            senderId: AppStrings.uId
        );
        getPosts();
        emit(BrowiseUploadVideoPostSuccessState());

      }).catchError((error){
        emit(BrowiseUploadVideoPostErrorState());
      });
    }).catchError((error){
      emit(BrowiseUploadVideoPostErrorState());
    });
  }
  ////////////////////////////////////////////////////
//Create Post
  void createVideoPrivate({
    required String recevierId,
    required String dateTime,
    String? messageViedo,
    String? senderId,
  }){
    emit(BrowiseCreateVideoPostLoadingState());

    MessageModel model=MessageModel(
        video:messageViedo,
        text: "",
        dateTime: dateTime,
        recevierId: recevierId,
        senderId: AppStrings.uId
    );

    //Set My Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .doc(recevierId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((error){
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
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((error){
      emit(SendMessageErrorState());
    });
  }

  List countries=[];

  void getCountries(){

    FirebaseFirestore.instance
        .collection('countries')
        .get().then((value) {

          value.docs.forEach((element) {

            countries.add(element.data());

          });
          print('///////////////////////////////////////////////////////');
          print(countries[0]['name']);
          print('///////////////////////////////////////////////////////');
          emit(GetCountriesSuccessState());
    });

    emit(GetCountriesErrorState());

  }

  int ?timerCheering;


  void periodic(){

    Timer.periodic(

      const Duration(seconds: 1),
      (Timer time){
        print("time ${time.tick}");
         timerCheering=time.tick;
        if(time.tick==5){
          time.cancel();
          print("Timer Cancelled");
        }
      }

    );
    emit(GetTimerSuccessState());
  }

  Future <void> toYoutube({
    required String youtubeLink,
   })async
  {
    String url= youtubeLink;
    await launch(url , forceSafariVC: false);
    emit(LaunchYoutubeSuccessState());
  }


  Future <void> toTwitter({
    required String twitterLink,
  })async
  {
    String url= twitterLink;
    await launch(url , forceSafariVC: false);
    emit(LaunchTwitterSuccessState());
  }


  Future <void> toFacebook({
    required String facebookLink,
  })async
  {
    String url= facebookLink;
    await launch(url , forceSafariVC: false);
    emit(LaunchFacebookSuccessState());
  }

  Future <void> toInstagram({
    required String instagramLink,
  })async
  {
    String url= instagramLink;
    await launch(url , forceSafariVC: false);
    emit(LaunchInstagramSuccessState());
  }


  //--------------------------------- Public Chat Video

  File? postVideo4;
  void pickPostVideo4() async {
    final pickedFile =
    await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postVideo4 = File(pickedFile.path);
      controller = CachedVideoPlayerController.file(postVideo4!)
        ..initialize().then((value) {
          controller!.pause();
          emit(PickPrivateChatViedoSuccessState());
        }).catchError((error) {
          print('error picking video ${error.toString()}');
        });
    }
  }

  void uploadPublicChatVideo({
    required String dateTime,
    required String text,
    required String senderId
  }){
    emit(UploadVideoPublicChatLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
    //كدا بقوله انا فين في الstorage
        .ref()
    //كدا بقةله هتحرك ازاي جوا ال storage
    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('publicchat/${Uri.file(postVideo4!.path).pathSegments.last}')
    //كدا بعمل رفع للصوره
        .putFile(postVideo4!).then((value){
      value.ref.getDownloadURL().then((value){
        createVideoPublicChat(
            messageViedo: value,
            dateTime: dateTime,
            senderId: AppStrings.uId
        );
        getPosts();
        emit(UploadVideoPublicChatSuccessState());

      }).catchError((error){
        emit(UploadVideoPublicChatErrorState());
      });
    }).catchError((error){
      emit(UploadVideoPublicChatErrorState());
    });
  }
  ////////////////////////////////////////////////////
//Create Post
  void createVideoPublicChat({
    required String dateTime,
    String? messageViedo,
    String? senderId,
  }){
    emit(CreateVideoPublicChatLoadingState());

    PublicChatModel model= PublicChatModel(
        video:messageViedo,
        text: "",
        dateTime: dateTime,
        senderId: AppStrings.uId
    );

    //Set My Chat
    FirebaseFirestore.instance
        .collection('publicChat')
        .add(model.toMap())
        .then((value){
      emit(CreateVideoPublicChatSuccessState());
    })
        .catchError((error){
      emit(CreateVideoPublicChatErrorState());

    });

  }


  //--------------------------------- Public Chat Video

  File? postVideo5;
  void pickPostVideo5() async {
    final pickedFile =
    await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postVideo5 = File(pickedFile.path);
      controller = CachedVideoPlayerController.file(postVideo5!)
        ..initialize().then((value) {
          controller!.pause();
          emit(PickTeamChatVideoSuccessState());
        }).catchError((error) {
          print('error picking video ${error.toString()}');
        });
    }
  }

  void uploadTeamChatVideo({
    required String dateTime,
    required String text,
    required String senderId,
    String ?countryName,
  }){
    emit(UploadVideoTeamChatLoadingState());
    //كدا انا بكريت instance من ال storage
    firebase_storage.FirebaseStorage.instance
    //كدا بقوله انا فين في الstorage
        .ref()
    //كدا بقةله هتحرك ازاي جوا ال storage
    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage
        .child('teamchat/${Uri.file(postVideo5!.path).pathSegments.last}')
    //كدا بعمل رفع للصوره
        .putFile(postVideo5!).then((value){
      value.ref.getDownloadURL().then((value){
        createVideoTeamChat(
            messageViedo: value,
            dateTime: dateTime,
            senderId: AppStrings.uId,
            countryName: countryName
        );
        getPosts();
        emit(UploadVideoTeamChatSuccessState());

      }).catchError((error){
        emit(UploadVideoTeamChatErrorState());
      });
    }).catchError((error){
      emit(UploadVideoTeamChatErrorState());
    });
  }
  ////////////////////////////////////////////////////
//Create Post
  void createVideoTeamChat({
    required String dateTime,
    String? messageViedo,
    String? senderId,
    String ? countryName,
  }){
    emit(CreateVideoTeamChatLoadingState());

    PublicChatModel model= PublicChatModel(
        video:messageViedo,
        text: "",
        dateTime: dateTime,
        senderId: AppStrings.uId
    );

    //Set My Chat
    FirebaseFirestore.instance
        .collection('${countryName}')
        .add(model.toMap())
        .then((value){
      emit(CreateVideoTeamChatSuccessState());
    })
        .catchError((error){
      emit(CreateVideoTeamChatErrorState());

    });

  }

  void saveToken(String token){
    FirebaseFirestore.instance.collection('tokens').add(
        {"token":token}
    ).then((value){
      emit(SaveTokenSuccessState());
    });

  }

  // add advertising --------------------------------------

  File? uploadAdvertisingImage ;
  var pickerAdvertising = ImagePicker();

  Future <void> getAdvertisingImage() async {
    final pickedFile = await pickerAdvertising.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      uploadAdvertisingImage = File(pickedFile.path);
      emit(PickAdvertisingImageSuccessState());
    } else {
      print('No Image selected.');
    }
  }
 void increasNumberOfPosts(int index){
    FirebaseFirestore.instance.collection('users').doc(AppStrings.uId).update(
      {
        'numberOfPosts':index
      }
    ).then((value){
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
  //     print('Create Advertising');
  //     getAdvertisings();
  //     emit(CreateAdvertisingImageSuccessState());
  //   }).catchError((error){
  //
  //     print('Error in createAdvertisingImage is ${error.toString()}');
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
  //     print('siiiiiiiiiiiiiiiiiiiiiiiiiiii');
  //
  //     for (var element in value.docs) {
  //
  //       advertisingModel.add(AdvertisingModel.formJson(element.data()));
  //
  //     }
  //     print('siiiiiiiiiiiiiiiiiiiiiiiiiiii');
  //
  //     emit(GetAdvertisingImageSuccessState());
  //
  //   }).catchError((error){
  //
  //     print('Error is ${error.toString()}');
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
}

