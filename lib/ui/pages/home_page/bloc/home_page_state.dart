part of 'home_page_bloc.dart';

@immutable
class HomePageState {
  final JsonParser? jsonParser;
  final double memoryAfterPhotos;
  final double totalDiskSpace;
  final List<Points> listPoints;
  final ImageParam imageParam;

  const HomePageState({
    required this.memoryAfterPhotos,
    required this.totalDiskSpace,
     this.imageParam  = const  ImageParam(),
    this.listPoints = const [],
    this.jsonParser,
  });

  HomePageState copyWith({
    JsonParser? jsonParser,
    double? memoryAfterPhotos,
    double? totalDiskSpace,
    List<Points>? listPoints,
    ImageParam? imageParam,
  }) {
    return HomePageState(
      jsonParser: jsonParser ?? this.jsonParser,
      memoryAfterPhotos: memoryAfterPhotos ?? this.memoryAfterPhotos,
      totalDiskSpace: totalDiskSpace ?? this.totalDiskSpace,
      listPoints: listPoints ?? this.listPoints,
      imageParam: imageParam ?? this.imageParam,
    );
  }
}

final class HomePageInitial extends HomePageState {
  const HomePageInitial({
    super.jsonParser,
  }) : super(memoryAfterPhotos: 0.0, totalDiskSpace: 0.0, imageParam: const ImageParam(),);
}
