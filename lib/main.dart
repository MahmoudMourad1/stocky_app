import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:stock_twit/modules/home_screen/home_screen.dart';
import 'package:stock_twit/shared/bloc_observer.dart';
import 'package:stock_twit/shared/network/remote/dio_helpers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

