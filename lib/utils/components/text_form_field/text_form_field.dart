import 'package:flutter/material.dart';

class EntranceTextFormField extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  FormFieldValidator<String>? validator;
  TextInputType? textInputType;
  bool? obscureText;

  EntranceTextFormField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.validator,
      this.textInputType,
      this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText ?? false,
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: hintText,
            border: const OutlineInputBorder()),
      ),
    );
  }
}
