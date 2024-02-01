import 'dart:convert';

import 'package:filterapi/Domain/Models/carts_model.dart';
import 'package:flutter/widgets.dart';



abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadedState extends CartState {

  final  List<Carts> loadedCarts;

  CartLoadedState(this.loadedCarts);

}

class Cartitemabsent extends CartState{
  
  String productAbsent  = 'Product absent'; 
  
  Cartitemabsent(); 

}
class CartLoadingState extends CartState {}

class CartEmptyState extends CartState{

}

class CartErrorState extends CartState {
  final String error;
  CartErrorState({required this.error});
}

