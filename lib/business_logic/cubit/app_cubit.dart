import 'dart:io';
import 'package:fanchat/business_logic/register/register_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:video_player/video_player.dart';

import '../../data/modles/comment_model.dart';
import '../../data/modles/create_post_model.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context)=> BlocProvider.of(context);

  TextEditingController changeUserNameController= TextEditingController();
  TextEditingController changeUserBioController= TextEditingController();
  TextEditingController changeUserPhoneController= TextEditingController();


  List screensTitles=[

    'Home Screen',
    'Match Details' ,
    'Fan Area' ,
    'Chat Screen',
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
'https://img.freepik.com/free-photo/fizzy-cola-drink-macro-shot_53876-14910.jpg?w=740&t=st=1659277350~exp=1659277950~hmac=45c21685c87c74c08a36b9e06c78941df495a4ac01d887e87a2b34a4bd304320',
    'https://img.freepik.com/free-photo/front-right-side-blue-sedan-car_114579-4394.jpg?w=740&t=st=1659277380~exp=1659277980~hmac=dadc794df23aeeabeac4b43f3d81303a981d8b15ff549cc720ba8b4d95bbc72c',
 'https://img.freepik.com/free-photo/beautiful-cold-drink-cola-with-ice-cubes_1150-26255.jpg?w=740&t=st=1659277429~exp=1659278029~hmac=216e0d1c26ca832ba14ace6f0b3d22a1409a30d9218534ebe15e1f503f41a285',
  ];

  List chatImages=[
    'https://img.freepik.com/free-photo/successful-professional-enjoying-work-break_1262-16980.jpg?w=740&t=st=1658702118~exp=1658702718~hmac=a87514a21d49f5fa06f774fbfbe0adad396f68a7c4b24912ddd70c9aeed5eddb',
    'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=740&t=st=1658702156~exp=1658702756~hmac=e88a3db16b3bb740df629b5d80f3d6b0cb9cb693cee3663078665059aed3a6cc',
    'https://img.freepik.com/free-photo/young-handsome-man-listens-music-with-earphones_176420-15616.jpg?w=740&t=st=1658702204~exp=1658702804~hmac=4ad64670966fe210e2226e87405fadf3971f9db7eb7a5136b5e039053e2d365a',
    'https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?w=740&t=st=1658702142~exp=1658702742~hmac=26d3c0d7eaadc76fee6a337185a9b9288961ceb2513c8de238d3ad3b81e26ae0',
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
  void navigateScreen(int index){

    currentIndex=index;
    if(currentIndex==3){
      getUser();
    }
    emit(NavigateScreenState());
  }



  bool checkValue=false;
  void checkBox(value){

    checkValue=value;
    emit(CheckBoxState());
  }

  UserModel? userModel;
  void getUser() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .get().then((value) {
          userModel = UserModel.formJson(value.data()!);
          printMessage('${userModel!.email}');
          changeUserNameController.text='${userModel!.username}';
          changeUserPhoneController.text='${userModel!.phone}';
          changeUserBioController.text='${userModel!.bio}';
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

      }
      ){

    emit(GetProfileImageLoadingState());
    return firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value) {

      value.ref.getDownloadURL().then((value) {

        printMessage('Upload Success');
        profilePath = value;
        updateProfile(name: name, phone: phone, bio: bio,image: profilePath);

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

      }
      ){


    emit(GetCoverImageLoadingState());
    return firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value) {

      value.ref.getDownloadURL().then((value) {

        printMessage('Upload Success');
        coverPath = value;
        updateProfile(name: name, phone: phone, bio: bio,cover: coverPath);
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

   })async{

    UserModel model= UserModel(
      username: name,
      bio: bio,
      uId: AppStrings.uId,
      image: image?? userModel!.image,
      cover: cover?? userModel!.cover,
      phone: phone,

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
  File? postImage;
  Future<void> pickPostImage() async {
    final pickedFile  =
    await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage=File(pickedFile.path);
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

  File? postVideo;

  void pickPostVideo() async {
    final pickedFile =
    await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postVideo = File(pickedFile.path);
      videoPlayerController = VideoPlayerController.file(postVideo!)
        ..initialize().then((value) {
          videoPlayerController!.play();
          emit(PickPostVideoSuccessState());
        }).catchError((error) {
          print('error picking video ${error.toString()}');
        });
    }
  }
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
    required DateTime? dateTime,
    required String? text,
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
          text: text
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
    required DateTime? dateTime,
    required String? text,
    String? postImage,
  }){
    emit(BrowiseCreatePostLoadingState());

    BrowisePostModel model=BrowisePostModel(
      name: userModel!.username,
      image:userModel!.image,
      userId:userModel!.uId,
      dateTime:getTimeDifferenceFromNow(dateTime!),
      postImage:postImage??'',
      postVideo: "",
      text: text
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value){
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
    required DateTime? dateTime,
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
          text: text
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
    required DateTime? dateTime,
    required String? text,
    String? postVideo,
  }){
    emit(BrowiseCreateVideoPostLoadingState());

    BrowisePostModel model=BrowisePostModel(
        name: userModel!.username,
        image:userModel!.image,
        userId:userModel!.uId,
        dateTime:getTimeDifferenceFromNow(dateTime!),
        postImage:'',
        postVideo: postVideo??'',
      text: text
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value){
          //getPosts();
      emit(BrowiseCreateVideoPostSuccessState());
    })
        .catchError((error){
      emit(BrowiseCreateVideoPostErrorState());
    });
  }
  ///////////////////////////////////////////////
  //create text post
  void createTextPost({
    required DateTime? dateTime,
    required String? text,
  }){
    emit(BrowiseCreateTextPostLoadingState());

    BrowisePostModel model=BrowisePostModel(
        name: userModel!.username,
        image:userModel!.image,
        userId:userModel!.uId,
        dateTime:getTimeDifferenceFromNow(dateTime!),
        postImage:'',
        postVideo: '',
        text: text
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value){
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
    required DateTime? dateTime,
    required String? text,
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
          text: text
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
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference
            .collection('likes')
            .get()
            .then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(BrowisePostModel.fromJson(element.data()));
          emit(BrowiseGetPostsSuccessState());
        }).catchError((error){});

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
  Future likePosts(String postId)async{
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'likes':true,
    })
        .then((value){
      emit(CreateLikesSuccessState());
    })
        .catchError((error){
      emit(CreateLikesErrorState()
      );
    });
  }
  /////////////////////////////////////////////////////////
// Create Comment
  /////////////////////////////////////

  List <CommentModel> comments=[];
  void commentHomePost(String postId, String comment) {
    CommentModel model = CommentModel(
      username: userModel!.username,
      userImage: userModel!.image!,
      userId: userModel!.uId,
      comment: comment,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      print('Comment Add');
      getComment(postId);
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
        .get()
        .then((value) {
      print('Get Comments Success');
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

  // void testLikes() {
  //   // posts=[];
  //   postsId = [];
  //   likes = [];
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .snapshots().listen((event) {
  //     event.docs.forEach((element) {
  //       element.reference
  //           .collection('likes')
  //           .snapshots().listen((event) {
  //         likes.add(event.docs.length);
  //         postsId.add(element.id);
  //         // posts.add(BrowisePostModel.fromJson(element.data()));
  //         emit(TestLikesSuccessState());
  //       });
  //     });
  //   });
  // }

  // //get comments number
  // /////////////////////////
  // List<int> commentNum=[];
  // void testComments() {
  //   // posts=[];
  //   postsId = [];
  //   commentNum = [];
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .snapshots().listen((event) {
  //     event.docs.forEach((element) {
  //       element.reference
  //           .collection('comments')
  //           .snapshots().listen((event) {
  //         commentNum.add(event.docs.length);
  //         postsId.add(element.id);
  //         // posts.add(BrowisePostModel.fromJson(element.data()));
  //         emit(TestLikesSuccessState());
  //       });
  //     });
  //   });
  // }


}
