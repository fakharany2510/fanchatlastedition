part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class NavigateScreenState extends AppState {}

class CheckBoxState extends AppState {}
class PickPostImageSuccessState extends AppState {}
class PickPostImageErrorState extends AppState {}
class CreatePostLoadingState extends AppState {}
class PickPostVideoSuccessState extends AppState {}
class PickPostVideoErrorState extends AppState {}
//states for one user
class GetUserDataSuccessfulState extends AppState {}
class GetUserDataLoadingState extends AppState {}
class GetUserDataErrorState extends AppState {}
//states for all users
class GetAllUsersDataSuccessfulState extends AppState {}
class GetAllUsersDataLoadingState extends AppState {}
class GetAllUsersDataErrorState extends AppState {}
//posts states
class BrowiseCreatePostLoadingState extends AppState {}
class BrowiseCreatePostSuccessState extends AppState {}
class BrowiseCreatePostErrorState extends AppState {}
class BrowiseUploadTextPostLoadingState extends AppState {}
class BrowiseUploadTextPostSuccessState extends AppState {}
class BrowiseUploadTextPostErrorState extends AppState {}
class BrowiseUploadImagePostLoadingState extends AppState {}
class BrowiseUploadImagePostSuccessState extends AppState {}
class BrowiseUploadImagePostErrorState extends AppState {}
class BrowiseCreateVideoPostLoadingState extends AppState {}
class BrowiseCreateVideoPostSuccessState extends AppState {}
class BrowiseCreateVideoPostErrorState extends AppState {}
class BrowiseCreateTextPostLoadingState extends AppState {}
class BrowiseCreateTextPostSuccessState extends AppState {}
class BrowiseCreateTextPostErrorState extends AppState {}
class BrowiseUploadVideoPostLoadingState extends AppState {}
class BrowiseUploadVideoPostSuccessState extends AppState {}
class BrowiseUploadVideoPostErrorState extends AppState {}
class ChangeTap extends AppState {}
class BrowiseGetPostsLoadingState extends AppState {}
class BrowiseGetPostsSuccessState extends AppState {}
class BrowiseGetPostsErrorState extends AppState {}

class UploadProfileImageSuccessState extends AppState {}
class UploadProfileImageErrorState extends AppState {}

class UploadCoverImageSuccessState extends AppState {}
class UploadCoverImageErrorState extends AppState {}

class GetProfileImageLoadingState extends AppState {}
class GetProfileImageSuccessState extends AppState {}
class GetProfileImageErrorState extends AppState {}

class GetCoverImageLoadingState extends AppState {}
class GetCoverImageSuccessState extends AppState {}
class GetCoverImageErrorState extends AppState {}

class UpdateUserLoadingState extends AppState {}
class UpdateUserSuccessState extends AppState {}
class UpdateUserErrorState extends AppState {}
class CreateLikesSuccessState extends AppState {}
class CreateLikesErrorState extends AppState {}
//comments state
class CreateCommentsSuccessState extends AppState {}
class CreateCommentsErrorState extends AppState {}
class GetCommentsSuccessState extends AppState {}
class GetCommentsErrorState extends AppState {}
//like and comments number
class TestLikesSuccessState extends AppState {}
class TestCommentsSuccessState extends AppState {}

class ChangeColorSuccessState extends AppState {}

//create DataBase state
class CreateDatabaseState extends AppState{}
//get DataBase state
class GetDatabasState extends AppState{}
//insert to database states
class InsertDatabaseSuccessState extends AppState{}
class InsertDatabaseerrorState extends AppState{}

//logout
class SignoutSuccessState extends AppState{}
//messages
/////// messages states
class SendMessageSuccessState extends AppState{}
class SendMessageErrorState extends AppState{}
class GetMessageSuccessState extends AppState{}
//change icon
class ChangeIconSuccessState extends AppState{}
class StopLoadingState extends AppState{}
//fan area
          //image
class PickFanPostImageSuccessState extends AppState {}
class PickFanPostImageErrorState extends AppState {}
         //video
class PickFanPostVideoSuccessState extends AppState {}
class PickFanPostVideoErrorState extends AppState {}

//////fan post
class FanCreatePostLoadingState extends AppState {}
class FanCreatePostSuccessState extends AppState {}
class FanCreatePostErrorState extends AppState {}

class FanUploadImagePostLoadingState extends AppState {}
class FanUploadImagePostSuccessState extends AppState {}
class FanUploadImagePostErrorState extends AppState {}

class FanCreateVideoPostSuccessState extends AppState {}
class FanCreateVideoPostErrorState extends AppState {}
class FanCreateVideoPostLoadingState extends AppState {}

class FanUploadVideoPostLoadingState extends AppState {}
class FanUploadVideoPostSuccessState extends AppState {}
class FanUploadVideoPostErrorState extends AppState {}

class BrowiseGetFanPostsLoadingState extends AppState {}
class BrowiseGetFanPostsSuccessState extends AppState {}
class BrowiseGetFanPostsErrorState extends AppState {}

/////// public states
class SendPublicChatSuccessState extends AppState{}
class SendPublicChatErrorState extends AppState{}
class GetPublicChatSuccessState extends AppState{}
//change icon
class ChangeIconPublicChatSuccessState extends AppState{}