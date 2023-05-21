import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_twit/modules/home_screen/home_screen.dart';
import 'package:stock_twit/shared/bloc_observer.dart';
import 'package:stock_twit/shared/cubit/cubit.dart';
import 'package:stock_twit/shared/network/remote/dio_helpers.dart';
import 'package:page_transition/page_transition.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>StockCubit()..GetMostGainerData()..GetMostActivesData()..GetMostLoserData()..GetforexData()..GetNewsData()..GetEtfData()..GetCryptoData()..GetStockSymbolData()..GetTickerData(from: '2021-07-28', to: '2021-08-3',symbol: 'TSLA'),)
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(

            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              statusBarIconBrightness: Brightness.light,
            ),

          ),


        ),

        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splashIconSize: 300,
          backgroundColor: Colors.black,

          pageTransitionType: PageTransitionType.leftToRight,
          splashTransition: SplashTransition.sizeTransition,
          curve: Curves.linear,

          splash:Column(
            children: [
               CircleAvatar(
                 backgroundColor: Colors.transparent,
                radius: 100,
                backgroundImage: AssetImage("assets/rm373batch9-021.jpg"),
              ),
              SizedBox(height: 10,),
              Text('STOCK MARKET',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900,color: Colors.white),)
            ],
          ) ,
          nextScreen: HomeScreen(),
        ),
      ),
    );
  }
}

