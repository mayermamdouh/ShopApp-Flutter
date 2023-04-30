import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Login_Block/Login_Shopping_App.dart';
import '../../another thinks/CacheHelper.dart';
import '../../another thinks/component.dart';
import '../HomeCubit.dart';
import '../HomeSates.dart';

class Settings_Screen extends StatelessWidget {
  @override
  var nameControler = TextEditingController();
  var emailControler = TextEditingController();
  var phoneControler = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeSates>(

      listener: (context,state){
        if(state is HomeStatesSuccesUpdateProfilePageState){
          showToast(text:state.modelProfile!.message!, states: ToastStates.SUCCESS);
        }
      },
      builder:(context,state){
        var modelToGetData = HomeCubit.get(context).modelProfile;
        nameControler.text = modelToGetData!.data!.name!;
        emailControler.text = modelToGetData.data!.email!;
        phoneControler.text = modelToGetData.data!.phone!;
        var FormKey = GlobalKey<FormState>();
        return ConditionalBuilder(

          condition: HomeCubit.get(context).modelProfile != null,
          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: FormKey,
                child: Column(
                  children: [
                    if(state is HomeStatesLoadingUpdateProfilePageState)
                      LinearProgressIndicator(),
                    Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Profile',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                              // Text('login now to browse our hot offers',style:
                              // TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.bold),),
                              SizedBox(height: 30,),
                              TextButtom(
                                type: TextInputType.text,
                                controller: nameControler,
                                icon: Icons.person,
                                lable: 'Name User',
                                // onSum
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Name must be not empty\nplease enter your name';
                                  }
                                },
                              ),
                              SizedBox(height: 20,),
                              TextButtom(
                                controller: emailControler,
                                icon: Icons.email,
                                lable: 'Email',
                                type: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Eamil must be not empty';
                                  }
                                  // else if (!value.contains("@")) {
                                  //   return 'Must enter email please';
                                  // }
                                },
                              ),
                              SizedBox(height: 15,),
                              TextButtom(
                                controller: phoneControler,
                                icon: Icons.phone_iphone,
                                lable: 'Phone Number',
                                type: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Phone Number must be not empty';
                                  }
                                  else if (value.length == 10) {
                                    return 'Password must be at least 11 characters long';
                                  }
                                },
                              ),
                              SizedBox(height: 24),
                              ButtonLogin(
                                  function: (){
                                    if (FormKey.currentState!.validate()) {
                                      HomeCubit.get(context).GetUpdateProfileData(name:nameControler.text, phone: phoneControler.text, email: emailControler.text);
                                    }
                                  },
                                  width: double.infinity, height: 40, text: 'Update Profile'),
                              SizedBox(height: 20),
                              ButtonLogin(
                                  function: (){
                                    CacheHelper.removeSpecialThinksharedPreferences(key: 'token')
                                        .then((value) {
                                      if (value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login_Page_App_Shopping()),
                                        );
                                      }
                                    });
                                  },
                                  width: double.infinity, height: 40, text: 'SIGN OUT'),


                            ],
                          ),
                        ),
                      ),
                    ) ,
                ],
                ),
              ),
            );
          },

        );
      } ,

    );
  }
}
