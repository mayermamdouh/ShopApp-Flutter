import 'package:api_project/shopApp/ShopPages/search/Search_Scrren.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'HomeCubit.dart';
import 'HomeSates.dart';
class HomePageShop extends StatelessWidget {
  const HomePageShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeSates>(
      listener: (BuildContext context,state){},
      builder: (BuildContext context,state){
      var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            actions: [

              IconButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Search_screen()),
                );
              }, icon: Icon(Icons.search,size: 32,),color: Colors.black,),
            ],
          ),
          body: cubit.Screens[cubit.CurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.deepOrangeAccent,
           // selectedItemColor: Colors.blue,
            backgroundColor: Colors.white,
            onTap:(index){
              cubit.ChangeNavBarScrrens(index);
            },
            currentIndex: cubit.CurrentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ],
          ),
        );
      },


    );
  }
}
