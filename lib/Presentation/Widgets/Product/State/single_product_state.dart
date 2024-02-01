import 'dart:convert';
import 'package:filterapi/Domain/Models/carts_model.dart';
import 'package:filterapi/Domain/Models/products_model.dart';

abstract class SingleProductstate {}

class SingleProductInitialState extends SingleProductstate {}

class SingleProductLoadedState extends SingleProductstate {

  // final  List<Products> loadedSingleProducts;

  String imageurl ;

  SingleProductLoadedState(this.imageurl );
}

class SingleProductLoadingState extends SingleProductstate {}

class SingleProductEmptyState extends SingleProductstate{

}

class SingleProductErrorState extends SingleProductstate {
  final String error;
  SingleProductErrorState({required this.error});
}

