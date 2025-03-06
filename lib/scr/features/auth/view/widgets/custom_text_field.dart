import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.errorText,
    required this.hintText,
    this.obscureText,
    // required this.onChanged,
    required this.validator,
  });

  final TextEditingController controller;
  final String? errorText;
  final String hintText;
  final bool? obscureText;
  // final void Function(String) onChanged;
  final String? Function(String?) validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText ?? false,
      // onChanged: widget.onChanged,
      validator: widget.validator,
      style: context.textExt.normal,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colorExt.lightBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colorExt.lightBorderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: context.colorExt.backgroundColor,
        hintStyle: context.textExt.normal.copyWith(color: Colors.grey),
        errorStyle: context.textExt.normal.copyWith(
          color: Colors.red,
        ),
        hintText: widget.hintText,
        errorText: widget.errorText,
      ),
    );
  }
}
