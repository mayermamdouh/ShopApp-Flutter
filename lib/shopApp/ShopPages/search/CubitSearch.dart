import 'package:api_project/shopApp/ShopPages/HomeCubit.dart';
import 'package:api_project/shopApp/another%20thinks/DioHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Search_model.dart';
import 'StatesSearch.dart';

const SEARCH = 'products/search';
class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchrStatesIntialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);


   SearchModel? modelSearch;

   void Search(String text){
     emit(ShopSearchStatesLoadingState());
     DioHelper.PostData(
         url:SEARCH ,
         tokenn: Token,
         data: {
           'text': text
         },
     ).then((value) {
       modelSearch = SearchModel.fromJson(value.data);
       emit(ShopSearchStatesSuccesState());
     } ).catchError((onError){
       print(onError.toString());
       emit(ShopSearchStatesErrorState(onError.toString()));
     });
   }

}