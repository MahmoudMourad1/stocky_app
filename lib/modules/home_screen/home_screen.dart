
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_twit/shared/components/components.dart';
import 'package:stock_twit/shared/cubit/cubit.dart';
import 'package:stock_twit/shared/cubit/states.dart';

import '../../shared/components/imagelist.dart';
import '../../shared/components/textlist.dart';

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
            backgroundColor: Colors.white,
             appBar: AppBar(
               title: Text('StockY'.toUpperCase(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.6)),),
               elevation: 0.0,
               actions: [
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal:20.0),
                   child: Icon(Icons.search_outlined,size: 30 ,color: Colors.black.withOpacity(0.7),),
                 )
               ],
               backgroundColor: Colors.grey.shade100,
             ),
            body: Column(children: [
              Container(
                width: double.infinity,
                height: 360,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
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
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey.shade100,
                      height: 30,
                      child: ConditionalBuilder(
                        condition: StockCubit.get(context).mostGainerData?.data!=null,
                        builder: (context)=>CarouselSlider(
                          items: StockCubit.get(context).mostGainerData!.data
                              .map(
                                (item) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(children: [
                                Text('${item.symbol}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade600), ),
                                SizedBox(width: 5,),
                                Text('${item.price}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade600),),
                                SizedBox(width: 5,),
                                Text('${item.change}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: item.change!>0?Colors.green:Colors.red ),),
                                SizedBox(width: 4,),
                              ],),
                            ),
                          ).toList(),

                          options: CarouselOptions(
                              height: 380.0,
                              viewportFraction: 0.5,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: true,
                              autoPlay: true,
                              autoPlayInterval: Duration(milliseconds: 1000),
                              autoPlayAnimationDuration: Duration(milliseconds: 2000),
                              autoPlayCurve: Curves.linear,
                              scrollDirection: Axis.horizontal
                          ),
                        ),
                        fallback: (context)=>Container(width: double.infinity,),
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConditionalBuilder(
                        condition: StockCubit.get(context).mostGainerData!=null,
                        builder: (context)=>Container(
                          height:300,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return SwiperContainer(StockCubit.get(context).mostGainerData!.data[index]);
                            },
                            itemCount: 10,
                            itemWidth: 300.0,
                            layout: SwiperLayout.STACK,
                          ),
                        ),
                        fallback: (context)=>CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height:20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height:120,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
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
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl:a[index] ,
                                placeholder: (context, url) => new CircularProgressIndicator(),
                                errorWidget: (context, url, error) => new Icon(Icons.error),
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(height: 10.0,),
                              Text(B[index],style: TextStyle(color:Colors.black,fontWeight:FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context,index)=>SizedBox(width: 19,),
                    itemCount: a.length),
              ),
            ],),

          );
        },
      )

    );
  }
}

