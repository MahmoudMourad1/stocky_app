import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_twit/models/stock_model.dart';
import 'package:stock_twit/modules/quote_screen/quote_screen.dart';
import 'package:stock_twit/shared/components/components.dart';
import 'package:stock_twit/shared/cubit/cubit.dart';
import 'package:stock_twit/shared/cubit/states.dart';
class StockScreen extends StatelessWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<StockCubit,StockStates>(
      listener: (context,state){},
      builder: (context,state)=>DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
            appBar: AppBar(

              iconTheme: IconThemeData(color: Colors.white),

              title: Text('STOCKS'.toUpperCase(),style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.w600,color: Colors.white.withOpacity(1)),),

              elevation: 0.0,

              backgroundColor: Colors.black,

              bottom: TabBar(
                indicatorColor: Colors.blue,
                indicatorWeight: 5.w,
                tabs: <Widget>[

                  Tab(
                    child: Text('Top Gainer',style: TextStyle(fontSize: 15.sp,color: Colors.white)),

                  ),
                  Tab(
                    child: Text('Top Loser',style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                  ),
                  Tab(
                    child: Text('Top Actives',style: TextStyle(fontSize: 15.sp,color: Colors.white)),
                  ),
                ],
              ),
            ),
            body:TabBarView(children: <Widget>[

              ConditionalBuilder(condition: StockCubit.get(context).mostGainerData?.data!=null,

                  builder: (context)=> stockItem(StockCubit.get(context).mostGainerData!),
                  fallback: (context)=>Center(child: CircularProgressIndicator(),)),
              ConditionalBuilder(
                  condition: StockCubit.get(context).mostLoserData?.data!=null, builder: (context)=> stockItem(StockCubit.get(context).mostLoserData!),
                  fallback: (context)=>Center(child: CircularProgressIndicator(),)),
             ConditionalBuilder(
                 condition: StockCubit.get(context).mostActivesData?.data!=null, builder: (context)=> stockItem(StockCubit.get(context).mostActivesData!),
                  fallback: (context)=>Center(child: CircularProgressIndicator(),)),
              ]),


        ),
      ),

    );

  }
}

Widget stockItem(StockModel model)=>ListView.separated(itemBuilder: (context,index)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: InkWell(
    onTap: (){
      NavigateTo(context, QuoteScreen(symbol: model!.data[index].symbol!));
    },
    child: Container(
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black,
            ),
            child:FancyShimmerImage(
                imageUrl: "https://fmpcloud.io/image-stock/${model!.data[index].symbol}.png",

                boxFit: BoxFit.cover,
                width: 40.0.w,
                height: 40.0.h,
                errorWidget:SizedBox()
            ),
          ),
          SizedBox(width: 10.w,),
          Container(
            width: 180.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model!.data[index].symbol}',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700,color: Colors.black),),
                Spacer(),
                Text('${model!.data[index].name}',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.6)),overflow: TextOverflow.ellipsis,),

              ],
            ),
          ),
          Spacer(),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('\$${model!.data[index].price}',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Colors.black)),
                Spacer(),
                Text('${model!.data[index].change}%',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w500,color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
),
    separatorBuilder: (context,index)=>SizedBox(height: 5.h,),
    itemCount: model!.data.length);
