part of 'home_page_bloc.dart';

@immutable
class HomePageState {
  final JsonParser? jsonParser;
  final double memoryAfterPhotos;
  final double totalDiskSpace;
  final List<Points> listPoints;

  const HomePageState({
    required this.memoryAfterPhotos,
    required this.totalDiskSpace,
    this.listPoints = const [],
    this.jsonParser,
  });

  HomePageState copyWith({
    JsonParser? jsonParser,
    double? memoryAfterPhotos,
    double? totalDiskSpace,
    List<Points>? listPoints,
  }) {
    return HomePageState(
      jsonParser: jsonParser ?? this.jsonParser,
      memoryAfterPhotos: memoryAfterPhotos ?? this.memoryAfterPhotos,
      totalDiskSpace: totalDiskSpace ?? this.totalDiskSpace,
      listPoints: listPoints ?? this.listPoints,
    );
  }
}

final class HomePageInitial extends HomePageState {
  const HomePageInitial({
    super.jsonParser,
  }) : super(memoryAfterPhotos: 0.0, totalDiskSpace: 0.0);
}
