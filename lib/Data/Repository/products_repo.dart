import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../Application/Services/APIServices/api_services.dart';


class ProductRepository {

  static Future<List> getProductsrepo() async {

    try {
      return await Api.getProducts().then(
            (value) {
          print('data inside of the products repository is $value');
          return value;
        },
      ).catchError((e) {
        throw e;
      });
    } catch (e) {
      print('Error in Repository: $e');
      rethrow;
    }


  }

}