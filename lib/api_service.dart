import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model/product_model.dart';


class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  static Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/products/categories'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((category) => category.toString()).toList();
    } else {
      throw Exception('فشل في تحميل الفئات');
    }
  }

  static Future<List<Product>> fetchProducts(String category) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/products/category/${Uri.encodeComponent(category)}'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('فشل في تحميل المنتجات');
    }
  }
}