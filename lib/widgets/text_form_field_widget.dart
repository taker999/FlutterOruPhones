import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({required this.controller, super.key, required this.isName});

  final TextEditingController controller;
  final bool isName;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: isName? TextInputType.name : TextInputType.phone,
      decoration: InputDecoration(
        prefixIcon: isName ? null : Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Text('+91'),
        ),
        hintText: isName ? 'Name' : 'Mobile Number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        } else if (!isName && !RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
          return 'Enter a valid 10-digit mobile number';
        }
        return null;
      },
    );
  }
}