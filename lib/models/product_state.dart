import 'Product.dart';

class ProductState {
  final List<Product> products;
  final int page;
  final bool isLoading;
  final bool hasMore;

  ProductState({
    required this.products,
    required this.page,
    required this.isLoading,
    required this.hasMore,
  });

  // Initial state
  ProductState.initial()
      : products = [],
        page = 1,
        isLoading = false,
        hasMore = true;

  ProductState copyWith({
    List<Product>? products,
    int? page,
    bool? isLoading,
    bool? hasMore,
  }) {
    return ProductState(
      products: products ?? this.products,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}