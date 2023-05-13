import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_twit/models/forex_model.dart';
import 'package:stock_twit/shared/cubit/cubit.dart';
import 'package:stock_twit/shared/cubit/states.dart';

class ForexScreen extends StatelessWidget {
  const ForexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forex'.toUpperCase(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.white.withOpacity(0.9)),),
        elevation: 0.0,
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<StockCubit,StockStates>( listener: (context,state){

      },
        builder: (context,state)=>ConditionalBuilder(condition: StockCubit.get(context).forexData !=null,
            builder:(context)=> Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(itemBuilder: (context,index)=>BuildForexItem(StockCubit.get(context).forexData!.data[index]),
                  separatorBuilder: (context,index)=>Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10.0),
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                  itemCount: StockCubit.get(context).forexData!.data.length),
            ),
            fallback: (context)=>CircularProgressIndicator())
         ),
    );
  }
  Widget BuildForexItem(Data model) =>Container(
    padding: EdgeInsets.all(20.0),
    child: Column(
      children: [
        Row(
          children: [
            Text('${model.ticker}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,),),
            Spacer(),
            Text('${model.high}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,),),

          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Text('${model.date}',style:TextStyle(color:Colors.grey,fontWeight: FontWeight.bold),),
            Spacer(),
            Text('${model.changes.toStringAsFixed(3)}',style:TextStyle(color:model.changes>0?Colors.green[300] : Colors.red[300],fontWeight: FontWeight.bold,),),


          ],
        )

      ],
    ),
  );
}
