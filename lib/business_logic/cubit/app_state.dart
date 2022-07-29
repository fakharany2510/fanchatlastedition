part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class NavigateScreenState extends AppState {}

class CheckBoxState extends AppState {}

class GetUserSuccessfulState extends AppState {}
class GetUserErrorState extends AppState {}

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