import 'package:api_project/shopApp/Login_Block/StatesLogin.dart';
import 'package:api_project/shopApp/another%20thinks/DioHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Login_model.dart';

const LOGIN = 'login';
String? error;

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit(): super(ShopLoginStatesIntialState());
  static ShopLoginCubit get(context)=> BlocProvider.of(context);

  late ShopLoginModel model;


  void userLogin({
  required String email,
  required String password,
}){
  emit(ShopLoginStatesLoadingState());
  DioHelper.PostData(
      url: LOGIN,
      data: {
    'email':email,
    'password':password,
  }).then((value) {
    print(value.data);
    model = ShopLoginModel.fromJson(value.data);
    emit(ShopLoginStatesSuccesState(model));
  }
  ).catchError((error){
  print(error.toString());
  emit(ShopLoginStatesErrorState(error.toString()));
  });
 }

 IconData suffix = Icons.visibility_off_outlined;
  bool isPasswordShown = true;

  void FunctionVisvility(){
    suffix = isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    isPasswordShown = !isPasswordShown;
    emit(ShopLoginPassVisabilityState());
  }
}



