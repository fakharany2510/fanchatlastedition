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

class GetUserDataSuccessfulState extends AppState {}
class GetUserDataLoadingState extends AppState {}
class GetUserDataErrorState extends AppState {}
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