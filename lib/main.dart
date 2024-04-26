import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madsoft_test/core/api/rest_client.dart';
import 'package:madsoft_test/ui/pages/home_page/bloc/home_page_bloc.dart';
import 'package:madsoft_test/ui/pages/home_page/home_page.dart';

void main() {
  runApp(RepositoryProvider(
    create: (context) => RestClient(Dio()),
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(context.read())..add(GetJson()),
      child: const HomePage(),
    );
  }
}
