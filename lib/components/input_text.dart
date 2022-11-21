import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  String label;
  bool obscureText;
  TextEditingController controller;
  String? confirmation;
  String? initValue;

  InputText({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.controller,
    this.confirmation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: (value) {
            String? msg;
            switch (label) {
              case "Email":
                if (value == null || value.isEmpty) {
                  msg = 'This field is required';
                } else {
                  msg = null;
                }
                break;

              case "Password":
                if (value == null || value.isEmpty) {
                  msg = 'This field is required';
                } else {
                  msg = null;
                }
                break;

              case "Confirm Password":
                if (value == null || value.isEmpty) {
                  msg = 'This field is required';
                } else if (value != confirmation) {
                  msg = 'Not Match';
                } else {
                  msg = null;
                }
                break;

              default:
            }
            return msg;
          },
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
