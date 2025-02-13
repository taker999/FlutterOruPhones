import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oru_phones/models/Product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../providers/brand_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isViewAll = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Fetch initial products
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productProvider.notifier).fetchProducts();
    });

    // Add scroll listener to detect when to load more products
    _scrollController.addListener(_scrollListener);

    Timer.periodic(Duration(seconds: 7), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page!.toInt() + 1) % images.length;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // Check if the user has reached the bottom to load more products
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(productProvider.notifier).fetchProducts();
    }
  }

  final PageController _pageController = PageController();

  List<String> images = [
    "assets/Property 1=Banner 1.png",
    "assets/Property 1=Banner 2.png",
    "assets/Property 1=Banner 3.png",
    "assets/Property 1=Banner 4.png",
    "assets/Property 1=Banner 5.png",
  ];

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productProvider);
    final brandAsync = ref.watch(brandProvider);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('OruPhones'),
      //   actions: [
      //     IconButton(icon: Icon(Icons.search), onPressed: () {}),
      //     ElevatedButton(onPressed: () {}, child: Text('Login')),
      //   ],
      // ),
      drawer: CustomDrawer(),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white.withAlpha(100),
              floating: true, // AppBar disappears when scrolling down
              elevation: 0, // Removes shadow

              flexibleSpace: Stack(
                children: [
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 10, sigmaY: 10), // Blur effect
                      child: Container(
                        color: Colors.white.withAlpha(100), // Light white tint
                      ),
                    ),
                  ),
                  FlexibleSpaceBar(
                    title: Text('Sell Your Old Phone'),
                    // background: Image.network(
                    //   'https://via.placeholder.com/400', // Replace with your image
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ],
              ),
            ),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //         (context, index) => ListTile(
            //       title: Text('Item $index'),
            //     ),
            //     childCount: 20, // Adjust list length
            //   ),
            // ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white.withAlpha(100),
              pinned: true,
              elevation: 0, // Removes shadow

              flexibleSpace: Stack(
                children: [
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 10, sigmaY: 10), // Blur effect
                      child: Container(
                        color: Colors.white.withAlpha(100), // Light white tint
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText:
                              'Search phones with make, model, company e...',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.orange,
                          ),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 20,
                                child: VerticalDivider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                              ),
                              Icon(CupertinoIcons.mic, size: 22,),
                            ],
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder( // When not focused
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder( // When focused
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: images.length,
                        effect: ScrollingDotsEffect(
                          activeDotColor: Colors.grey,
                          dotColor: Colors.grey.shade400,
                          dotHeight: 8,
                          dotWidth: 8,
                        ),
                      ),
                    ),
                    Text('What’s on your mind?',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    _buildCategoryIcons(),
                    SizedBox(height: 20),
                    Text('Top Brands',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    brandAsync.when(
                        data: (brands) => SizedBox(
                              height: 65,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: isViewAll ? brands.length : 8,
                                itemBuilder: (context, index) {
                                  final brand = brands[index];
                                  if (!isViewAll && index == 7) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          isViewAll = true;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'View All',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10,
                                                letterSpacing: -0.5,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Icon(
                                              Icons.arrow_forward,
                                              size: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0), // Add spacing
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: CachedNetworkImage(
                                          imageUrl: brand.imagePath, width: 50),
                                    ),
                                  );
                                },
                              ),
                            ),
                        loading: () => CircularProgressIndicator(),
                        error: (err, stack) => Text('Error: $err')),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            productState.isLoading && productState.products.isEmpty
                ? SliverFillRemaining(
                    child: Center(
                        child:
                            CircularProgressIndicator())) // Show loading indicator initially
                : SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildProductCard(productState.products[index]);
                      },
                      childCount: productState.products.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                  ),
            if (productState.isLoading && productState.products.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                      child: CircularProgressIndicator()), // Bottom Loader
                ),
              ),
            SliverToBoxAdapter(
              child: _buildFAQSection(),
            ),
            SliverToBoxAdapter(
              child: _buildFooter(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        6,
        (index) => Column(
          children: [
            Icon(Icons.phone_android, size: 40),
            Text('Category $index'),
          ],
        ),
      ),
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

  Widget _buildProductCard(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: product.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.marketingName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                      '${product.deviceRam}/${product.deviceStorage} · ${product.deviceCondition}',
                      style: TextStyle(color: Colors.green)),
                  SizedBox(height: 5),
                  Text(
                    '₹ ${product.listingPrice}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              width: double.infinity,
              height: 25,
              decoration: BoxDecoration(
                color: Color(0xFFD7D7D7),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                      8), // Add rounded corners to the bottom-left
                  bottomRight: Radius.circular(
                      8), // Add rounded corners to the bottom-right
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${product.listingLocation}, ${product.listingState}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    product.listingDate,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return ExpansionTile(
      title: Text('Why should you buy used phones?'),
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child:
              Text('Buying used phones saves money and helps the environment.'),
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
            // Image.asset('assets/google_play.png', width: 100),
            // Image.asset('assets/app_store.png', width: 100),
          ],
        ),
      ],
    );
  }
}
