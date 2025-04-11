import 'package:flutter/material.dart';

class HighStyleObscureTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final InputBorder? enabledBorder;
  final String? errorText;

  const HighStyleObscureTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.enabledBorder,
    this.errorText
  });

  @override
  State<HighStyleObscureTextField> createState() => _HighStyleObscureTextFieldState();
}

class _HighStyleObscureTextFieldState extends State<HighStyleObscureTextField> {
  bool _isObscured = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _isObscured,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        enabledBorder: widget.enabledBorder ?? const OutlineInputBorder(),
        errorText: widget.errorText,
        suffixIcon: IconButton(
          icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ),
      ),
    );
  }
}
