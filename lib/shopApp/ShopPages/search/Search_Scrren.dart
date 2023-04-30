import 'package:api_project/shopApp/ShopPages/search/Search_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Login_Block/Login_Shopping_App.dart';
import 'CubitSearch.dart';
import 'StatesSearch.dart';

class Search_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var Searchdcontroller = TextEditingController();
    var FormKey = GlobalKey<FormState>();

    return BlocProvider(
      create:(BuildContext context)=> ShopSearchCubit(),
      child: BlocProvider(
        create: (BuildContext context) => ShopSearchCubit(),
        child: BlocConsumer<ShopSearchCubit,ShopSearchStates>(
          listener:(context,state) {},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                backgroundColor: Colors.white,
                title: Form(
                  key: FormKey,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Column(
                      children: [
                        Container(

                          height:50,
                          width: double.infinity,
                          child: TextButtom(
                            onChanged: (String value){
                              ShopSearchCubit.get(context).Search(value);
                            },
                            controller: Searchdcontroller,
                            icon: Icons.search,
                            lable: 'Search',
                            type: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter test to search';
                              }
                              return null;
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                ) ,
              ),
              body: Column(
                children: [
                  SizedBox(height: 10,),
                  if (state is ShopSearchStatesLoadingState)
                    LinearProgressIndicator(),
                  if(state is ShopSearchStatesSuccesState)
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => buildSearchItem(ShopSearchCubit.get(context).modelSearch?.data?.data![index] as Product , context),
                      separatorBuilder: (context, state) => SizedBox(height: 15,),
                      itemCount:ShopSearchCubit.get(context).modelSearch!.data!.data!.length ,
                    ),
                  ),
                ],
              ),

            );
          },
        ),
      ),
    );
  }
  Widget buildSearchItem(Product model, BuildContext context , {bool OldPrice = false}) => Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Container(
              child: Image(
                image: NetworkImage(
                    model.image!),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            if(model.discount != 0 && OldPrice)
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
                  model.name!,
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
                      "${model.price}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    SizedBox(width: 10),
                    if(model.price != model.oldPrice &&  OldPrice)
                      Text(
                        "${model.oldPrice} ",
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
                        // ShopSearchCubit.get(context).CahngeFaveriotes(model.product!.id!);
                        // print(model.product!.id!);
                      },
                      icon: Icon(
                        Icons.favorite,
                        // color:  HomeCubit.get(context).faveriots[model.product!.id]! ? Colors.red : Colors.grey,
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
