import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../HomeCubit.dart';
import '../HomeSates.dart';
import 'Faveriot_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


class Faveriots_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // var model = HomeCubit.get(context).modell;
    // var modelCate = HomeCubit.get(context).modelCategores;
    var modellFaveriot = HomeCubit.get(context).modelFaveriot;
    return BlocConsumer<HomeCubit,HomeSates>(
      listener:(context,state){} ,
      builder:(context,state){
        return ConditionalBuilder(
          condition:state is! HomeStatesLoadingFaveriotesPageState ,
          builder:(context)=> ListView.separated(
            itemBuilder: (context, index) => buildFaveriotItem(modellFaveriot.data?.data![index] as Dataa , context),
            separatorBuilder: (context, state) => SizedBox(height: 15,),
            itemCount:modellFaveriot!.data!.data!.length ,
          ), fallback: (BuildContext context)=>const Center(child: CircularProgressIndicator()),
        );
      } ,
    );

  }
  Widget buildFaveriotItem(Dataa model, BuildContext context , {bool OldPrice = true}) => Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Container(
              child: Image(
                image: NetworkImage(
                  model.product!.image!),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            if(model.product!.discount != 0 && OldPrice)
            Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.product!.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,

                  ),

                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      "${model.product!.price}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    SizedBox(width: 10),
                    if(model.product!.price != model.product!.oldPrice &&   OldPrice)
                    Text(
                      "${model.product!.oldPrice} ",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                         HomeCubit.get(context).CahngeFaveriotes(model.product!.id!);
                         print(model.product!.id!);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color:  HomeCubit.get(context).faveriots[model.product!.id]! ? Colors.red : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
