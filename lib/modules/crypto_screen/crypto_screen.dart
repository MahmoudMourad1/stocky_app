import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_twit/models/crypto_model.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';


class CryptoScreen extends StatelessWidget {
  const CryptoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto'.toUpperCase(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.white.withOpacity(0.9)),),
        elevation: 0.0,
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<StockCubit,StockStates>( listener: (context,state){

      },
          builder: (context,state)=>ConditionalBuilder(
              condition: StockCubit.get(context).cryptData?.data !=null  ,
              builder:(context)=> Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(itemBuilder: (context,index)=>BuildEtfItem(StockCubit.get(context).cryptData!.data[index]),
                    separatorBuilder: (context,index)=>Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10.0),
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                    itemCount: StockCubit.get(context).cryptData!.data.length),
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator()))
      ),
    );
  }

  Widget BuildEtfItem(Data model) =>Container(
    padding: EdgeInsets.all(15.0),
    child: Column(
      children: [

        Row(

          children: [

            Text('${model.symbol}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,),),
            Spacer(),
            Text('${model.dataUSD?.price}',style:TextStyle(color:Colors.grey,fontWeight: FontWeight.bold),),


          ],
        ),
       SizedBox(height: 10,),
        Row(


          children: [
            Text('${model.name}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,),),
            Spacer(),
            Text('${model.dataUSD?.volume_change_24h}',style:TextStyle(color:Colors.grey,fontWeight: FontWeight.bold,),),


          ],
        )

      ],
    ),
  );
}
