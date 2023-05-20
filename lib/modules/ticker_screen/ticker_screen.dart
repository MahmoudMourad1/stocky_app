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
       if(ticker?.symbol=='TSLA'){
         StockCubit.get(context).drop=<DateTime>[
           DateTime(2023, 07, 30),
           DateTime(2021,10,25),
           DateTime(2022,01,20),
           DateTime(2022,05,09),
           DateTime(2021,07,21),
           DateTime(2022,09,30),
           DateTime(2022,12,12),
         ];
       }else if(ticker?.symbol=='GOOGL'){
         StockCubit.get(context).drop=<DateTime>[
           DateTime(2023, 03, 17),
           DateTime(2022,09, 16),
           DateTime(2022,04, 25),
           DateTime(2022,01, 05),
           DateTime(2021,07, 23),
         ];
       }else if(ticker?.symbol=='AMZN'){
         StockCubit.get(context).drop=<DateTime>[
           DateTime(2023,01, 13),
           DateTime(2022,04, 26),
           DateTime(2022,10, 31),

         ];
       }else if(ticker?.symbol=='FB'){
         //2021-06-25
         // 2021-09-28
         // 2022-02-04
         StockCubit.get(context).drop=<DateTime>[
           DateTime(2021, 06, 17),
           DateTime(2021,09, 28),
           DateTime(2022,02, 04),

         ];
       }else if(ticker?.symbol=='JNJ'){
         // 2021-07-26
         // 2021-09-14
         // 2021-12-15
         // 2022-03-14
         // 2022-08-12
         // 2022-10-24
         // 2023-01-27
         StockCubit.get(context).drop=<DateTime>[
           DateTime(2023, 01, 27),
           DateTime(2022,10, 24),
           DateTime(2022,08, 12),
           DateTime(2022,03, 14),
           DateTime(2021,12, 15),
           DateTime(2021,09, 14),
           DateTime(2021,07, 26),
         ];
       }else if(ticker?.symbol=='JPM'){
         //2022-02-28
         // 2022-04-26
         // 2022-10-31
         StockCubit.get(context).drop=<DateTime>[
           DateTime(2023, 10, 31),
           DateTime(2022,04, 26),
           DateTime(2022,02, 28),

         ];
       }else if(ticker?.symbol=='MSFT'){
         //2021-07-02
         // 2021-10-26
         // 2022-01-06
         // 2022-04-19
         // 2022-09-19
         // 2023-01-27
         // 2023-03-20
         StockCubit.get(context).drop=<DateTime>[
           DateTime(2023, 03, 20),
           DateTime(2023,01, 27),
           DateTime(2022,09, 19),
           DateTime(2022,04, 19),
           DateTime(2022,01, 06),
           DateTime(2022,19, 26),
           DateTime(2021,07, 02),

         ];
       }else if(ticker?.symbol=='NVDA'){
         //2021-08-23
         // 2021-11-02
         // 2022-01-13
         // 2022-04-26
         // 2022-09-02
         // 2022-11-07
         // 2023-01-27
         // 2023-03-20
         StockCubit.get(context).drop=<DateTime>[
           DateTime(2023, 03, 20),
           DateTime(2023,01, 27),
           DateTime(2022,11, 07),
           DateTime(2022,09, 02),
           DateTime(2022,04, 26),
           DateTime(2022,01, 13),
           DateTime(2021,11, 02),
           DateTime(2021,08, 23),
         ];
       }else if(ticker?.symbol=='PFE'){
         //2021-07-26
         // 2021-11-16
         // 2022-02-04
         // 2022-08-26
         // 2022-11-14
         // 2023-01-12
         // 2023-02-27
         StockCubit.get(context).drop=<DateTime>[
           DateTime(2023, 02, 27),
           DateTime(2023,01, 12),
           DateTime(2022,11, 14),
           DateTime(2022,08, 26),
           DateTime(2022,02, 04),
           DateTime(2021,07, 26),
           DateTime(2021,11, 16),
         ];
       }else if(ticker?.symbol=='PG'){
         //2021-07-26
         // 2021-12-08
         // 2022-05-17
         // 2022-09-02
         // 2022-11-21
         // 2023-01-20
         // 2023-03-27
         StockCubit.get(context).drop=<DateTime>[
           DateTime(2023, 03, 27),
           DateTime(2023,01, 20),
           DateTime(2022,11, 21),
           DateTime(2022,09, 02),
           DateTime(2022,05, 17),
           DateTime(2021,12, 08),
           DateTime(2021,07, 26),
         ];
       }else if(ticker?.symbol=='V'){
         //2021-10-26
         // 2022-05-03
         // 2022-09-19
         // 2022-10-24
         // 2023-01-05
         StockCubit.get(context).drop=<DateTime>[
           DateTime(2023, 01, 05),
           DateTime(2022,10, 24),
           DateTime(2022,09, 19),
           DateTime(2022,05, 03),
           DateTime(2021,10, 26),
         ];
       }else if(ticker?.symbol=='XOM'){
         // 2022-01-13
         // 2022-04-11
         // 2022-10-17
         StockCubit.get(context).drop=<DateTime>[
           DateTime(2022, 10, 17),
           DateTime(2022,04, 11),
           DateTime(2022,01, 13),
         ];
       }else if(ticker?.symbol=='TWTR'){
         // 2022-01-13
         // 2022-04-11
         // 2022-10-17
         StockCubit.get(context).drop=<DateTime>[
           DateTime(2021, 02, 11),
           DateTime(2022,06, 01),
           DateTime(2022,04, 04),
           DateTime(2022,10, 05),
           DateTime(2022,04, 10),

         ];
       }


       final List<ChartData> chartData = [];
       StockCubit.get(context).tickerData?.data.forEach((element) {
         chartData.add(ChartData(element.date, element.open, element.date==StockCubit.get(context).dropdownValue?(element.change>0?Colors.green:Colors.red):Colors.grey.shade400));
       });
       List<ChartData> chartDat=List.from(chartData.reversed);

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ConditionalBuilder(
              condition: ticker!=null,
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
              builder: (context)=>SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(


                  children: [
                    //Instead of appbar
                   Container(
                     height: 80,
                     color: Colors.transparent,
                     child: Stack(
                       children: [
                         Center(
                          child: CachedNetworkImage(
                             imageUrl: "https://fmpcloud.io/image-stock/${ticker!.symbol}.png",
                             placeholder: (context, url) => new CircularProgressIndicator(),
                             errorWidget: (context, url, error) => new Icon(Icons.error),
                             color: ticker.symbol=='AAPL'||ticker.symbol=='V'? Colors.black.withOpacity(0.78):null,
                             height: 80,
                             width: 80,
                             fit: BoxFit.cover,
                           ),
                         ),
                         Positioned
                           (child: Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(50.0),
                               color: Colors.grey.shade200.withOpacity(0.7),
                             ),
                             child: IconButton(onPressed: (){
                               Navigator.pop(context);
                             }, icon: Icon(Icons.arrow_back)),
                         ),
                           ),)
                       ],
                     ),
                   ),

                    //Drawing Chart

                    Container(
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        tooltipBehavior:StockCubit.get(context).tooltipBehavior ,
                        series: <ChartSeries>[
                          LineSeries<ChartData, String>(
                            enableTooltip: true,
                              width: 3,
                              dataSource: chartDat,
                              pointColorMapper:(ChartData data, _) => data.color,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y),
                          ScatterSeries<ChartData, String>(
                              dataSource: chartData,
                              pointColorMapper:(ChartData data, _) => data.color,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y
                          )

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

                   var dateTime=DateFormat("yyyy-MM-dd").parse(value);
                    var formate2 = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
                    // print(formate2);
                    // print(formate2.runtimeType);
                    var from = new DateTime(dateTime.year, dateTime.month, dateTime.day-10);
                    var to=new DateTime(dateTime.year, dateTime.month, dateTime.day+10);

                    String zero1;
                    String zerod1;
                    from.month<10?zero1='0':zero1='';
                    from.day<10?zerod1='0':zerod1='';
                    String zero2;
                    String zerod2;
                    print('from : ${from.year}-${zero1}${from.month}-${from.day}');
                    print(' to: "${to.year}-${zero1}${to.month}-${to.day}');
                    to.month<10?zero2='0':zero2='';
                    to.day<10?zerod2='0':zerod2='';


                    print('from : ${from.year}-${zero1}${from.month}-${zerod1}${from.day}');
                    print(' to: "${to.year}-${zero2}${to.month}-${zerod2}${to.day}');
                    StockCubit.get(context).GetTickerData(from: "${from.year}-${zero1}${from.month}-${zerod1}${from.day}", to: "${to.year}-${zero2}${to.month}-${zerod2}${to.day}", symbol: symbol);

                  },
                  onTap: (){

                    ticker.data.forEach((element) {
                      print(element.date);
                    });
                  },
                  items: StockCubit.get(context).drop.map<DropdownMenuItem<String>>((DateTime value) {
                    return DropdownMenuItem<String>(

                      value: DateFormat("yyyy-MM-dd").format(value).toString(),
                      child: Text(DateFormat("yyyy-MM-dd").format(value).toString(),),

                    );
                  }).toList(),),



                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(20.0),
                        child: Text('Statistics',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.blueGrey),)),

                    ListView.separated(

                        reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurStyle: BlurStyle.inner,
                                        color: Colors.grey.shade600,
                                        spreadRadius: 0.5,
                                        blurRadius: 10
                                    )
                                  ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Column(children: [
                                      Text('open',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                                      SizedBox(height: 4,),
                                      Text('${ticker.data[index].open}',style: TextStyle(color: Colors.yellow,fontSize: 20,fontWeight: FontWeight.w900),),
                                      Spacer(),
                                      Text('close',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                                      SizedBox(height: 4,),
                                      Text('${ticker.data[index].close}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900),),
                                    ],),
                                    Spacer(),
                                    Column(children: [
                                      Text('high',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                                      SizedBox(height: 4,),
                                      Text('${ticker.data[index].high}',style: TextStyle(color: Colors.pinkAccent,fontSize: 20,fontWeight: FontWeight.w900),),
                                      Spacer(),
                                      Text('Avg.Volume',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                                      SizedBox(height: 4,),
                                      Text('${ticker.data[index].vwap}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900),),
                                    ],),
                                    Spacer(),
                                    Column(children: [
                                      Text('low',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                                      SizedBox(height: 4,),
                                      Text('${ticker.data[index].low}',style: TextStyle(color: Colors.lightBlueAccent,fontSize: 20,fontWeight: FontWeight.w900),),
                                      Spacer(),
                                      Text('change',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                                      SizedBox(height: 4,),
                                      Text('${ticker.data[index].change}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900),),
                                    ],),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context,index)=>Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                          child: Text('${ticker.data[index].date}',style: TextStyle(fontSize: 15),),
                        ),
                        itemCount: ticker.data.length)
                  ],
                ),
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

