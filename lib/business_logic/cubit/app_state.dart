part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class NavigateScreenState extends AppState {}

class PushEndListState extends AppState {}

class CheckBoxState extends AppState {}
class PickPostImageSuccessState extends AppState {}
class PickPostImageErrorState extends AppState {}

class PickChatImageSuccessState extends AppState {}
class PickChatImageErrorState extends AppState {}
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
class GetProfileImageFirstTimeSuccessState extends AppState{}
class GetCoverImageFirstTimeSuccessState extends AppState{}

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

/////// public states
class SendPublicChatSuccessState extends AppState{}
class SendPublicChatErrorState extends AppState{}
class GetPublicChatSuccessState extends AppState{}
//change icon
class ChangeIconPublicChatSuccessState extends AppState{}

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

/////// Team states
class SendTeamChatSuccessState extends AppState{}
class SendTeamChatErrorState extends AppState{}
class GetTeamChatSuccessState extends AppState{}
//change icon
class ChangeIconTeamChatSuccessState extends AppState{}

// fan Like

class CreateFanLikesSuccessState extends AppState {}
class CreateFanLikesErrorState extends AppState {}
class TestFanLikesSuccessState extends AppState {}

// cheering

class CreateCheeringLoadingState extends AppState {}
class CreateCheeringSuccessState extends AppState {}
class CreateCheeringErrorState extends AppState {}

class GetCheeringSuccessState extends AppState {}
class GetCheeringErrorState extends AppState {}

class DeletePostSuccessState extends AppState {}
class DeletePostErrorState extends AppState {}

class LaunchPayPalSuccessState extends AppState {}

class PickPrivateChatViedoSuccessState extends AppState {}
class PickPrivateChatViedoErrorState extends AppState {}

class GetCountriesSuccessState extends AppState {}
class GetCountriesErrorState extends AppState {}

class GetTimerSuccessState extends AppState {}

class LaunchYoutubeSuccessState extends AppState {}
class LaunchTwitterSuccessState extends AppState {}
class LaunchFacebookSuccessState extends AppState {}
class LaunchInstagramSuccessState extends AppState {}
class SaveTokenSuccessState extends AppState {}
class GetTokenSuccessState extends AppState {}


// ------------ Public Chat Video


class PickPublicChatVideoSuccessState extends AppState {}

class CreateVideoPublicChatSuccessState extends AppState {}
class CreateVideoPublicChatErrorState extends AppState {}
class CreateVideoPublicChatLoadingState extends AppState {}

class UploadVideoPublicChatLoadingState extends AppState {}
class UploadVideoPublicChatSuccessState extends AppState {}
class UploadVideoPublicChatErrorState extends AppState {}

// ------------ Team Chat Video


class PickTeamChatVideoSuccessState extends AppState {}

class CreateVideoTeamChatSuccessState extends AppState {}
class CreateVideoTeamChatErrorState extends AppState {}
class CreateVideoTeamChatLoadingState extends AppState {}

class UploadVideoTeamChatLoadingState extends AppState {}
class UploadVideoTeamChatSuccessState extends AppState {}
class UploadVideoTeamChatErrorState extends AppState {}
class PaySuccessState extends AppState {}


class PickAdvertisingImageSuccessState extends AppState {}
class IncreaseNumberOfPostsSuccessState extends AppState {}

class UploadAdvertisingImageLoadingState extends AppState {}
class UploadAdvertisingImageSuccessState extends AppState {}
class UploadAdvertisingImageErrorState extends AppState {}

class CreateAdvertisingImageLoadingState extends AppState {}
class CreateAdvertisingImageSuccessState extends AppState {}
class CreateAdvertisingImageErrorState extends AppState {}

class GetAdvertisingImageLoadingState extends AppState {}
class GetAdvertisingImageSuccessState extends AppState {}
class GetAdvertisingImageErrorState extends AppState {}
class LaunchAdvertisingImageSuccessState extends AppState {}


class UploadImagePrivateLoadingState extends AppState {}
class UploadImagePrivateSuccessState extends AppState {}
class UploadImagePrivateErrorState extends AppState {}

class CreateImagePrivateLoadingState extends AppState {}
class CreateImagePrivateSuccessState extends AppState {}
class CreateImagePrivateErrorState extends AppState {}



//fan area
//image
class PickProfilePostImageSuccessState extends AppState {}
class PickProfilePostImageErrorState extends AppState {}
//video
class PickProfilePostVideoSuccessState extends AppState {}
class PickProfilePostVideoErrorState extends AppState {}

//////fan post
class ProfileCreatePostLoadingState extends AppState {}
class ProfileCreatePostSuccessState extends AppState {}
class ProfileCreatePostErrorState extends AppState {}

class ProfileUploadImagePostLoadingState extends AppState {}
class ProfileUploadImagePostSuccessState extends AppState {}
class ProfileUploadImagePostErrorState extends AppState {}

class ProfileCreateVideoPostSuccessState extends AppState {}
class ProfileCreateVideoPostErrorState extends AppState {}
class ProfileCreateVideoPostLoadingState extends AppState {}

class ProfileUploadVideoPostLoadingState extends AppState {}
class ProfileUploadVideoPostSuccessState extends AppState {}
class ProfileUploadVideoPostErrorState extends AppState {}

class BrowiseGetProfilePostsLoadingState extends AppState {}
class BrowiseGetProfilePostsSuccessState extends AppState {}
class BrowiseGetProfilePostsErrorState extends AppState {}

class GetWaitingSuccessState extends AppState {}
class UpdateWaitingSuccessState extends AppState {}


class ChangeCheckBoxSuccessState extends AppState {}
class PauseVideoState extends AppState {}

class GetSingleVideoLoadingState extends AppState {}
class GetSingleVideoSuccessState extends AppState {}
class GetSingleVideoErrorState extends AppState {}

class GetUserIdsSuccessState extends AppState{}
class  GetUserIdsErrorState extends AppState{}

class GetAllMatchesLoadingState extends AppState {}
class GetAllMatchesSuccessState extends AppState {}
class GetAllMatchesErrorState extends AppState {}

class CheckUserSuccessState extends AppState{}


class SendPostReportLoadingState extends AppState {}
class SendPostReportSuccessState extends AppState {}
class SendPostReportErrorState extends AppState {}

class SendUserReportLoadingState extends AppState {}
class SendUserReportSuccessState extends AppState {}
class SendUserReportErrorState extends AppState {}