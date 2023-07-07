
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:Stocky/models/stock_model.dart';
import 'package:Stocky/modules/crypto_screen/crypto_screen.dart';
import 'package:Stocky/modules/etf_screen/etf_screen.dart';
import 'package:Stocky/modules/forex_screen/forex_screen.dart';
import 'package:Stocky/modules/news_screen/news_screen.dart';
import 'package:Stocky/modules/quote_screen/quote_screen.dart';
import 'package:Stocky/modules/search_screen/search_screen.dart';
import 'package:Stocky/modules/stock_screen/stock_screen.dart';
import 'package:Stocky/shared/components/components.dart';
import 'package:Stocky/shared/cubit/cubit.dart';
import 'package:Stocky/shared/cubit/states.dart';
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
              title: Image.asset('assets/logo.gif',width: 160,repeat: ImageRepeat.repeatX),
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
                  borderRadius:BorderRadius.only(topRight: Radius.circular(15.r),topLeft: Radius.circular(15.r))

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
                            borderRadius:BorderRadius.only(topRight: Radius.circular(15.r),topLeft: Radius.circular(15.r))

                        ),
                        height: 30.h,
                        child: ConditionalBuilder(
                          condition: StockCubit.get(context).mostGainerData?.data!=null,
                          builder: (context)=>  AutoScrollToPBar(StockCubit.get(context).mostGainerData!),

                          fallback: (context)=>Container(width: double.infinity,),
                        )
                    ),

                    //Home Screen Start
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30.r),topLeft: Radius.circular(30.r))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConditionalBuilder(
                            condition: StockCubit.get(context).stockSymbolData!=null,
                            builder: (context)=>SwiperView(StockCubit.get(context).stockSymbolData,context),
                            fallback: (context)=>Container(
                                color: Colors.transparent,
                                height: 300.h,
                                width: 300.w,
                                child: Center(child: CircularProgressIndicator())),
                          ),
                          SizedBox(height: 20.h,),
                          Container(

                            height:120.h,
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context,index)=> CategoryList(context,index),
                                padding: EdgeInsets.only(left: 20),
                                separatorBuilder: (context,index)=>SizedBox(width: 19,),
                                itemCount: categoryImg.length),
                          ),
                          SizedBox(height:20.h,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Text('Stocks',style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.bold),),
                                Spacer(),
                                TextButton(onPressed: (){
                                  NavigateTo(context, StockScreen());
                                }, child: Text('See More',style: TextStyle(color: Colors.blueGrey,fontSize: 15.sp),))
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Container(
                            height: 70.h,
                            child: ListView.separated(
                                padding: EdgeInsets.only(left: 20),
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context,index)=>InkWell(
                                  onTap: (){
                                    NavigateTo(context, QuoteScreen(symbol: '${StockCubit.get(context).mostGainerData!.data[index+10].symbol}'));
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10.0),

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50.0.r),
                                          color: Colors.black,
                                        ),
                                        child:FancyShimmerImage(
                                            imageUrl: "https://fmpcloud.io/image-stock/${StockCubit.get(context).mostGainerData!.data[index+10].symbol}.png",
                                            boxFit: BoxFit.cover,width: 30.0.w,
                                            height: 30.0.h,errorWidget:SizedBox()
                                        ),
                                      ),

                                      SizedBox(width: 6.w,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${StockCubit.get(context).mostGainerData!.data[index+10].symbol}',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w900),),
                                          SizedBox(height: 5.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text('${StockCubit.get(context).mostGainerData!.data[index+10].price}',style: TextStyle(fontSize: 15.sp),),
                                              Icon(Icons.arrow_drop_up,size: 30.w,color:StockCubit.get(context).mostGainerData!.data[index+10].change>0?Colors.green:Colors.red ,)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                separatorBuilder: (context,index)=>SizedBox(width: 20.w,),
                                itemCount: StockCubit.get(context).mostGainerData?.data.length!=null?15:0),

                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Text('News',style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.bold),),
                                Spacer(),
                                TextButton(onPressed: (){
                                  NavigateTo(context, NewsScreen());
                                }, child: Text('See More',style: TextStyle(color: Colors.blueGrey,fontSize: 15.sp),))
                              ],
                            ),
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
                                                height: 90.h,
                                                width: 90.w,
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
                                                        Text('${StockCubit.get(context).newsData!.data[index].author}',style: TextStyle(color:Colors.grey,fontSize: 10.0.sp,),),
                                                        Text('.',style: TextStyle(color:Colors.grey,fontSize: 15.0.sp,fontWeight: FontWeight.bold),),
                                                        Text('${StockCubit.get(context).newsData!.data[index].date}',style: TextStyle(color:Colors.grey,fontSize: 10.0.sp,),)
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
                                fallback: (context)=>Container(height: 300.h, child: SizedBox())),
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
          (item) => Container(
        width:140,
        child: Row(children: [

          Text('${item.symbol}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white), ),
          SizedBox(width: 5,),
          Text('${item.price}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
          SizedBox(width: 5,),
          Expanded(child: Text('${item.change}',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: item.change!>0?Colors.green:Colors.red ),)),

        ],),
      ),
    ).toList(),

    options: CarouselOptions(
        pageSnapping: false,
        height: 380.0,
        viewportFraction: 0.4,
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
        if(index ==2 ){
          return NavigateTo(context, ForexScreen());
        }else if(index==3){
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

