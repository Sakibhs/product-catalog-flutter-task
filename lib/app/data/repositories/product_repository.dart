import 'package:dio/dio.dart';

import '../models/product_model.dart';

class ProductRepository {
  ProductRepository({required Dio dio}) : _dio = dio;

  final Dio _dio;

  static const String _endpoint = '/products';

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get(_endpoint);

      final List<dynamic> data = response.data;

      return data
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ??
            e.message ??
            'Failed to fetch products',
      );
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }
}