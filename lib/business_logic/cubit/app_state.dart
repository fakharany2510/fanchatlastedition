part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class NavigateScreenState extends AppState {}

class CheckBoxState extends AppState {}

class GetUserSuccessfulState extends AppState {}
class GetUserErrorState extends AppState {}
