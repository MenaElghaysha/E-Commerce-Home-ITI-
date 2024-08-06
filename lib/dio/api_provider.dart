import 'package:dio/dio.dart';

import '../models/product_model.dart';

class ApiProvider {
  Future<ProductsModel?> getProducts() async {
    try {
      Response response = await Dio().get(
        'https://dummyjson.com/products',
        queryParameters: {'select': 'id,title,price,category,description,thumbnail'},
      );
      ProductsModel productsModel = ProductsModel.fromJson(response.data);
      return productsModel;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
