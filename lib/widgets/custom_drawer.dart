import 'package:flutter/material.dart';

import 'custom_chip_widget.dart';
import 'custom_elevated_button.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Drawer Header
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 10),
                    Image.asset(
                      'assets/logo.png',
                      height: 45,
                    ),
                  ],
                ), // Your logo
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Login and Sell Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                CustomElevatedButton(
                  text: 'Login/SignUp',
                  color: Colors.indigo,
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                CustomElevatedButton(
                  text: 'Sell Your Phone',
                  color: Colors.amber,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Spacer(),

          // Bottom Menu Buttons
          GridView.count(
            crossAxisSpacing: 25,
            shrinkWrap: true,
            crossAxisCount: 3,
            padding: EdgeInsets.all(10),
            children: [
              CustomChipWidget(icon: Icons.shopping_cart, label: "How to Buy"),
              CustomChipWidget(icon: Icons.attach_money, label: "How to Sell"),
              CustomChipWidget(icon: Icons.menu_book, label: "Oru Guide"),
              CustomChipWidget(icon: Icons.info, label: "About Us"),
              CustomChipWidget(
                  icon: Icons.privacy_tip, label: "Privacy Policy"),
              CustomChipWidget(icon: Icons.help, label: "FAQs"),
            ],
          ),
        ],
      ),
    );
  }
}
