import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_twit/modules/home_screen/home_screen.dart';
import 'package:stock_twit/shared/bloc_observer.dart';
import 'package:stock_twit/shared/cubit/cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>StockCubit()..GetMostGainerData()..GetMostActivesData()..GetMostLoserData()..GetforexData()..GetNewsData()..GetEtfData()..GetCryptoData()..GetStockSymbolData()..GetTickerData(from: '2021-07-28', to: '2021-08-3',symbol: 'TSLA'),)
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(

            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),

          ),


        ),

        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

