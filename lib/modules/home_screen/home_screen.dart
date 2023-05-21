
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:stock_twit/models/stock_model.dart';
import 'package:stock_twit/modules/crypto_screen/crypto_screen.dart';
import 'package:stock_twit/modules/etf_screen/etf_screen.dart';
import 'package:stock_twit/modules/forex_screen/forex_screen.dart';
import 'package:stock_twit/modules/search_screen/search_screen.dart';
import 'package:stock_twit/modules/stock_screen/stock_screen.dart';
import 'package:stock_twit/shared/components/components.dart';
import 'package:stock_twit/shared/cubit/cubit.dart';
import 'package:stock_twit/shared/cubit/states.dart';
import '../../shared/components/imagelist.dart';
import '../../shared/components/textlist.dart';
import '../news_webview/news_webview.dart';

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
                padding: const EdgeInsets.symmetric(horizontal:10.0),
                child: IconButton(icon:Icon(Icons.search,size: 25) ,color: Colors.grey.withOpacity(0.9),
                  onPressed: (){
                  NavigateTo(context, SearchScreen());
                },),
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
                        builder: (context)=>  AutoScrollToPBar(StockCubit.get(context).mostGainerData!),


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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConditionalBuilder(
                          condition: StockCubit.get(context).stockSymbolData!=null,
                          builder: (context)=>SwiperView(StockCubit.get(context).stockSymbolData,context),
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

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text('News',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          child: ConditionalBuilder(condition: StockCubit.get(context).newsData?.data!=null,
                              builder: (context)=>ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context,index)=>Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: InkWell(
                                      onTap: (){
                                        NavigateTo(context, webviewScreen("${StockCubit.get(context).newsData!.data[index].link}"));

                                      },
                                      child: Container(
                                        height: 90,color: Colors.transparent,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 90,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(20),
                                                image:DecorationImage(image:
                                                CachedNetworkImageProvider(
                                                    '${StockCubit.get(context).newsData!.data[index].image}'),
                                                  fit: BoxFit.fill,),
                                              ),
                                            ),

                                            Expanded(child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Column(
                                                children: [

                                                  Text('${StockCubit.get(context).newsData!.data[index].title}' ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Text('${StockCubit.get(context).newsData!.data[index].author}',style: TextStyle(color:Colors.grey,fontSize: 10.0,),),
                                                      Text('.',style: TextStyle(color:Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold),),
                                                      Text('${StockCubit.get(context).newsData!.data[index].date}',style: TextStyle(color:Colors.grey,fontSize: 10.0,),)
                                                    ],
                                                  )

                                                ],
                                              ),
                                            )),
                                          ],

                                        ),

                                      ),
                                    ),
                                  ),
                                  separatorBuilder:(context,index)=>SizedBox(height: 0,),
                                  itemCount: StockCubit.get(context).newsData!.data.length),
                              fallback: (context)=>Container(height: 300, child: SizedBox())),
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
      pageSnapping: false,
        height: 380.0,
        viewportFraction: 0.5,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: true,
        autoPlay: true,
        pauseAutoPlayOnManualNavigate: true,

        scrollPhysics: AlwaysScrollableScrollPhysics(),
        autoPlayInterval: Duration(milliseconds: 1900),
        autoPlayAnimationDuration: Duration(milliseconds: 2000),
        autoPlayCurve: Curves.linear,
        scrollDirection: Axis.horizontal

    //      height: 380.0,
      //         viewportFraction: 0.5,
      //         initialPage: 0,
      //         enableInfiniteScroll: true,
      //         reverse: true,
      //         autoPlay: true,
      //         autoPlayInterval: Duration(milliseconds: 1000),
      //         autoPlayAnimationDuration: Duration(milliseconds: 2000),
      //         autoPlayCurve: Curves.linear,
      //         scrollDirection: Axis.horizontal
    ),
  );

  Widget SwiperView(List<Map<String,dynamic>> model,context)=>Container(
    padding: EdgeInsets.all(8.0),
    height:300,
    child: Swiper(
      itemBuilder: (BuildContext context, int index) {
        return SwiperContainer(StockCubit.get(context).stockSymbolData[index],context);
      },
      itemCount: StockCubit.get(context).stockSymbolData.length,
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
        }else if(index==4){
          return NavigateTo(context, EtfScreen());
        }
        if(index ==0 ){
          return NavigateTo(context, StockScreen());
        }else if (index==1)
          {
            return NavigateTo(context, CryptoScreen());
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
              FancyShimmerImage(imageUrl:categoryImg[index],boxFit: BoxFit.fitHeight,width: 50.0,
                  height: 50.0,errorWidget:SizedBox()),
              SizedBox(height: 10.0,),
              Text(B[index],style: TextStyle(color:Colors.black,fontWeight:FontWeight.bold),)
            ],
          ),
        ),
      ),
    ),
  );

}

