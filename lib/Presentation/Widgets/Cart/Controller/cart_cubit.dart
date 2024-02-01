import 'package:filterapi/Data/Repository/carts_repo.dart';
import 'package:filterapi/Domain/Models/carts_model.dart';
import 'package:filterapi/Presentation/Widgets/Cart/State/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class CartsCubit extends Cubit<CartState> {
  CartsCubit() : super(CartInitialState());
  List<Carts> carts = [];

  Future<void> getCubitCartsData([
    DateTime? startingDate,
    DateTime? endingDate,
  ]) async {
    emit(CartLoadingState());
    try {
      List response = await CartRepository.getCartsrepo();

      if (response != null) {
        List responseData = response;
        carts = List<Carts>.from(responseData.map((e) => Carts.fromJson(e)));

        if (startingDate == null) {
          emit(CartLoadedState(carts));
        } else {
          List<Carts> filteredCarts = carts.where((cart) {
            DateTime cartDate = cart.date!;
            return cartDate.isAfter(startingDate!) &&
                cartDate.isBefore(endingDate!);
          }).toList();

          emit(CartLoadedState(filteredCarts));
        }
      } else {
        emit(CartErrorState(error: 'No data available'));
      }
    } catch (e) {
      emit(CartErrorState(error: 'Error in cubit: $e'));
    }
  }

  Future<void> deleteCubitCartsData(int? cartId) async {
    try {
      if (carts.isNotEmpty) {
        int cartIndex = carts.indexWhere((cart) => cart.id == cartId);

        print('cart index is $cartIndex');
        if (cartIndex != -1) {
          carts.removeAt(cartIndex);
          emit(CartLoadedState(carts));
        } else {
          emit(CartErrorState(error: 'Cart with id $cartId not found'));
        }
      } else {
        emit(CartErrorState(error: 'No data available'));
      }
    } catch (e) {
      emit(CartErrorState(error: 'Error in cubit: $e'));
    }
  }


  Future<void> deleteCubitCartsProduct(int? prodId, int? cartId) async {
    try {
      print('Inside the delete cart product');

      if (carts.isNotEmpty) {
        Carts pickedCart = carts.firstWhere((element) => element.id == cartId);

        pickedCart.products!
            .removeWhere((element) => element.productId == prodId);

        emit(CartLoadedState(carts));
      }
    } catch (e) {
      emit(CartErrorState(error: 'An error occurred'));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
