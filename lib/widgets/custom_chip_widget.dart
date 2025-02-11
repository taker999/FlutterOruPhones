import 'package:flutter/material.dart';

class CustomChipWidget extends StatelessWidget {
  const CustomChipWidget({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Colors.white,
      label: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30),
            SizedBox(height: 5),
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: -0.5)),
          ],
        ),
      ),
    );
  }
}
