part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

class GetJson extends HomePageEvent {}

class OpenMockScheme extends HomePageEvent {
  final int index;

  OpenMockScheme(this.index);
}
