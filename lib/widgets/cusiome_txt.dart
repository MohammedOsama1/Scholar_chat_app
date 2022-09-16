import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.hint,
      this.controller,
      this.validator,
      this.isPass, this.widget})
      : super(key: key);
  final String hint;
  final TextEditingController? controller;
  String? Function(String?)? validator;
  bool? isPass ;
  Widget? widget;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: isPass ?? false,
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 17),
      decoration: InputDecoration(
          hintText: hint,
          suffixIcon: widget,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 17),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }
}
