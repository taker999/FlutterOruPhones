import 'package:flutter/material.dart';

class AcceptTermsCheckboxWidget extends StatelessWidget {
  const AcceptTermsCheckboxWidget(
      {required this.onChanged, super.key, required this.isChecked});

  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: isChecked, onChanged: onChanged),
        Text('Accept '),
        InkWell(
          onTap: () {/* Navigate to Terms */},
          child: Text(
            'Terms and conditions',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
