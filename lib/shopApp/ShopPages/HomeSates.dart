import 'package:api_project/shopApp/ShopPages/products/modelFaveriots.dart';

import '../Login_Block/Login_model.dart';

abstract class HomeSates{}

class HomeIntialState extends HomeSates{}

class ShopLChangeBottomNavBarState extends HomeSates{}


class HomeStatesLoadingState extends HomeSates{}
class HomeStatesSuccesState extends HomeSates{}

class HomenStatesErrorState extends HomeSates{
  final String Error;
  HomenStatesErrorState(this.Error);
}


class HomeStatesCategoriesLoadingState extends HomeSates{}
class HomeStatesSuccesCategoriesState extends HomeSates{}

class HomenStatesErrorCategoriesState extends HomeSates{
  final String Error;
  HomenStatesErrorCategoriesState(this.Error);
}


class HomeStatesSuccesFaveriotesState extends HomeSates{
  final ChangeFaveriotsModel? model;
  HomeStatesSuccesFaveriotesState(this.model);

}

class HomenStatesErrorFaveriotesState extends HomeSates{
  final String Error;
  HomenStatesErrorFaveriotesState(this.Error);
}

class HomeStatesChangeFaveriotesSuccesState extends HomeSates{}

class HomeStatesLoadingFaveriotesPageState extends HomeSates{}
class HomeStatesSuccesFaveriotesPageState extends HomeSates{}
class HomenStatesErrorFaveriotesPageState extends HomeSates{
  final String Error;
  HomenStatesErrorFaveriotesPageState(this.Error);
}


class HomeStatesLoadingProfilePageState extends HomeSates{}
class HomeStatesSuccesProfilePageState extends HomeSates{
  final ShopLoginModel? modelProfile;
  HomeStatesSuccesProfilePageState(this.modelProfile);
}
class HomenStatesErrorProfilePageState extends HomeSates{
  final String Error;
  HomenStatesErrorProfilePageState(this.Error);
}


class HomeStatesLoadingUpdateProfilePageState extends HomeSates{}
class HomeStatesSuccesUpdateProfilePageState extends HomeSates{
  final ShopLoginModel? modelProfile;
  HomeStatesSuccesUpdateProfilePageState(this.modelProfile);
}
class HomenStatesErrorUpdateProfilePageState extends HomeSates{
  final String Error;
  HomenStatesErrorUpdateProfilePageState(this.Error);
}