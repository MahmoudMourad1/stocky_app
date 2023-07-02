import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_twit/shared/components/components.dart';
import 'package:stock_twit/shared/cubit/cubit.dart';
import 'package:stock_twit/shared/cubit/states.dart';
import 'package:shimmer/shimmer.dart';
import '../news_webview/news_webview.dart';
class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>StockCubit()..GetNewsData(size: 30),
      child: BlocConsumer<StockCubit,StockStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text('News'.toUpperCase(),style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.w600,color: Colors.white.withOpacity(1)),),

              ),
              body: ConditionalBuilder(
                condition: StockCubit.get(context).newsData?.data!=null,
                builder: (context)=>ListView.separated(
                  physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: (){
                          NavigateTo(context, webviewScreen("${StockCubit.get(context).newsData!.data[index].link}"));

                        },
                        child: Container(
                          height: 90.h,color: Colors.transparent,
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
                fallback:(context)=> Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('Loading',style: TextStyle(fontSize: 15.sp,color: Colors.grey.shade400),),
                    SizedBox(width: 10.w,),
                    CircularProgressIndicator(color: Colors.grey.shade400,strokeWidth: 10.w,),
                ],))
              ),
            );
          },
          ),
    );
  }
}
