import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

              title: Text('STOCKS'.toUpperCase(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.9)),),

              elevation: 0.0,

              backgroundColor: Colors.transparent,

              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    child: Expanded(child: Text('Most Gainer',style: TextStyle(fontSize: 15,color: Colors.black))),
                  ),
                  Tab(
                    child: Expanded(child: Text('Most Loser',style: TextStyle(fontSize: 15,color: Colors.black),)),
                  ),
                  Tab(
                    child: Expanded(child: Text('Most Actives',style: TextStyle(fontSize: 15,color: Colors.black))),
                  ),
                ],
              ),
            ),
            body:TabBarView(children: <Widget>[

              ConditionalBuilder(condition: StockCubit.get(context).mostGainerData?.data!=null, builder: (context)=> Expanded(
                  child: ListView.separated(itemBuilder: (context,index)=>Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white.withOpacity(0.3),
                            ),
                            child:CachedNetworkImage(
                              imageUrl: "https://fmpcloud.io/image-stock/${StockCubit.get(context).mostGainerData!.data[index].symbol}.png",
                              placeholder: (context, url) => new CircularProgressIndicator(),
                              errorWidget: (context, url, error) => new Icon(Icons.error),
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${StockCubit.get(context).mostGainerData!.data[index].symbol}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),),
                                Spacer(),
                                Text('${StockCubit.get(context).mostGainerData!.data[index].name}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.6)),overflow: TextOverflow.ellipsis,),

                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('\$${StockCubit.get(context).mostGainerData!.data[index].price}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black)),
                              Spacer(),
                              Text('${StockCubit.get(context).mostGainerData!.data[index].change}%',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                      separatorBuilder: (context,index)=>SizedBox(height: 5,),
                      itemCount: StockCubit.get(context).mostGainerData!.data.length)),
                  fallback: (context)=>Center(child: CircularProgressIndicator(),)),
              ConditionalBuilder(condition: StockCubit.get(context).mostLoserData?.data!=null, builder: (context)=> Expanded(
                  child: ListView.separated(itemBuilder: (context,index)=>Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white.withOpacity(0.3),
                            ),
                            child:CachedNetworkImage(
                              imageUrl: "https://fmpcloud.io/image-stock/${StockCubit.get(context).mostLoserData!.data[index].symbol}.png",
                              placeholder: (context, url) => new CircularProgressIndicator(),
                              errorWidget: (context, url, error) => new Icon(Icons.error),
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${StockCubit.get(context).mostLoserData!.data[index].symbol}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),),
                                Spacer(),
                                Text('${StockCubit.get(context).mostLoserData!.data[index].name}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.6)),overflow: TextOverflow.ellipsis,),

                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('\$${StockCubit.get(context).mostLoserData!.data[index].price}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black)),
                              Spacer(),
                              Text('${StockCubit.get(context).mostLoserData!.data[index].change}%',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                      separatorBuilder: (context,index)=>SizedBox(height: 5,),
                      itemCount: StockCubit.get(context).mostLoserData!.data.length)),
                  fallback: (context)=>Center(child: CircularProgressIndicator(),)),
             ConditionalBuilder(condition: StockCubit.get(context).mostActivesData?.data!=null, builder: (context)=> Expanded(
                 child: ListView.separated(itemBuilder: (context,index)=>Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Container(
                     height: 40,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           padding: EdgeInsets.all(10.0),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10.0),
                             color: Colors.white.withOpacity(0.3),
                           ),
                           child:CachedNetworkImage(
                             imageUrl: "https://fmpcloud.io/image-stock/${StockCubit.get(context).mostActivesData!.data[index].symbol}.png",
                             placeholder: (context, url) => new CircularProgressIndicator(),
                             errorWidget: (context, url, error) => new Icon(Icons.error),
                             height: 30,
                             width: 30,
                             fit: BoxFit.cover,
                           ),
                         ),
                         SizedBox(width: 10,),
                         Expanded(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text('${StockCubit.get(context).mostActivesData!.data[index].symbol}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),),
                               Spacer(),
                               Text('${StockCubit.get(context).mostActivesData!.data[index].name}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.6)),overflow: TextOverflow.ellipsis,),

                             ],
                           ),
                         ),

                         Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text('\$${StockCubit.get(context).mostGainerData!.data[index].price}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black)),
                             Spacer(),
                             Text('${StockCubit.get(context).mostGainerData!.data[index].change}%',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: Colors.black)),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
                     separatorBuilder: (context,index)=>SizedBox(height: 5,),
                     itemCount: StockCubit.get(context).mostActivesData!.data.length)),
                  fallback: (context)=>Center(child: CircularProgressIndicator(),)),
              ]),


        ),
      ),

    );

  }
}
