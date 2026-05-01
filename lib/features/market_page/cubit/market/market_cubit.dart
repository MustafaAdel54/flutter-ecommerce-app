import 'dart:convert';

import 'package:e_commerce/shared/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  MarketCubit() : super(MarketInitial());

  List<ProductModel> allProducts = [];

  Future<void> fetchProducts() async {
    emit(MarketLoading());
    try {
      var url = Uri.https('api.escuelajs.co', 'api/v1/products');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final list = jsonDecode(response.body);
        final newList = list
            .map<ProductModel>((json) => ProductModel.fromMap(json))
            .toList();
        allProducts = newList;

        emit(MarketSuccess(allProducts));
      } else {
        emit(MarketError("Server error: ${response.statusCode}"));
      }
    } catch (e) {
      emit(MarketError("Failed to load products: ${e.toString()}"));
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      emit(MarketSuccess(allProducts));
    } else {
      final filteredProducts = allProducts.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(MarketSuccess(filteredProducts));
    }
  }
}
