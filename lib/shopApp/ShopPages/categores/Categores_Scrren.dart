import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../HomeCubit.dart';
import '../HomeSates.dart';
import 'Categories_model.dart';

class Catefores_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var modelCate = HomeCubit.get(context).modelCategores;
    return BlocConsumer<HomeCubit,HomeSates>(
      listener:(context,state){} ,
      builder:(context,state){
        return ListView.separated(
            itemBuilder: (context, index) => buildItem(modelCate?.Data?.data[index] as dataaaa),
            separatorBuilder: (context, state) => SizedBox(height: 15,),
            itemCount:modelCate?.Data?.data.length ?? 0,
        );
      } ,
    );
  }

  Widget buildItem(dataaaa data)=> Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        Image(image: NetworkImage(data.image!),fit: BoxFit.cover,width: 90,height: 90,),
        SizedBox(width: 20,),
        Text(data.name!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        Spacer(),
        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
      ],
    ),
  );
}
