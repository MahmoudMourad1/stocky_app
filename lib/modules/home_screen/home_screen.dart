import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_twit/shared/components/components.dart';
import 'package:stock_twit/shared/cubit/cubit.dart';
import 'package:stock_twit/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>StockCubit()..GetMostGainerData()..GetMostActivesData()..GetMostLoserData(),
      child:BlocConsumer<StockCubit,StockStates>(
        listener: (context,state){
          if(state is StockErrorMostGainer){
            print(state.error);
          }
        },
        builder: (context,state){
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: 30,
                    child: ConditionalBuilder(
                      condition: StockCubit.get(context).mostGainerData?.data!=null,
                      builder: (context)=>CarouselSlider(
                        items: StockCubit.get(context).mostGainerData!.data
                            .map(
                              (item) => Center(
                              child: Row(children: [
                                Text('${item.symbol}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade600), ),
                                SizedBox(width: 4,),
                                Text('${item.price}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade600),),
                                SizedBox(width: 4,),
                                Text('${item.change}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: item.change!>0?Colors.green:Colors.red ),),
                                SizedBox(width: 4,),
                              ],)
                          ),
                        ).toList(),

                        options: CarouselOptions(
                            height: 380.0,
                            viewportFraction: 0.4,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(milliseconds: 2000),
                            autoPlayAnimationDuration: Duration(milliseconds: 1500),

                            scrollDirection: Axis.horizontal
                        ),
                      ),
                      fallback: (context)=>Container(width: double.infinity,),
                    ),
                  ),

                  ConditionalBuilder(
                    condition: StockCubit.get(context).mostGainerData!=null,
                    builder: (context)=>Container(
                      height:300,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return FrostedContainer(StockCubit.get(context).mostGainerData!.data[index]);
                        },
                        itemCount: 10,
                        itemWidth: 300.0,
                        layout: SwiperLayout.STACK,
                      ),
                    ),
                    fallback: (context)=>CircularProgressIndicator(),
                  )

                ],
              ),
            ),
          );
        },
      )

    );
  }
}
