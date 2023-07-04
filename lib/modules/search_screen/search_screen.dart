
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Stocky/shared/cubit/cubit.dart';
import 'package:Stocky/shared/cubit/states.dart';

import '../../shared/components/components.dart';


class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

   var SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockCubit,StockStates>(
      listener: (context,state){
      },
      builder: (context,state){
        var list  = StockCubit.get(context).search;
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color:Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Search',style: TextStyle(color:Colors.white,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                        Text('For Stocks',style: TextStyle(color: Colors.blueGrey,fontSize: 25.sp,fontWeight: FontWeight.bold),),
                        SizedBox(height: 20.0.h,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white
                          ),
                          child: TextFormField(
                          controller:SearchController ,

                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon:Icon(Icons.search,color: Colors.blueGrey,),
                            focusColor: Colors.white,
                            iconColor: Colors.white,
                          ),

                          onChanged: (value) {
                            StockCubit.get(context).getsearch(value);
                          },
                          validator: (String? value) {
                            if(value!.isEmpty){
                              return ('Search Must not be empty');
                            }
                            return null;
                          },
                      ),
                        ),
                      ],
                    ),
                  ),

                ),
                SizedBox(height: 10.h,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Search Results',style:TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight:FontWeight.bold),),
                ),
                Expanded(child: articleBuilder(list,context,isSearch: true))
              ],

            ),
          )
        );
      },
    );
  }
}

