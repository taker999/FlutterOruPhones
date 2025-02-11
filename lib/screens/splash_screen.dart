import 'package:flutter/material.dart';
import 'package:flutter_oru_phones/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../apis/api.dart';
import '../providers/product_provider.dart';
import 'login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  Future<void> fetchData() async {
    await ref.read(productProvider.notifier).fetchProducts({});  // Fetch data here, using a filter if needed

    // Once data is fetched, navigate to Home screen
    await Future.delayed(Duration(seconds: 2));
    if(mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset('assets/Splash.json'),
    );
  }
}
