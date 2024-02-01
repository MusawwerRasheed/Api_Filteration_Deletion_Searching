import 'package:filterapi/Data/Repository/Products_repo.dart';
import 'package:filterapi/Domain/Models/products_model.dart';
import 'package:filterapi/Presentation/Widgets/Product/State/product_state.dart';
import 'package:filterapi/Presentation/Widgets/Product/State/single_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class SingleProductCubit extends Cubit<SingleProductstate> { // Fix typo: SingleProductstate -> SingleProductState
  SingleProductCubit() : super(SingleProductInitialState());

  Future<void> getCubitSingleProductData({String keyword = ''}) async {
    emit(SingleProductLoadingState());
    try {
      List response = await ProductRepository.getProductsrepo();
      print('response inside of cubit $response');

      if (response != null) {
        List responseData = response;
        List<Products> products = List<Products>.from(responseData.map((e) => Products.fromJson(e)));
        List<String> searchedProducts = [];
        if (keyword.isNotEmpty) {
          searchedProducts = products.where((product) => product.title!.contains(keyword)).map((product) => product.image!).toList();
          for(String imageUrl in searchedProducts) {
            emit(SingleProductLoadedState(imageUrl));
          }
        }
        else if(keyword == ''){
          emit(SingleProductInitialState());
        }
      } else {
        // Handle the case when response is null
      }
    } catch (e) {
      emit(SingleProductErrorState(error: 'Error in cubit'));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
