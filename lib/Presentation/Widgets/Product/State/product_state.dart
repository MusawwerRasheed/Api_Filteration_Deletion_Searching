import 'dart:convert';

import '../../../../Domain/Models/products_model.dart';



abstract class Productstate {}

class ProductInitialState extends Productstate {}

class ProductLoadedState extends Productstate {

  final  List<Products> loadedProducts;

  ProductLoadedState(this.loadedProducts );
}

class ProductLoadingState extends Productstate {}

class ProductEmptyState extends Productstate{

}

class ProductErrorState extends Productstate {
  final String error;
  ProductErrorState({required this.error});
}

