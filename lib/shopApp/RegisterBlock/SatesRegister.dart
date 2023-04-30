

import 'RegisterModel.dart';

abstract class ShopRedisterStates{}

class ShopRegisterStatesIntialState extends ShopRedisterStates{}

class ShopRegisterStatesLoadingState extends ShopRedisterStates{}

class ShopRegisterStatesSuccesState extends ShopRedisterStates{
  final ShopRegisterModel modelRegister;
  ShopRegisterStatesSuccesState(this.modelRegister);

}

class ShopRegisterStatesErrorState extends ShopRedisterStates{
  final String Error;
  ShopRegisterStatesErrorState(this.Error);
}



class ShopRegisterPassVisabilityState extends ShopRedisterStates{}