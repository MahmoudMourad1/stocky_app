import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
       StockCubit.get(context).drop=<String>['2021-07-30',
        '2021-10-25',
        '2022-01-20',
        '2022-05-09',
        '2022-07-21',
        '2022-09-30',
        '2022-12-12'];

       final List<ChartData> chartData = [];
       StockCubit.get(context).tickerData?.data.forEach((element) {
         chartData.add(ChartData(element.date, element.open, Colors.black));
       });

       List<ChartData> chartDat=List.from(chartData.reversed);

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
                            dataSource: chartDat,
                            pointColorMapper:(ChartData data, _) => data.color,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y),

                      ],
                    ),
                  ),

              DropdownButton<String>(
                alignment: Alignment.bottomCenter,
                value: StockCubit.get(context).dropdownValue,
                icon: const Icon(Icons.calendar_month),
                borderRadius: BorderRadius.circular(10.0),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),

                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  StockCubit.get(context).changeValue(value: value!);

                },
                onTap: (){
                  DateFormat('MM-dd-yyyy').parse(StockCubit.get(context).dropdownValue!);
                  print(DateFormat('MM-dd-yyyy').parse(StockCubit.get(context).dropdownValue!));

                },
                items: StockCubit.get(context).drop.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,),
                  );
                }).toList(),),



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
