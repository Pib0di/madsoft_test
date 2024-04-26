import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madsoft_test/ui/pages/home_page/bloc/home_page_bloc.dart';

class DisplayScheme extends StatefulWidget {
  const DisplayScheme({super.key});

  @override
  State<DisplayScheme> createState() => _DisplaySchemeState();
}

class _DisplaySchemeState extends State<DisplayScheme> {
  double x = 100;
  double y = 100;

  double width = 1200;
  double height = 1200;

  double _scale = 1;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          return GestureDetector(
            onScaleUpdate: _onScaleUpdate,
            child: Stack(
              children: [
                Positioned(
                  top: y,
                  left: x,
                  child: Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.asset('assets/images/mock_scheme.png').image,
                      ),
                    ),
                    child: Stack(
                      children: state.listPoints
                          .map(
                            (e) => e.status == 'completed'
                                ? Positioned(
                                    left: e.x.toDouble(),
                                    top: e.y.toDouble(),
                                    child: const Icon(
                                      Icons.add_circle,
                                      color: Colors.greenAccent,
                                    ),
                                  )
                                : Positioned(
                                    left: e.x.toDouble(),
                                    top: e.y.toDouble(),
                                    child: const Icon(
                                      Icons.camera,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                          )
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _onScaleUpdate(ScaleUpdateDetails details) {
    print(details.focalPoint.dx);
    print(details.scale);
    setState(() {
      x += details.focalPointDelta.dx;
      y += details.focalPointDelta.dy;

      width *= details.scale;
      height *= details.scale;
    });
  }
}
