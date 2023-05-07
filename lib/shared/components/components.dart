
import 'package:flutter/material.dart';
import 'package:stock_twit/models/stock_model.dart';

Widget FrostedContainer (Data model ){
 return Container(
   width: 300,
   height: 270.0,
   decoration: BoxDecoration(
     borderRadius: BorderRadius.circular(20.0),
     gradient: LinearGradient(
       colors: [Color(0xffba160a), Color(0x91ba160a)],
       stops: [0, 1],
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
               child:Image(image: NetworkImage('https://fmpcloud.io/image-stock/${model.symbol}.png',), fit: BoxFit.cover, width: 30,height: 30,),
               padding: EdgeInsets.all(10.0),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10.0),
                 color: Colors.white.withOpacity(0.3),
               ),
             ),
             Spacer(),
             Container(
               child:Column(
                 children: [
                   Icon(Icons.auto_graph_outlined,color: Colors.white,),
                   Text('${model.change}%',style: TextStyle(fontSize: 10.0,color: Colors.white),)
                 ],
               ),
               padding: EdgeInsets.all(10.0),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10.0),
                 color: Colors.white.withOpacity(0.4),
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

