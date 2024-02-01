import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../Application/Services/APIServices/api_services.dart';


class CartRepository {

  static Future<List> getCartsrepo() async {

    try {
      return await Api.getcarts().then(
            (value) {
          print('data inside of the carts repository is $value');
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