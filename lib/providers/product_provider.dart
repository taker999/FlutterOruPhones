import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../apis/api.dart';
import '../models/Product.dart';

class ProductStateNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  ProductStateNotifier() : super(const AsyncValue.loading());

  Future<void> fetchProducts(Map<String, dynamic>? filterData) async {
    try {
      final products = await Api.fetchProducts(
          filterData);
      state = AsyncValue.data(products);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final productProvider =
    StateNotifierProvider<ProductStateNotifier, AsyncValue<List<Product>>>(
  (ref) => ProductStateNotifier(),
);
