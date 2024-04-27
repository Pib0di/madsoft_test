import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madsoft_test/core/api/rest_client.dart';
import 'package:madsoft_test/core/models/json_parser.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:system_info/system_info.dart';

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

    final imageParam = await _getImageParam();

    emit(state.copyWith(
      listPoints: listPoints,
      imageParam: imageParam,
    ));
  }

  _onGetJson(GetJson event, Emitter<HomePageState> emit) async {
    final jsonParser = await _rest.getJsonParser();

    print('getTotalPhysicalMemory   : ${SysInfo.getTotalPhysicalMemory() ~/ 1} Gb');
    print('getFreePhysicalMemory   : ${SysInfo.getFreePhysicalMemory() ~/ 1} Gb');

    emit(HomePageState(
      jsonParser: jsonParser,
      memoryAfterPhotos: (SysInfo.getFreePhysicalMemory() / 1073741824).toDouble(),
      totalDiskSpace: (SysInfo.getTotalPhysicalMemory() / 1073741824 ).toDouble(),
    ));
  }

  Future<ImageParam> _getImageParam() async {
    ByteData data = await rootBundle.load('assets/images/mock_scheme.png');

    var decodedImage = await decodeImageFromList(data.buffer.asUint8List());

    return ImageParam(
      width: decodedImage.width.toDouble() ,
      height:  decodedImage.height.toDouble(),
    );
  }
}

class ImageParam{
  final double width;
  final double height;

  const ImageParam({
    this.width = 300,
    this.height = 300,
  });
}

