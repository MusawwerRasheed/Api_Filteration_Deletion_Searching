import 'package:filterapi/Data/Repository/Products_repo.dart';
import 'package:filterapi/Domain/Models/products_model.dart';
import 'package:filterapi/Presentation/Widgets/Product/State/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class ProductsCubit extends Cubit<Productstate> {
  ProductsCubit() : super(ProductInitialState());

  List<Products> products = [];

  Future<void> getCubitProductsData() async {
    emit(ProductLoadingState());

    try {
      List response = await ProductRepository.getProductsrepo();
      print('response inside of cubit $response');

      if (response != null) {
        List responseData = response;
        products =
            List<Products>.from(responseData.map((e) => Products.fromJson(e)));
        emit(ProductLoadedState(products!));
      } else {}
    } catch (e) {
      emit(ProductErrorState(error: 'Error in cubit'));
    }
  }

  Future<void> deleteCubitProduct([int? prodId]) async {
    try {
      print('inside the delete function');

      if (products.isNotEmpty) {
        int productIndex =
            products.indexWhere((product) => product.id == prodId);

        if (productIndex != -1) {
          products.removeAt(productIndex);
          print('product index >>>> $productIndex');
          emit(ProductLoadedState(products));
        } else {
          emit(ProductErrorState(error: 'Cart with id $prodId not found'));
        }
      } else {
        emit(ProductErrorState(error: 'No data available'));
      }
    } catch (e) {
      emit(ProductErrorState(error: 'Error in cubit: $e'));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
