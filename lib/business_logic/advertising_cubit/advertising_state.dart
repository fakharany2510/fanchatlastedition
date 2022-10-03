abstract class AdvertisingState{
}

class InitialState extends AdvertisingState{

}


//fan area
//image
class PickAdvertisingPostImageSuccessState extends AdvertisingState {}
class PickAdvertisingPostImageErrorState extends AdvertisingState {}
//video
class PickAdvertisingPostVideoSuccessState extends AdvertisingState {}
class PickAdvertisingPostVideoErrorState extends AdvertisingState {}

//////fan post
class AdvertisingCreatePostLoadingState extends AdvertisingState {}
class AdvertisingCreatePostSuccessState extends AdvertisingState {}
class AdvertisingCreatePostErrorState extends AdvertisingState {}

class AdvertisingUploadImagePostLoadingState extends AdvertisingState {}
class AdvertisingUploadImagePostSuccessState extends AdvertisingState {}
class AdvertisingUploadImagePostErrorState extends AdvertisingState {}

class AdvertisingCreateVideoPostSuccessState extends AdvertisingState {}
class AdvertisingCreateVideoPostErrorState extends AdvertisingState {}
class FanCreateVideoPostLoadingState extends AdvertisingState {}

class AdvertisingUploadVideoPostLoadingState extends AdvertisingState {}
class AdvertisingUploadVideoPostSuccessState extends AdvertisingState {}
class AdvertisingUploadVideoPostErrorState extends AdvertisingState {}

class BrowiseGetAdvertisingPostsLoadingState extends AdvertisingState {}
class BrowiseGetAdvertisingPostsSuccessState extends AdvertisingState {}
class BrowiseGetAdvertisingPostsErrorState extends AdvertisingState {}
class LaunchAdvertisingImageSuccessState extends AdvertisingState {}