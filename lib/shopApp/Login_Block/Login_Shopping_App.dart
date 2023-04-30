import 'package:api_project/shopApp/RegisterBlock/RegisterPageShoppingApp.dart';
import 'package:api_project/shopApp/ShopPages/HomeCubit.dart';
import 'package:api_project/shopApp/another%20thinks/CacheHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'package:fluttertoast/fluttertoast.dart';


import '../ShopPages/HomePage.dart';
import 'CubitLogin.dart';
import 'StatesLogin.dart';
import '../another thinks/component.dart';

class Login_Page_App_Shopping extends StatelessWidget {

  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var FormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: ( context, state) {
          if(state is ShopLoginStatesSuccesState){
            if(state.loginmodel.status!){
              print(state.loginmodel.message);
              print(state.loginmodel.data?.token);
              showToast(text:state.loginmodel.message!, states: ToastStates.SUCCESS);
              CacheHelper.saveData(key: 'token', value: state.loginmodel.data?.token).
              then((value) {
               Token = state.loginmodel.data?.token;
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
              showToast(text:state.loginmodel.message!, states: ToastStates.ERROR);
            }
          }

        },

        builder: (BuildContext context, state) {
          return  Scaffold(
           // appBar: AppBar(),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: FormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        Text('login now to browse our hot offers',style:
                        TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.bold),),
                        SizedBox(height: 30,),
                        TextButtom(
                          controller: emailcontroller,
                          icon: Icons.email,
                          lable: 'Email',
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
                          isPassword: ShopLoginCubit.get(context).isPasswordShown,
                          suffix:  ShopLoginCubit.get(context).suffix,
                          type: TextInputType.visiblePassword,
                          // onChanged: (value){
                          //   // if (FormKey.currentState!.validate()) {
                          //   //   ShopLoginCubit.get(context).userLogin(email: emailcontroller.text, password: passwordcontroller.text);
                          //   // }
                          // },
                          suffixpress: () {
                            ShopLoginCubit.get(context).FunctionVisvility();
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
                        SizedBox(height: 20,),

                        Conditional.single(
                          context: context,
                          conditionBuilder: (BuildContext context) =>  state is! ShopLoginStatesLoadingState,
                          widgetBuilder: (BuildContext context) =>
                              ButtonLogin(
                                  function: (){
                                    if (FormKey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).userLogin(email: emailcontroller.text, password: passwordcontroller.text);
                                    }
                                  },
                                  width: double.infinity, height: 35, text: 'Login'),
                          fallbackBuilder: (BuildContext context) => Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an Account?',
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPageShoppingApp()),
                                );
                              },
                              child: const Text('Register Now'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ) ,

          );

        },


      ),

    );

  }

}

Widget TextButtom({
  required TextEditingController controller,
  TextInputType? type,
  required String lable,
  IconData? icon,
  required String? Function(String?)? validator,
  IconData? suffix,
  bool isPassword = false,
  void Function()? suffixpress,
  ValueChanged<String>? onChanged,

 // Function() onSubmit,
}) =>
    TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: isPassword,
      keyboardType: type, //  no3 alhktbo gawa ya3ne number aw text....
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(
          icon,
        ),
        suffixIcon: suffix != null
            ? IconButton(
              onPressed: suffixpress,
               icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget ButtonLogin({
  required double width,
  Color background = Colors.blue,
  bool isUpperCase = true,
  required double height,
  void Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text.toLowerCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

