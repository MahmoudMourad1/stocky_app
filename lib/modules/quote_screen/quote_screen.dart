import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Stocky/models/quote_model.dart';
import 'package:Stocky/modules/quote_screen/custom_dateScreen.dart';
import 'package:Stocky/shared/components/components.dart';
import 'package:Stocky/shared/cubit/cubit.dart';
import 'package:Stocky/shared/cubit/states.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class QuoteScreen extends StatelessWidget {
  const QuoteScreen({
    super.key,
    required this.symbol,

  });

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context)=>StockCubit()..GetQuoteData(symbol: symbol),
       child: BlocConsumer<StockCubit,StockStates>(

           listener:(context,state){} ,
           builder:(context,state){
             QuoteModel? quote =StockCubit.get(context).quoteData;
             final List<ChartData> chartData = [];
             StockCubit.get(context).quoteData?.data.forEach((element) {
               chartData.add(ChartData(element.open, element.high, element.low, element.close,DateTime.parse(element.date)));
             });
             late ZoomPanBehavior _zoomPanBehavior;
             _zoomPanBehavior = ZoomPanBehavior(

                 enableDoubleTapZooming: true,
                 enablePinching: true,
                 // Enables the selection zooming
                 enableSelectionZooming: true
             );
             print(chartData.length);
             List<String> statistic=['Open','High','Low','Close'];
             List<dynamic> statisticsdata=[quote?.data[0].open,quote?.data[0].high,quote?.data[0].low,quote?.data[0].close];
             return SafeArea(child: Scaffold(

               backgroundColor: Colors.white,
               body:SingleChildScrollView(
                 child:Column(
                   children: [
                     Container(
                       decoration: BoxDecoration(
                           color: Colors.black,
                           borderRadius: BorderRadius.only(bottomRight: Radius.circular(90))
                       ),

                       child: Column(
                         children: [
                           SizedBox(height:20.h),
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical:10.0),
                             child: Container(
                               height: 80.h,
                               color: Colors.transparent,
                               child: Stack(
                                 children: [
                                   Center(
                                     child: CachedNetworkImage(
                                       imageUrl: "https://fmpcloud.io/image-stock/${symbol}.png",
                                       placeholder: (context, url) => new CircularProgressIndicator(),
                                       errorWidget: (context, url, error) => new Icon(Icons.error),

                                       height: 80.h,
                                       width: 80.w,
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
                           ),
                           SizedBox(height:20.h),
                           Padding(
                             padding: const EdgeInsets.all(2.0),
                             child:  Center(
                               child: Container(
                                   child: SfCartesianChart(
                                       borderColor: Colors.black,
                                       borderWidth: 0,
                                       plotAreaBorderWidth: 0,
                                       zoomPanBehavior: _zoomPanBehavior,
                                       primaryXAxis: DateTimeAxis(
                                         majorGridLines: MajorGridLines(width: 0),

                                       ),

                                       primaryYAxis: NumericAxis(
                                         majorGridLines: MajorGridLines(width: 0),

                                       ),
                                       series: <ChartSeries>[
                                         // Renders CandleSeries
                                         CandleSeries<ChartData, DateTime>(
                                           dataSource: chartData,
                                           xValueMapper: (ChartData data, _) => data.date,
                                           lowValueMapper: (ChartData data, _) => data.low,
                                           highValueMapper: (ChartData data, _) => data.high,
                                           openValueMapper: (ChartData data, _) => data.open,
                                           closeValueMapper: (ChartData data, _) => data.close,

                                         )
                                       ]
                                   )
                               ),

                             ),
                           ),
                           SizedBox(height: 60.h,),
                         ],
                       ),
                     ),
                     SizedBox(height: 20.h,),
                     Row(
                       children: [
                         Container(
                             alignment: Alignment.centerLeft,
                             padding: EdgeInsets.all(20.0),
                             child: Text('Statistics',style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.w600,color: Colors.blueGrey),)),
                         Spacer(),
                        ElevatedButton(onPressed: (){
                          NavigateTo(context, CustomDateScreen(symbol: symbol,));
                        },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey),
                            ),
                            child: Text('Custom Date')),
                         SizedBox(width: 20.w,),
                       ],
                     ),

                     // Padding(
                     //   padding: const EdgeInsets.all(10.0),
                     //   child: Container(
                     //     height: 150,
                     //     decoration: BoxDecoration(
                     //         color: Colors.white,
                     //         boxShadow: [
                     //           BoxShadow(
                     //               blurStyle: BlurStyle.inner,
                     //               color: Colors.grey.shade600,
                     //               spreadRadius: 0.5,
                     //               blurRadius: 10
                     //           )
                     //         ]
                     //     ),
                     //     child: Padding(
                     //       padding: const EdgeInsets.all(10.0),
                     //       child: Row(
                     //         children: [
                     //           Column(children: [
                     //             Text('open',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                     //             SizedBox(height: 4,),
                     //             Text('${quote?.data[0].open}',style: TextStyle(color: Colors.yellow,fontSize: 20,fontWeight: FontWeight.w900),),
                     //             Spacer(),
                     //             Text('close',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                     //             SizedBox(height: 4,),
                     //             Text('${quote?.data[0].close}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900),),
                     //           ],),
                     //           Spacer(),
                     //           Column(children: [
                     //             Text('high',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                     //             SizedBox(height: 4,),
                     //             Text('${quote?.data[0].high}',style: TextStyle(color: Colors.pinkAccent,fontSize: 20,fontWeight: FontWeight.w900),),
                     //             Spacer(),
                     //             Text('Avg.Volume',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                     //             SizedBox(height: 4,),
                     //             Text('${quote?.data[0].close}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900),),
                     //           ],),
                     //           Spacer(),
                     //           Column(children: [
                     //             Text('low',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                     //             SizedBox(height: 4,),
                     //             Text('${quote?.data[0].low}',style: TextStyle(color: Colors.lightBlueAccent,fontSize: 20,fontWeight: FontWeight.w900),),
                     //             Spacer(),
                     //             Text('change',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                     //             SizedBox(height: 4,),
                     //             Text('${quote?.data[0].high}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900),),
                     //           ],),
                     //         ],
                     //       ),
                     //     ),
                     //   ),
                     // ),

                     SizedBox(height: 30,),
                     Container(
                       height: 120,
                       child: ListView.separated
                         ( scrollDirection: Axis.horizontal,
                           physics: BouncingScrollPhysics(),
                           itemBuilder: (context,index)=>Container(
                             width: 120.w,
                             height: 120.h,
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(20),
                               boxShadow: [

                                 BoxShadow(
                                   color: Colors.grey.shade300,
                                   offset: const Offset(
                                     5.0,
                                     5.0,
                                   ),
                                   blurRadius: 8.0,
                                   spreadRadius: 2.0,
                                 ), //BoxShadow
                                 BoxShadow(
                                   color: Colors.white,
                                   offset: const Offset(0.0, 0.0),
                                   blurRadius: 0.0,
                                   spreadRadius: 0.0,
                                 ), //BoxShadow
                               ],
                             ),
                             child:Column(

                               children: [
                                 SizedBox(height: 15.h,),
                                 Text('${statisticsdata[index]}',style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.w900,color: Colors.black),),
                                 Spacer(),
                                 Text('${statistic[index]}',style: TextStyle(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.w400),),
                                 SizedBox(height: 15.h,),
                               ],
                             ),
                           ),
                           separatorBuilder: (context,index)=>SizedBox(width: 20.w,),
                           itemCount: statistic.length),
                     )
                   ],
                 ),
               ),
             )
             );
           }
    ));
  }
}
class ChartData {
  ChartData(this.open, this.high, this.low,this.close,this.date);
  final dynamic date;
  final dynamic open;
  final dynamic high;
  final dynamic low;
  final dynamic close;

}
