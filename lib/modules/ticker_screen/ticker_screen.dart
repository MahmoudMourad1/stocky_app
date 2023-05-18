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
       StockCubit.get(context).drop=<DateTime>[
         DateTime(2023, 07, 30),
         DateTime(2021,10,25),
         DateTime(2022,01,20),
         DateTime(2022,05,09),
         DateTime(2021,07,21),
         DateTime(2022,09,30),
         DateTime(2022,12,12),
        ];


       final List<ChartData> chartData = [];
       StockCubit.get(context).tickerData?.data.forEach((element) {
         chartData.add(ChartData(element.date, element.open, element.date==StockCubit.get(context).dropdownValue?Colors.green:Colors.grey.shade400));
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
                              width: 3,
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
