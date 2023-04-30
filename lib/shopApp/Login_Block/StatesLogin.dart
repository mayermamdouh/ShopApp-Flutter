import 'Login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginStatesIntialState extends ShopLoginStates{}

class ShopLoginStatesLoadingState extends ShopLoginStates{}
class ShopLoginStatesSuccesState extends ShopLoginStates{
  final ShopLoginModel loginmodel;
  ShopLoginStatesSuccesState(this.loginmodel);
}
class ShopLoginStatesErrorState extends ShopLoginStates{
  final String Error;

  ShopLoginStatesErrorState(this.Error);
}



class ShopLoginPassVisabilityState extends ShopLoginStates{}