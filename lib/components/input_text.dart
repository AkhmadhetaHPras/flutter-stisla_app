import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  String label;
  bool obscureText;
  TextEditingController controller;
  String? confirmation;

  InputText({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.controller,
    this.confirmation,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  String? initValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          validator: (value) {
            String? msg;
            switch (widget.label) {
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
                } else if (value != widget.confirmation) {
                  msg = 'Not Match';
                } else {
                  msg = null;
                }
                break;

              case "Name":
                if (value == null || value.isEmpty) {
                  msg = 'This field is required';
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
          height: 20,
        ),
      ],
    );
  }
}
