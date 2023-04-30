import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../another thinks/DioHelper.dart';
import 'RegisterModel.dart';
import 'SatesRegister.dart';

const REGISTER = 'register';
String? error;

class ShopRegisterCubit extends Cubit<ShopRedisterStates> {
  ShopRegisterCubit() : super(ShopRegisterStatesIntialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);


 late ShopRegisterModel modelRegister;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterStatesLoadingState());
    DioHelper.PostData(
        url: REGISTER,
        data: {
          'email': email,
          'name': name,
          'phone': phone,
          'password': password,
        }).then((value) {
      print(value.data);
      modelRegister = ShopRegisterModel.fromJson(value.data);
      emit(ShopRegisterStatesSuccesState(modelRegister));
    }
    ).catchError((error) {
      print(error.toString());
      emit(ShopRegisterStatesErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPasswordShown = true;

  void FunctionVisvility(){
    suffix = isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    isPasswordShown = !isPasswordShown;
    emit(ShopRegisterPassVisabilityState());
  }
}