import 'package:api_project/shopApp/ShopPages/HomeCubit.dart';
import 'package:api_project/shopApp/ShopPages/HomePage.dart';
import 'package:api_project/shopApp/Login_Block/Bloc_observe.dart';
import 'package:api_project/shopApp/Login_Block/Login_Shopping_App.dart';
import 'package:api_project/shopApp/ShopPages/HomeSates.dart';
import 'package:api_project/shopApp/another%20thinks/CacheHelper.dart';
import 'package:api_project/shopApp/onBording_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool? onBorading = CacheHelper.getData(key: 'onBording');
    Token = CacheHelper.getData(key: 'token');
    print(Token);
  Widget widget;

  if(onBorading != null){
    if(Token !=null ) widget = HomePageShop();
    else widget = Login_Page_App_Shopping();
  }else{
    widget = onBordingScreen();
  }

  print(widget);
  print(onBorading);
  runApp(MyApp(
    startWidget:widget ,
  ));
}

// StatelessWidget
// StatefulWidget

class MyApp extends StatelessWidget {
   final Widget startWidget;
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:  [
        BlocProvider(
          create: (BuildContext context) =>HomeCubit()..GetHomePageData()..GetHomeCategoriesData()..GetHomeFaveriotData()
            ..GetProfileData(),
        ),
      ],
      child: BlocConsumer<HomeCubit, HomeSates>(
        listener: (context, state) {},
        builder: (context, state) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            home:startWidget ,
          );
        },
      ),
    );
  }
}
