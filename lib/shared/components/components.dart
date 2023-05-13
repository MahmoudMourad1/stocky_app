
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stock_twit/models/stock_model.dart';

Widget SwiperContainer (Data model ){
 return Container(
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
                 imageUrl: "https://fmpcloud.io/image-stock/${model.symbol}.png",
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
                   Icon(model.change>0? Icons.show_chart:Icons.waterfall_chart_outlined,color: model.change>0 ? Colors.green:Colors.red,),
                   Text('${model.change}%',style: TextStyle(fontSize: 10.0,color: Colors.white),)
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
               Text('${model.name}',style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w500),)],
           ),
         ),
         Spacer(),
         Row(
           children: [
             Text('${model.symbol} ',style: TextStyle(color:Colors.white,fontSize: 15.0),)
           ],
         ),

       ],
     ),
   ),


 ) ;

}

void NavigateTo (context, widget) => Navigator.push(context,
    MaterialPageRoute(builder:(context)=>widget ));

