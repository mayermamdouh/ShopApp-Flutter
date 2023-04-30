import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import '../Login_Block/Login_Shopping_App.dart';
import '../ShopPages/HomeCubit.dart';
import '../ShopPages/HomePage.dart';
import '../another thinks/CacheHelper.dart';
import '../another thinks/component.dart';
import 'CubitRegister.dart';
import 'SatesRegister.dart';


class RegisterPageShoppingApp extends StatelessWidget {
  const RegisterPageShoppingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();
    var namecontroller = TextEditingController();
    var phonecontroller = TextEditingController();
    var FormKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRedisterStates>(

        listener: (BuildContext context, Object? state) {
          if(state is ShopRegisterStatesSuccesState){
            if(state.modelRegister.status!){
              print(state.modelRegister.message);
              print(state.modelRegister.data?.token);
              showToast(text:state.modelRegister.message!, states: ToastStates.SUCCESS);
              CacheHelper.saveData(key: 'token', value: state.modelRegister.data?.token).
              then((value) {
                Token = state.modelRegister.data?.token;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePageShop()),
                );
              }
              );
            }
            else
            {
              showToast(text:state.modelRegister.message!, states: ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: FormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        Text('Register now to browse our hot offers',style:
                        TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.bold),),
                        SizedBox(height: 30,),
                        TextButtom(
                          controller: namecontroller,
                          icon: Icons.person,
                          lable: 'Name',
                          type: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name must be not empty';
                            }
                          },
                        ),
                        SizedBox(height: 15,),
                        TextButtom(
                          controller: emailcontroller,
                          icon: Icons.email,
                          lable: 'Email Address',
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Eamil must be not empty';
                            } else if (!value.contains("@")) {
                              return 'Must enter email please';
                            }
                          },
                        ),
                        SizedBox(height: 15,),
                        TextButtom(
                          controller: phonecontroller,
                          icon: Icons.phone_android_outlined,
                          lable: 'Phone Number',
                          type: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone Number must be not empty';
                            }
                          },
                        ),
                        SizedBox(height: 15,),
                        TextButtom(
                          isPassword: ShopRegisterCubit.get(context).isPasswordShown,
                          suffix:  ShopRegisterCubit.get(context).suffix,
                          type: TextInputType.visiblePassword,
                          suffixpress: () {
                            ShopRegisterCubit.get(context).FunctionVisvility();
                          },
                          controller: passwordcontroller,
                          icon: Icons.lock,
                          lable: 'Password',
                          // onSum
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password must be not empty\nplease enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                          },
                        ),
                        SizedBox(height:  20,),

                        Conditional.single(
                          context: context,
                          conditionBuilder: (BuildContext context) => state is !ShopRegisterStatesLoadingState  ,
                          widgetBuilder: (BuildContext context) =>
                              ButtonLogin(
                                  function: (){
                                    if (FormKey.currentState!.validate()) {
                                      ShopRegisterCubit.get(context).userRegister(email: emailcontroller.text, password: passwordcontroller.text,
                                          name:namecontroller.text , phone: phonecontroller.text);
                                    }
                                  },
                                  width: double.infinity, height: 35, text: 'Register'),
                          fallbackBuilder: (BuildContext context) => Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 15,),

                      ],
                    ),

                  ),
                ),
              ),
            ),
          );
        },

      ),
    ) ;

  }
}
