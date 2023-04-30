import 'package:api_project/shopApp/ShopPages/HomeModel.dart';
import 'package:api_project/shopApp/ShopPages/categores/Categores_Scrren.dart';
import 'package:api_project/shopApp/ShopPages/products/Products_Scrren.dart';
import 'package:api_project/shopApp/ShopPages/products/modelFaveriots.dart';
import 'package:api_project/shopApp/ShopPages/settings/Settings_Scrren.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Login_Block/Login_model.dart';
import '../another thinks/DioHelper.dart';
import 'HomeSates.dart';
import 'categores/Categories_model.dart';
import 'faveriots/Faveriot_model.dart';
import 'faveriots/Faveriots_Scrren.dart';

const Home = 'home';
const Get_Categories = 'categories';
const FAVORITE = 'favorites';
const PROFILE = 'profile';
const  UPDATEPROFILE= "update-profile";
String? Token;


class HomeCubit extends Cubit<HomeSates>{
  HomeCubit(): super(HomeIntialState());

  static HomeCubit get(context)=> BlocProvider.of(context);

  int CurrentIndex = 0;
  List<String> Title = [
    'page1',
    'page2',
    'page3',
    'page4',
    'page5',
  ];

  List<Widget> Screens = [
  Products_Screen(),
  Catefores_Screen(),
  Faveriots_Screen(),
  Settings_Screen(),

  ];

  void ChangeNavBarScrrens(int index){
    CurrentIndex = index;
    emit(ShopLChangeBottomNavBarState());
  }

  //int because id_Product
  //bool true or false because with me or not
  Map<int?,bool?> faveriots = {};

  HomeModel? modell;
  void GetHomePageData(){
 emit(HomeStatesLoadingState());
  DioHelper.getData(
      url: Home,
      tokenn:Token,
  ).then((value) {
    modell = HomeModel.fromJson(value?.data);
    //print(value?.data);
    //print(modell?.data?.products);
    modell?.data?.products.forEach((element) {
      faveriots.addAll({
        element.id : element.inFavorites ,
      });
    });

    print(faveriots.toString());

    emit(HomeStatesSuccesState());
  })
      .catchError((error){
        print(error.toString());
        emit(HomenStatesErrorState(error.toString()));
  });
}

  Categories_model? modelCategores;
  void GetHomeCategoriesData(){
    emit(HomeStatesCategoriesLoadingState());
    DioHelper.getData(
      url: Get_Categories,
      tokenn:Token,
    ).then((value) {
      modelCategores = Categories_model.fromJson(value?.data);
      // print('///////////////////////////////////////////////////////////////////////////////////////////////////');
     // print(value?.data);
      emit(HomeStatesSuccesCategoriesState());
    })
        .catchError((error){
      print(error.toString());
      emit(HomenStatesErrorCategoriesState(error.toString()));
    });
  }

  ChangeFaveriotsModel? changeFaveriotsModel;
void CahngeFaveriotes(int ProductID){
  faveriots[ProductID] = !faveriots[ProductID]!;
  emit(HomeStatesChangeFaveriotesSuccesState());

    DioHelper.PostData(url: FAVORITE, data:{'product_id':ProductID } ,tokenn:Token )
        .then((value)  {
      changeFaveriotsModel = ChangeFaveriotsModel.fromJson(value.data);
      // print(value.data);

      if(changeFaveriotsModel?.status == false){
        faveriots[ProductID] = !faveriots[ProductID]!;
      }else{
        GetHomeFaveriotData();
      }
           emit(HomeStatesSuccesFaveriotesState(changeFaveriotsModel));

    })
        .catchError((error) {
      faveriots[ProductID] = !faveriots[ProductID]!;
      emit(HomenStatesErrorFaveriotesState(error.toString()));
    });
   }



  FaveriotModel? modelFaveriot;
  void GetHomeFaveriotData(){
    emit(HomeStatesLoadingFaveriotesPageState());

    DioHelper.getData(
      url: FAVORITE,
      tokenn:Token,
    ).then((value) {
      modelFaveriot = FaveriotModel.fromJson(value?.data);
      // print('-----------');
      // print(value?.data.toString());
      // print(value?.data);
      emit(HomeStatesSuccesFaveriotesPageState());
    })
        .catchError((error){
     // print(error.toString());
      emit(HomenStatesErrorFaveriotesPageState(error.toString()));
    });
  }


  ShopLoginModel? modelProfile;
  void GetProfileData(){
    emit(HomeStatesLoadingProfilePageState());
    DioHelper.getData(
      url: PROFILE,
      tokenn:Token,
    ).then((value) {
      modelProfile = ShopLoginModel.fromJson(value?.data);
      print('?????????????????????????????');

      print(modelProfile?.data?.name);
      // print(value?.data);
      emit(HomeStatesSuccesProfilePageState(modelProfile));
    })
        .catchError((error){
      print(error.toString());
      emit(HomenStatesErrorProfilePageState(error.toString()));
    });
  }


  void GetUpdateProfileData({
    required String name,
    required String phone,
    required String email,
}){
    emit(HomeStatesLoadingUpdateProfilePageState());
    DioHelper.PutData(
      url: UPDATEPROFILE,
      tokenn:Token,
      data: {
       'name':name,
        'phone':phone,
        'email':email,
      },
    ).then((value) {
      modelProfile = ShopLoginModel.fromJson(value?.data);
      print('?????????????????????????????');

      print(modelProfile?.data?.name);
      // print(value?.data);
      emit(HomeStatesSuccesUpdateProfilePageState(modelProfile));
    })
        .catchError((error){
      print(error.toString());
      emit(HomenStatesErrorUpdateProfilePageState(error.toString()));
    });
  }


}