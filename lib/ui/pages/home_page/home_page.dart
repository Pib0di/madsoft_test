import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madsoft_test/ui/pages/home_page/bloc/home_page_bloc.dart';
import 'package:madsoft_test/ui/pages/home_page/widgets/display_scheme.dart';
import 'package:madsoft_test/ui/pages/home_page/widgets/object_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        scaffoldBackgroundColor: Color(0xFFECF0FD),
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(),
        ),
      ),
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: Colors.grey,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: Colors.blue,
              ),
              label: 'Объекты',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/sets.svg'),
              activeIcon: SvgPicture.asset(
                'assets/icons/sets.svg',
                color: Colors.blue,
              ),
              label: 'Сеты',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/profile.svg'),
              activeIcon: SvgPicture.asset(
                'assets/icons/profile.svg',
                color: Colors.blue,
              ),
              label: 'Профиль',
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
                if (state.jsonParser == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return MaterialApp(
                  theme: ThemeData(
                    textTheme: GoogleFonts.robotoTextTheme(),
                  ),
                  home: Material(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return ObjectCard(
                            onTap: () => _onTap.call(index, context),
                            title: state.jsonParser!.payload[index].title,
                            memoryAfterPhotos: state.memoryAfterPhotos +
                                state.jsonParser!.payload[index].total_points_count * 5,
                            availableMemory: state.totalDiskSpace ?? 0.0,
                            totalPointsCount: state.jsonParser!.payload[index].total_points_count,
                            remainingPoints: state.jsonParser!.payload[index].remaining_points,
                          );
                        },
                        itemCount: state.jsonParser!.payload.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 12),
                      ),
                    ),
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }

  _onTap(int index, BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const DisplayScheme(),
      ),
    );
    context.read<HomePageBloc>().add(OpenMockScheme(index));
  }
}
