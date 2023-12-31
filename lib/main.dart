
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Stocky/modules/home_screen/home_screen.dart';
import 'package:Stocky/shared/bloc_observer.dart';
import 'package:Stocky/shared/cubit/cubit.dart';
import 'package:Stocky/shared/network/remote/dio_helpers.dart';


import 'modules/home_screen/splash_screen.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();



  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // void initState() {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child){
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context)=>StockCubit()..GetMostGainerData()..GetMostActivesData()..GetMostLoserData()..GetforexData()..GetNewsData(size: 10)..GetEtfData()..GetCryptoData()..GetStockSymbolData()..GetTickerData(from: '2021-07-28', to: '2021-08-3',symbol: 'TSLA'),)
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
            home: HomeScreen(),
          ),
        );
      },
    );
  }
}

