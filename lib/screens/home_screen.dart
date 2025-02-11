import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('OruPhones'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ElevatedButton(onPressed: () {}, child: Text('Login')),
        ],
      ),
      drawer: CustomDrawer(),
      body: productState.when(
        data: (products) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              log(product.imagePath);
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('What’s on your mind?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          _buildCategoryIcons(),
                          SizedBox(height: 20),
                          Text('Top Brands', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          _buildBrandRow(),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) => _buildProductCard(),
                      childCount: 10,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _buildFAQSection(),
                  ),
                  SliverToBoxAdapter(
                    child: _buildFooter(),
                  ),
                ],
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),  // Show loading if not loaded
        error: (error, stack) => Center(child: Text('Error: $error')),  // Show error if fetching fails
      ),
    );
  }

  Widget _buildCategoryIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(6, (index) => Column(
        children: [
          Icon(Icons.phone_android, size: 40),
          Text('Category $index'),
        ],
      )),
    );
  }

  Widget _buildBrandRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset('assets/apple.png', width: 50),
        Image.asset('assets/xiaomi.png', width: 50),
        Image.asset('assets/samsung.png', width: 50),
      ],
    );
  }

  Widget _buildProductCard() {
    return Card(
      child: Column(
        children: [
          Expanded(child: Image.asset('assets/phone.png', fit: BoxFit.cover)),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Apple iPhone 13 Pro', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('₹ 41,500', style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return ExpansionTile(
      title: Text('Why should you buy used phones?'),
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Buying used phones saves money and helps the environment.'),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text('Download Our App'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/google_play.png', width: 100),
            Image.asset('assets/app_store.png', width: 100),
          ],
        ),
      ],
    );
  }
}
