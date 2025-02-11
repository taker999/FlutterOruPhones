import 'package:flutter/material.dart';

import '../widgets/button_widget.dart';
import '../widgets/logo_widget.dart';
import '../widgets/text_form_field_widget.dart';

class EnterNameScreen extends StatefulWidget {
  const EnterNameScreen({super.key});

  @override
  State<EnterNameScreen> createState() => _EnterNameScreenState();
}

class _EnterNameScreenState extends State<EnterNameScreen> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
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
                          'SignUp to continue',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100),
                  Text('Please Tell Us Your Name *'),
                  TextFormFieldWidget(
                    controller: _nameController, isName: true,
                  ),
                  SizedBox(height: 100),
                  ButtonWidget(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Proceed with the next step
                      }
                    }, text: 'Confirm Name',
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
