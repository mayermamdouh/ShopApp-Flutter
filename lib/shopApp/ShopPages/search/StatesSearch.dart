

abstract class ShopSearchStates{}

class ShopSearchrStatesIntialState extends ShopSearchStates{}

class ShopSearchStatesLoadingState extends ShopSearchStates{}

class ShopSearchStatesSuccesState extends ShopSearchStates{}

class ShopSearchStatesErrorState extends ShopSearchStates{
  final String Error;
  ShopSearchStatesErrorState(this.Error);
}


