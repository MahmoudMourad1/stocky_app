
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:stock_twit/modules/home_screen/home_screen.dart';
import 'package:stock_twit/shared/bloc_observer.dart';
import 'package:stock_twit/shared/cubit/cubit.dart';
import 'package:stock_twit/shared/network/remote/dio_helpers.dart';

import 'package:google_fonts/google_fonts.dart';
import 'modules/home_screen/splash_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);




  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // void initState() {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>StockCubit()..GetMostGainerData()..GetMostActivesData()..GetMostLoserData()..GetforexData()..GetNewsData(size: 10)..GetEtfData()..GetCryptoData()..GetStockSymbolData()..GetTickerData(from: '2021-07-28', to: '2021-08-3',symbol: 'TSLA'),)
      ],
      child: MaterialApp(
        theme: ThemeData(
          // fontFamily: GoogleFonts.abrilFatface().fontFamily,
          appBarTheme: AppBarTheme(

            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              statusBarIconBrightness: Brightness.light,
            ),

          ),


        ),

        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

