import 'package:flutter/material.dart';
import 'package:training_app/app/AppColors.dart';

class AppFormField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final bool? enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;

  const AppFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.validator,
    this.enabled,
    this.keyboardType,
    this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: AppColors.hintColor),
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIconColor: AppColors.hintColor,
        suffixIcon: widget.suffixIcon,
      ),
      maxLines: widget.maxLines,
      validator: widget.validator,
      enabled: widget.enabled,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
    );
  }
}
