import 'package:flutter/material.dart';

import '../widgets/accept_terms_checkbox_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/logo_widget.dart';
import '../widgets/text_form_field_widget.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

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
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        Text(
                          'Sign in to continue',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100),
                  Text('Enter Your Phone Number'),
                  TextFormFieldWidget(
                    controller: _phoneController,
                    isName: false,
                  ),
                  SizedBox(height: 100),
                  AcceptTermsCheckboxWidget(
                    isChecked: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  ButtonWidget(
                    onPressed: isChecked
                        ? () async {
                            if (_formKey.currentState!.validate()) {
                              // Proceed with the next step
                              if(mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OtpScreen(),
                                  ),
                                );
                              }
                            }
                          }
                        : null,
                    text: 'Next',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
