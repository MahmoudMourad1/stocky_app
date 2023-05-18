import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:stock_twit/models/ticker_model.dart';

import 'package:stock_twit/shared/cubit/cubit.dart';
import 'package:stock_twit/shared/cubit/states.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TickerScreen extends StatelessWidget {
  const TickerScreen({
    super.key,
   required this.symbol,
    required this.from,
    required this.to,
  });

  final String symbol;
  final String from;
  final String to;


  @override

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>StockCubit()..GetTickerData(from: from, to: to, symbol: symbol),

      child: BlocConsumer<StockCubit,StockStates>(listener:(context,state){} ,builder:(context,state){
       TickerModel? ticker =StockCubit.get(context).tickerData;
       StockCubit.get(context).tooltipBehavior = TooltipBehavior(enable: true);
        return Scaffold(
          body: SafeArea(
            child: ConditionalBuilder(
              condition: ticker!=null,
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
              builder: (context)=>Column(
                children: [
                  //Instead of appbar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.grey.shade200.withOpacity(0.7),
                          ),
                          child: IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Icon(Icons.arrow_back)),
                        ),
                      ),
                      Spacer(),
                      CachedNetworkImage(
                        imageUrl: "https://fmpcloud.io/image-stock/${ticker!.symbol}.png",
                        placeholder: (context, url) => new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                        color: ticker.symbol=='AAPL'? Colors.black.withOpacity(0.78):null,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      // SizedBox(width: 10,),
                    Spacer(),
                      // Text('${ticker.symbol}',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900,color: Colors.black ))
                    ],
                  ),

                  //Drawing Chart

                  Container(
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      tooltipBehavior:StockCubit.get(context).tooltipBehavior ,
                      series: <ChartSeries>[
                        LineSeries<ChartData, String>(
                          enableTooltip: true,
                            dataSource: [
                              ChartData(ticker.data[0].date, ticker.data[0].open, Colors.black),
                              ChartData(ticker.data[1].date, ticker.data[1].open, Colors.green),
                              ChartData(ticker.data[2].date, ticker.data[2].open, Colors.black),
                              ChartData(ticker.data[3].date, ticker.data[3].open, Colors.black),
                              ChartData(ticker.data[4].date, ticker.data[4].open, Colors.black)
                            ],
                            pointColorMapper:(ChartData data, _) => data.color,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y),

                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),

        );
      }),



    );
  }

}
class ChartData {
  ChartData(this.x, this.y, this.color);
  final dynamic x;
  final dynamic y;
  final Color color;
}
