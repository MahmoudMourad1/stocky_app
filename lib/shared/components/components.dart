
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:Stocky/modules/quote_screen/quote_screen.dart';
import 'package:Stocky/modules/ticker_screen/ticker_screen.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';


Widget SwiperContainer (Map<String,dynamic> model ,context){
 return InkWell(
   onTap: (){
     NavigateTo(context,TickerScreen(from: '2021-07-25',to:'2021-08-05' ,symbol:model['symbol'] ,));
   },
   child: Container(
     width: 300,
     height: 270.0,
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(20.0),
       // gradient: LinearGradient(
       //   colors: [Color(0xffba160a), Color(0x91ba160a)],
       //   stops: [0, 1],
       //   begin: Alignment.topLeft,
       //   end: Alignment.bottomRight,
       // )
       gradient: LinearGradient(
         colors: [Color(0xff3861FB).withOpacity(0.9), Color(0xff16b5fc).withOpacity(0.8)],
         stops: [0.3, 1],
         begin: Alignment.topLeft,
         end: Alignment.bottomRight,
       )



     ),
     child: Padding(
       padding: const EdgeInsets.all(20.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             crossAxisAlignment:CrossAxisAlignment.start,
             children: [
               Container(
                 padding: EdgeInsets.all(10.0),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10.0),
                   color: Colors.white.withOpacity(0.3),
                 ),
                 child:CachedNetworkImage(
                   imageUrl: "https://fmpcloud.io/image-stock/${model['symbol']}.png",
                   color: model['Symbol']=='V'?HexColor('#1434cb'):null,
                   placeholder: (context, url) => new CircularProgressIndicator(),
                   errorWidget: (context, url, error) => new Icon(Icons.error),
                   height: 30,
                   width: 30,
                   fit: BoxFit.cover,
                   ),
               ),
               Spacer(),
               Container(
                 padding: EdgeInsets.all(10.0),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10.0),
                   color: Colors.white.withOpacity(0.4),
                 ),
                 child:Column(
                   children: [
                     Icon(model['change']>0? Icons.show_chart:Icons.waterfall_chart_outlined,color: model['change']>0 ? Colors.green:Colors.red,),
                     Text('${model['change']}%',style: TextStyle(fontSize: 10.0,color: Colors.white),)
                   ],
                 ),
               ),
             ],
           ),
           Spacer(),
           Container(
             width: double.infinity,
             child: Column(
               children:   [
                 Text('${model['name']}',style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w500),)],
             ),
           ),
           Spacer(),
           Row(
             children: [
               Text('${model['symbol']} ',style: TextStyle(color:Colors.white,fontSize: 15.0),)
             ],
           ),

         ],
       ),
     ),


   ),
 ) ;

}

void NavigateTo (context, widget) => Navigator.push(context,
    MaterialPageRoute(builder:(context)=>widget ));

Widget BuildArticleItem(article,context) => InkWell(
  onTap: (){

    NavigateTo(context, QuoteScreen(symbol: article['symbol']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.black.withOpacity(0.9),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FancyShimmerImage(imageUrl:'https://fmpcloud.io/image-stock/${article['symbol']}.png',boxFit: BoxFit.cover,width: 80.0,
              height: 80.0,errorWidget:SizedBox()),
          ),

        ),

        SizedBox(width: 20.0,),
        Expanded(
          child: Container(
            height: 50.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['name']}',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),overflow:TextOverflow.ellipsis,),

                ),
                Text(
                  '${article['stockExchange']}',
                  style: TextStyle(fontSize: 10.0,color: Colors.grey),),

              ],



            ),

          ),

        )



      ],

    ),

  ),
);

Widget articleBuilder(list,context,{isSearch = false})=>ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context)=> ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index){
          print(list.runtimeType);
          return BuildArticleItem(list[index],context);
        },
        separatorBuilder: (context,index)=>SizedBox(height: 10.0,),
        itemCount: list.length),
    fallback: (context)=>isSearch ? Container() : Center(child: CircularProgressIndicator()));

