import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madsoft_test/core/models/json_parser.dart';
import 'package:madsoft_test/ui/pages/home_page/bloc/home_page_bloc.dart';
import 'package:madsoft_test/ui/pages/home_page/widgets/display_scheme.dart';
import 'package:madsoft_test/ui/pages/home_page/widgets/object_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Payload> filteredItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
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
              return BlocBuilder<HomePageBloc, HomePageState>(
                buildWhen: (prev, curr) {
                  if (curr.jsonParser?.payload != null) {
                    filteredItems = curr.jsonParser!.payload;
                  }
                  return true;
                },
                builder: (context, state) {
                  if (state.jsonParser == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return MaterialApp(
                    supportedLocales: const [
                      Locale('en'),
                      Locale('ru'),
                    ],
                    theme: ThemeData(
                      textTheme: GoogleFonts.robotoTextTheme(),
                    ),
                    home: Material(
                      color: Colors.blue[50],
                      child: CustomScrollView(
                        slivers: [
                          SliverPersistentHeader(
                            delegate: CustomSliverAppBar(
                              expandedHeight: 200.0,
                              searchController: searchController,
                            ),
                            pinned: true,
                            floating: true,
                          ),
                          state.jsonParser == null
                              ? const Center(child: CircularProgressIndicator())
                              : SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          top: 16.0,
                                          right: 8,
                                          left: 8,
                                        ),
                                        child: ObjectCard(
                                          onTap: () => _onTap.call(index, context),
                                          title: filteredItems[index].title,
                                          memoryAfterPhotos: state.memoryAfterPhotos +
                                              filteredItems[index].total_points_count * 0.000977,
                                          availableMemory: state.totalDiskSpace ?? 0.0,
                                          totalPointsCount: filteredItems[index].total_points_count,
                                          remainingPoints: filteredItems[index].remaining_points,
                                        ),
                                      );
                                    },
                                    childCount: filteredItems.length,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _onSearchChanged() {
    final payload = context.read<HomePageBloc>().state.jsonParser?.payload ?? [];
    String searchText = searchController.text.toLowerCase();
    setState(() {
      filteredItems =
          payload.where((item) => item.title.toLowerCase().contains(searchText)).toList();
    });
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

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final TextEditingController searchController;

  CustomSliverAppBar({
    required this.expandedHeight,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool isExpanded = shrinkOffset + 100 < expandedHeight;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: isExpanded ? Colors.blue[50] : Colors.white,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: isExpanded
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            Text(
                              'Объекты',
                              style: TextStyle(
                                fontSize: 26,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.warning),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(16))),
                          child: Row(
                            children: [
                              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                              Expanded(
                                child: TextFormField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0.0,
                                      horizontal: 10,
                                    ),
                                    fillColor: Colors.white,
                                    focusColor: Colors.white30,
                                    hintText: 'Найти',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {}, icon: const Icon(Icons.logo_dev_rounded)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Объекты',
                              style: TextStyle(
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                        const Icon(Icons.warning),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
