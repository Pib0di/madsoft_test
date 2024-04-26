import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:external_path/external_path.dart';
import 'package:madsoft_test/core/api/rest_client.dart';
import 'package:madsoft_test/core/models/json_parser.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final RestClient _rest;

  HomePageBloc(this._rest) : super(const HomePageInitial()) {
    on<OpenMockScheme>(_onOpenMockScheme);
    on<GetJson>(_onGetJson);
  }

  _onOpenMockScheme(OpenMockScheme event, Emitter<HomePageState> emit) async {
    final index = event.index;
    final listPoints = state.jsonParser!.payload[index].points;

    emit(state.copyWith(
      listPoints: listPoints,
    ));
  }

  _onGetJson(GetJson event, Emitter<HomePageState> emit) async {
    final jsonParser = await _rest.getJsonParser();

    getDirSize(Directory(await getPath()));

    var storageInfo = await getTemporaryDirectory();
    var availableStorage = storageInfo.statSync().size;

    emit(HomePageState(
      jsonParser: jsonParser,
      memoryAfterPhotos: 0,
      totalDiskSpace: 0 ?? 0,
    ));
  }

  Future<String> getPath() async {
    var path = await ExternalPath.getExternalStorageDirectories();
    return path[0];
  }

  Directory findRoot(FileSystemEntity entity) {
    final Directory parent = entity.parent;
    if (parent.path == entity.path) return parent;
    return findRoot(parent);
  }

  Future<int> getDirSize(Directory dir) async {
    var files = await dir.list(recursive: true).toList();
    var dirSize = files.fold(0, (int sum, file) => sum + file.statSync().size);
    return dirSize;
  }
}
