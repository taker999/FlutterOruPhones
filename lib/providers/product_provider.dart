import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../apis/api.dart';
import '../models/product_state.dart';

// The StateNotifier to handle fetching and managing products
class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier() : super(ProductState.initial());

  // Function to fetch products for the current page
  Future<void> fetchProducts() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final newProducts = await Api.fetchProducts({"page": state.page});

      // Check if there are more products to load
      bool hasMore = newProducts.isNotEmpty;

      // Update the state with the fetched products
      state = state.copyWith(
        products: [...state.products, ...newProducts],
        page: state.page + 1,
        isLoading: false,
        hasMore: hasMore,
      );
    } catch (e) {
      // Handle the error state
      state = state.copyWith(isLoading: false);
      throw Exception('Failed to load products');
    }
  }
}

// Define the ProductProvider using StateNotifierProvider
final productProvider = StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  return ProductNotifier();
});
