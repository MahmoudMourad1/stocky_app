
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:Stocky/shared/cubit/cubit.dart';
import 'package:Stocky/shared/cubit/states.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CustomDateScreen extends StatelessWidget {

  const CustomDateScreen({
    super.key,
    required this.symbol,

  });

  final String symbol;
  @override
  Widget build(BuildContext context) {
    var datecontroller=TextEditingController();
    late String fromDate;
    late String toDate;
     return BlocProvider(
       create: (BuildContext context)=>StockCubit(),
       child: BlocConsumer<StockCubit,StockStates>(
         listener:(context,state){} ,
    builder:(context,state){
      final List<Statistics> statistics = [];
      StockCubit.get(context).tickerData?.data.forEach((element) {
        statistics.add(Statistics(element.date, element.open,element.high, element.low, element.close,element.volume ,element.change));
      });
      late EmployeeDataSource _employeeDataSource;
      _employeeDataSource = EmployeeDataSource(statistics: statistics);
           return Scaffold(
             appBar:AppBar (
               backgroundColor: Colors.black,
             ),
             body: Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     MaterialButton(
                         color: Colors.blueGrey,
                         child: Text('From'),
                         onPressed: (){
                           showDatePicker(
                               context: context,
                               initialDate: DateTime.now(),
                               firstDate: DateTime(1950),

                               lastDate: DateTime(2100)).then((value){

                             datecontroller.text=DateFormat.yMd().format(value!);
                             String zero1;
                             String zerod1;
                             value.month<10?zero1='0':zero1='';
                             value.day<10?zerod1='0':zerod1='';



                             fromDate ='${value.year}-${zero1}${value.month}-${zerod1}${value.day}';


                           });
                         }

                     ),
                     SizedBox(width: 30.w,),
                     MaterialButton(
                         color: Colors.blueGrey,
                         child: Text('To'),
                         onPressed: (){
                           showDatePicker(
                               context: context,
                               initialDate: DateTime.now(),
                               firstDate: DateTime(1950),

                               lastDate: DateTime(2100)).then((value){

                             datecontroller.text=DateFormat.yMd().format(value!);
                             String zero1;
                             String zerod1;
                             value.month<10?zero1='0':zero1='';
                             value.day<10?zerod1='0':zerod1='';



                             toDate ='${value.year}-${zero1}${value.month}-${zerod1}${value.day}';

                             print('${fromDate}');
                             print('${toDate}');
                             StockCubit.get(context).GetTickerData(from: '${fromDate.toString()}', to: '${toDate.toString()}', symbol: '${symbol}');
                           });

                         }

                     ),
                   ],
                 ),
                 Expanded(
                   child: Container(
                     child: SfDataGrid(
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
                   ),
                 )
               ],
             ),
           );
    },
       ),
     );

  }

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
