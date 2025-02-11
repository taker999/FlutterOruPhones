import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../widgets/button_widget.dart';
import '../widgets/logo_widget.dart';
import 'enter_name_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // logo
            LogoWidget(),

            // login
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Verify Mobile No.',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Text(
                        'Please enter the 4 digital verification code sent to your mobile number via SMS',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 75),
                OtpTextField(
                  numberOfFields: 4,
                  fieldWidth: 53,
                  borderRadius: BorderRadius.circular(10),
                  borderColor: Color(0xFF512DA8),
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onSubmit: (String verificationCode) {
                    otp = verificationCode;
                  },
                ),
                SizedBox(height: 50),
                Center(
                  child: Text(
                    "Didn't receive OTP?",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 100),
                ButtonWidget(
                  onPressed: () {
                  },
                  text: 'Verify OTP',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
