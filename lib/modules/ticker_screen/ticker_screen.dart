import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stock_twit/models/ticker_model.dart';

import 'package:stock_twit/shared/cubit/cubit.dart';
import 'package:stock_twit/shared/cubit/states.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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
      create: (BuildContext context)=>StockCubit()..GetTickerData(from: from, to: to, symbol: symbol)..LoadAssetsCsv(symbol: symbol),

      child: BlocConsumer<StockCubit,StockStates>(listener:(context,state){} ,builder:(context,state){
       TickerModel? ticker =StockCubit.get(context).tickerData;
       StockCubit.get(context).tooltipBehavior = TooltipBehavior(enable: true);




       final List<ChartData> chartData = [];
       StockCubit.get(context).tickerData?.data.forEach((element) {
         chartData.add(ChartData(element.date, element.open, element.date==StockCubit.get(context).dropdownValue?(element.change>0?Colors.green:Colors.red):Colors.grey.shade400));
       });
       List<ChartData> chartDat=List.from(chartData.reversed);
       final List<Statistics> statistics = [];
       StockCubit.get(context).tickerData?.data.forEach((element) {
         statistics.add(Statistics(element.date, element.open,element.high, element.low, element.close,element.volume ,element.change));
       });
       late EmployeeDataSource _employeeDataSource;
       _employeeDataSource = EmployeeDataSource(statistics: statistics);
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ConditionalBuilder(
              condition: ticker!=null,
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
              builder: (context)=>SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //Instead of appbar
                   Padding(
                     padding: const EdgeInsets.symmetric(vertical: 10.0),
                     child: Container(
                       height: 80.h,
                       color: Colors.transparent,
                       child: Stack(
                         children: [
                           Center(
                            child: CachedNetworkImage(
                               imageUrl: "https://fmpcloud.io/image-stock/${ticker!.symbol}.png",
                               placeholder: (context, url) => new CircularProgressIndicator(),
                               errorWidget: (context, url, error) => new Icon(Icons.error),
                               color: ticker.symbol=='AAPL'||ticker.symbol=='V'? Colors.black.withOpacity(0.78):null,
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

                    //Drawing Chart

                    Container(
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        tooltipBehavior:StockCubit.get(context).tooltipBehavior ,
                        series: <ChartSeries>[
                          LineSeries<ChartData, String>(
                            enableTooltip: true,
                              width: 3.w,
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


                    int index=StockCubit.get(context).critical.indexOf(value);

                    StockCubit.get(context).GetTickerData(from: StockCubit.get(context).before[index], to:StockCubit.get(context).after[index], symbol: symbol);

                  },
                  onTap: (){

                    // ticker.data.forEach((element) {
                    //   print(element.date);
                    // });
                  },
                  items: StockCubit.get(context).critical.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(

                      value: value.toString(),
                      child: Text(value.toString(),),

                    );
                  }).toList(),),



                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(10.0),
                        child: Text('Statistics',style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.w600,color: Colors.blueGrey),)),

                    // ListView.separated(
                    //
                    //     reverse: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     itemBuilder: (context,index){
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    //         child: Container(
                    //           height: 150,
                    //           decoration: BoxDecoration(
                    //             color: Colors.white,
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                   blurStyle: BlurStyle.inner,
                    //                     color: Colors.grey.shade600,
                    //                     spreadRadius: 0.5,
                    //                     blurRadius: 10
                    //                 )
                    //               ]
                    //           ),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(20.0),
                    //             child: Row(
                    //               children: [
                    //                 Column(children: [
                    //                   Text('open',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                    //                   SizedBox(height: 4,),
                    //                   Text('${ticker.data[index].open}',style: TextStyle(color: Colors.yellow,fontSize: 20,fontWeight: FontWeight.w900),),
                    //                   Spacer(),
                    //                   Text('close',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                    //                   SizedBox(height: 4,),
                    //                   Text('${ticker.data[index].close}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900),),
                    //                 ],),
                    //                 Spacer(),
                    //                 Column(children: [
                    //                   Text('high',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                    //                   SizedBox(height: 4,),
                    //                   Text('${ticker.data[index].high}',style: TextStyle(color: Colors.pinkAccent,fontSize: 20,fontWeight: FontWeight.w900),),
                    //                   Spacer(),
                    //                   Text('Avg.Volume',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                    //                   SizedBox(height: 4,),
                    //                   Text('${ticker.data[index].vwap}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900),),
                    //                 ],),
                    //                 Spacer(),
                    //                 Column(children: [
                    //                   Text('low',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                    //                   SizedBox(height: 4,),
                    //                   Text('${ticker.data[index].low}',style: TextStyle(color: Colors.lightBlueAccent,fontSize: 20,fontWeight: FontWeight.w900),),
                    //                   Spacer(),
                    //                   Text('change',style: TextStyle(color: Colors.grey.shade500,fontSize: 18),),
                    //                   SizedBox(height: 4,),
                    //                   Text('${ticker.data[index].change}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900),),
                    //                 ],),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //     separatorBuilder: (context,index)=>Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                    //       child: Text('${ticker.data[index].date}',style: TextStyle(fontSize: 15),),
                    //     ),
                    //     itemCount: ticker.data.length)

                    SfDataGrid(
                      source: _employeeDataSource,
                      selectionMode: SelectionMode.multiple,
                      allowSorting: true,

                      allowTriStateSorting: true,
                      defaultColumnWidth: 80.w,
                      columns: [
                        GridColumn(

                            columnName: 'date',
                            label: Container(

                              alignment: Alignment.center,
                                child: Text(
                                  'DATE',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridColumn(
                            columnName: 'open',
                            label: Container(

                                alignment: Alignment.center,
                                child: Text(
                                  'open',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridColumn(
                            columnName: 'high',
                            label: Container(

                                alignment: Alignment.center,
                                child: Text(
                                  'high',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridColumn(
                            columnName: 'low',
                            label: Container(

                                alignment: Alignment.center,

                                child: Text(
                                  'low',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridColumn(
                            columnName: 'close',
                            label: Container(

                                alignment: Alignment.center,
                                child: Text(
                                  'close',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridColumn(
                            columnName: 'volume',
                            label: Container(

                                alignment: Alignment.center,
                                child: Text(
                                  'volume',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridColumn(
                            columnName: 'change',
                            label: Container(
                                alignment: Alignment.center,

                                child: Text(
                                  'change',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                      ],
                    ),


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

class Statistics {
  Statistics(this.date,this.open ,this.high, this.low, this.close,this.volume,this.change);
  final dynamic date;
  final dynamic open;
  final dynamic high;
  final dynamic low;
  final dynamic close;
  final dynamic volume;
  final dynamic change;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Statistics> statistics}) {

    dataGridRows = statistics
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
      DataGridCell<dynamic>(columnName: 'Date', value: dataGridRow.date),
      DataGridCell<dynamic>(columnName: 'open', value: dataGridRow.open),
      DataGridCell<dynamic>(columnName: 'high', value: dataGridRow.high),
      DataGridCell<dynamic>(
          columnName: 'low', value: dataGridRow.low),
      DataGridCell<dynamic>(
          columnName: 'close', value: dataGridRow.close),
      DataGridCell<dynamic>(columnName: 'volume', value: dataGridRow.volume),
      DataGridCell<dynamic>(
          columnName: 'change', value: dataGridRow.change),
    ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    Color getRowBackgroundColor() {
      final int index = effectiveRows.indexOf(row);
      if (index == 5) {
        return Colors.blueGrey[100]!;
      }

      return Colors.transparent;
    }
    return DataGridRowAdapter(
        color: getRowBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
              alignment: Alignment.center,

              child: Text(
                dataGridCell.value.toString(),
                overflow: TextOverflow.ellipsis,
              ));
        }).toList());
  }
}