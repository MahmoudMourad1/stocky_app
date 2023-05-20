import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_twit/models/quote_model.dart';
import 'package:stock_twit/shared/cubit/cubit.dart';
import 'package:stock_twit/shared/cubit/states.dart';
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

             print(chartData.length);
             return SafeArea(child: Scaffold(

               body:SingleChildScrollView(
                 child: Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical:10.0),
                       child: Container(
                         height: 80,
                         color: Colors.transparent,
                         child: Stack(
                           children: [
                             Center(
                               child: CachedNetworkImage(
                                 imageUrl: "https://fmpcloud.io/image-stock/${symbol}.png",
                                 placeholder: (context, url) => new CircularProgressIndicator(),
                                 errorWidget: (context, url, error) => new Icon(Icons.error),

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
                     ),
                     Center(
                         child: Container(
                             child: SfCartesianChart(
                                 primaryXAxis: DateTimeAxis(),
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
                     Container(
                         alignment: Alignment.centerLeft,
                         padding: EdgeInsets.all(20.0),
                         child: Text('Statistics',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.blueGrey),)),
                     SizedBox(height: 10,),
                     Padding(
                       padding: const EdgeInsets.all(10.0),
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
                           padding: const EdgeInsets.all(10.0),
                           child: Row(
                             children: [
                               Column(children: [
                                 Text('open',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                                 SizedBox(height: 4,),
                                 Text('${quote?.data[0].open}',style: TextStyle(color: Colors.yellow,fontSize: 20,fontWeight: FontWeight.w900),),
                                 Spacer(),
                                 Text('close',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                                 SizedBox(height: 4,),
                                 Text('${quote?.data[0].close}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900),),
                               ],),
                               Spacer(),
                               Column(children: [
                                 Text('high',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                                 SizedBox(height: 4,),
                                 Text('${quote?.data[0].high}',style: TextStyle(color: Colors.pinkAccent,fontSize: 20,fontWeight: FontWeight.w900),),
                                 Spacer(),
                                 Text('Avg.Volume',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                                 SizedBox(height: 4,),
                                 Text('${quote?.data[0].close}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900),),
                               ],),
                               Spacer(),
                               Column(children: [
                                 Text('low',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                                 SizedBox(height: 4,),
                                 Text('${quote?.data[0].low}',style: TextStyle(color: Colors.lightBlueAccent,fontSize: 20,fontWeight: FontWeight.w900),),
                                 Spacer(),
                                 Text('change',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                                 SizedBox(height: 4,),
                                 Text('${quote?.data[0].high}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900),),
                               ],),
                             ],
                           ),
                         ),
                       ),
                     ),
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
