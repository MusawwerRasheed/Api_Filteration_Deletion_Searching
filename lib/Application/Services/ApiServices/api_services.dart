
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'https://fakestoreapi.com';

  static Future<List<dynamic>> getcarts() async {
  
    try {
      var headers = {
        'Content-Type': 'application/json',

       };

      final response = await http.get(
        Uri.parse('$baseUrl/carts'),
        headers: headers,

      );

      log('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Success');
        return json.decode(response.body);
      } else {
        print('Error: ${response.reasonPhrase}');
        throw HttpException('Failed to post data');
      }
    } catch (e) {
      if (e is SocketException) {
        print('Error: Network error - ${e.message}');
      } else if (e is HttpException) {
        print('Error: HTTP exception - ${e.message}');
      } else {
        print('Error: $e');
      }
      rethrow;
    }
  }




  static Future<List<dynamic>> getProducts() async {

    try {
      var headers = {
        'Content-Type': 'application/json',

      };

      final response = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: headers,

      );

      log('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Success');
        return json.decode(response.body);
      } else {
        print('Error: ${response.reasonPhrase}');
        throw HttpException('Failed to post data');
      }
    } catch (e) {
      if (e is SocketException) {
        print('Error: Network error - ${e.message}');
      } else if (e is HttpException) {
        print('Error: HTTP exception - ${e.message}');
      } else {
        print('Error: $e');
      }
      rethrow;
    }
  }


}
