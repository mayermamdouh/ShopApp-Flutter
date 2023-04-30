import 'package:api_project/shopApp/ShopPages/HomeModel.dart';
import 'package:api_project/shopApp/another%20thinks/component.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import '../HomeCubit.dart';
import '../HomeSates.dart';
import '../categores/Categories_model.dart';

class Products_Screen extends StatelessWidget {
  const Products_Screen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var model = HomeCubit.get(context).modell;
    var modelCate = HomeCubit.get(context).modelCategores;

    return BlocConsumer<HomeCubit,HomeSates>(
      listener: (context,state){
        if(state is HomeStatesSuccesFaveriotesState){
          if(state.model!.status == false){
            showToast(text:('${state.model!.message}') , states: ToastStates.ERROR);
          }
        }
      },
      builder:(context,state){
        return Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) => state is! HomeStatesLoadingState  && state is! HomeStatesCategoriesLoadingState ,
          fallbackBuilder: (BuildContext context) => const Center(child: CircularProgressIndicator()),
          widgetBuilder: (BuildContext context) =>
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Card(
                      elevation: 0.8,
                      child: CarouselSlider(
                        items:model?.data?.banners.map((e) =>
                        Image(
                          image: NetworkImage(e.image!),width: double.infinity,fit: BoxFit.cover,),
                        ).toList() ,
                        options:CarouselOptions(
                          height: 250,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 4),
                          autoPlayAnimationDuration: Duration(seconds: 1),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 1.0, // Show 90% of the carousel at once
                          scrollPhysics: BouncingScrollPhysics(), // Add bounce effect to scrolling
                        // Change the animation duration
                        ),),
                    ),
                    SizedBox(height:20 ,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          SizedBox(height: 15,),
                          Container(
                            height: 80,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context,state)=> SizedBox(width: 10,),
                              itemCount: modelCate?.Data?.data.length ?? 0,
                              itemBuilder:(context,index)=> buildCategoreItem(modelCate?.Data?.data[index] as dataaaa , context ) ,),
                          ),
                          SizedBox(height: 20,),
                          Text('New Products',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: 1/1.4,
                    children: List.generate(model?.data?.products.length ?? 0,
                            (index) => buildGridProduct(model?.data?.products[index] as ProductModel ,context),

                    ),
                    ),

                  ],
                ),
              ),
        );
      },
    );
  }
  Widget buildCategoreItem(dataaaa data, BuildContext context)=>Container(
    height: 80,
    width: 80,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(image: NetworkImage(data.image!)
          ,fit: BoxFit.cover,height: 80,width: 80,),
        Container(
            color: Colors.black.withOpacity(.9),
            width: double.infinity,
            child: Text(data.name!,textAlign: TextAlign.center,maxLines: 1,style: TextStyle(
              color: Colors.white,
            ),))
      ],
    ),
  );

  Widget buildGridProduct(ProductModel modelll , context )=>
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(image:NetworkImage(modelll.image??''),
                width:double.infinity,
                  fit: BoxFit.fill,
                  height: 150,
                ),
                if(modelll.discount  !=  0)
                Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text('DISCOUNT',style: TextStyle(color: Colors.white,fontSize: 12),),
                  ),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  modelll.name??'',
                  maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        '${modelll.price.round()}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.0,color: Colors.blue,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10,),
                      if(modelll.discount != 0)
                      Text(
                        '${modelll.oldPrice.round()}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13.0,color: Colors.grey[700],fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough),

                      ),
                      Spacer(),
                      IconButton(onPressed: (){
                        HomeCubit.get(context).CahngeFaveriotes(modelll.id!);
                        print(modelll.id);
                      }, icon:Icon(Icons.favorite,color: HomeCubit.get(context).faveriots[modelll.id] == true ? Colors.red : Colors.grey,)),
                    ],
                  ),
                ],
              ),
            ),
          ],),
      );
}
