
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stock_twit/models/stock_model.dart';
import 'package:stock_twit/modules/forex_screen/forex_screen.dart';
import 'package:stock_twit/shared/components/components.dart';
import 'package:stock_twit/shared/cubit/cubit.dart';
import 'package:stock_twit/shared/cubit/states.dart';

import '../../shared/components/imagelist.dart';
import '../../shared/components/textlist.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

   var controller =ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockCubit,StockStates>(
      listener: (context,state){

        if(state is StockErrorMostGainer){
          print(state.error);

        }
        if(state is StockErrorForexData){
          print(state.error);
        }
      },
      builder: (context,state){
        return Scaffold(
          backgroundColor:  controller.initialScrollOffset>0? Colors.white:Colors.black,
          appBar: AppBar(

            title: Text('STOCK'.toUpperCase(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.white.withOpacity(0.9)),),
            titleSpacing: 20.0,
            elevation: 0.0,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: Icon(Icons.search,size: 25 ,color: Colors.grey.withOpacity(0.9),),
              )
            ],
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            decoration: BoxDecoration(
              color: HexColor('#3861fb'),
              borderRadius:BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))

            ),
            child: SingleChildScrollView(
              controller: controller,

              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  //Top Auto scroll Bar
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius:BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))

                      ),
                      height: 30,
                      child: ConditionalBuilder(
                        condition: StockCubit.get(context).mostGainerData?.data!=null,
                        builder: (context)=>AutoScrollToPBar(StockCubit.get(context).mostGainerData!),
                        fallback: (context)=>Container(width: double.infinity,),
                      )
                  ),

                  //Home Screen Start
                  Container(
                    decoration: BoxDecoration(
                      color: HexColor('#f3f5f6'),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                    ),
                    child: Column(
                      children: [
                        ConditionalBuilder(
                          condition: StockCubit.get(context).mostGainerData!=null,
                          builder: (context)=>SwiperView(StockCubit.get(context).mostGainerData!),
                          fallback: (context)=>Container(
                            color: Colors.transparent,
                              height: 300,
                              width: 300,
                              child: Center(child: CircularProgressIndicator())),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height:120,
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index)=>CategoryList(context,index),
                              separatorBuilder: (context,index)=>SizedBox(width: 19,),
                              itemCount: categoryImg.length),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 1000,
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index)=>ConditionalBuilder(
                                  condition: StockCubit.get(context).newsData!=null && StockCubit.get(context).newsData?.data!=null,
                                  builder: (context)=> Container(
                                    width: double.infinity,
                                    height: 400,
                                    child:Row(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          child: Image(
                                            image: NetworkImage('https://cdn.financialmodelingprep.com/images/fmp-1683909976762.jpg'),
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      ],
                                      //add
                                    ) ,
                                  ),
                                  fallback: (context)=>SizedBox()),
                              separatorBuilder: (context,index)=>SizedBox(height: 10,),
                              itemCount: 3),
                        ),
                      ],
                    ),

                  ),
                ],
              ),
            ),
          )

        );
      },
    );
  }


  Widget AutoScrollToPBar(StockModel model)=>CarouselSlider(
    items: model.data
        .map(
          (item) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: [
          Text('${item.symbol}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: Colors.white), ),
          SizedBox(width: 5,),
          Text('${item.price}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: Colors.white),),
          SizedBox(width: 5,),
          Text('${item.change}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: item.change!>0?Colors.green:Colors.red ),),
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
  );

  Widget SwiperView(StockModel model)=>Container(
    padding: EdgeInsets.all(8.0),
    height:300,
    child: Swiper(
      itemBuilder: (BuildContext context, int index) {
        return SwiperContainer(StockCubit.get(context).mostGainerData!.data[index]);
      },
      itemCount: 10,
      itemWidth: 300.0,
      layout: SwiperLayout.STACK,
    ),
  );

  Widget CategoryList(context,index)=>Padding(
    padding: const EdgeInsets.all(10.0),
    child: InkWell(
      onTap: (){
        if(index ==3 ){
          return NavigateTo(context, ForexScreen());
        }
      },
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
                imageUrl:categoryImg[index] ,
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
  );
}
