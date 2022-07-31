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

class GetUserSuccessfulState extends AppState {}
class GetUserErrorState extends AppState {}
class BrowiseCreatePostLoadingState extends AppState {}
class BrowiseCreatePostSuccessState extends AppState {}
class BrowiseCreatePostErrorState extends AppState {}
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