import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  // final String initValue;
  final String text;
  final bool readOnly;
  final bool enable;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final Icon prefixIcon;
  final bool isRequired;
  final Widget? suffixWidget;
  final Function()? onTap;
  final String? helperText;

  const CustomTextField({
    super.key,
    required this.controller,
    // required this.initValue,
    required this.text,
    required this.readOnly,
    required this.enable,
    required this.textInputType,
    required this.textInputAction,
    required this.prefixIcon,
    required this.isRequired,
    this.suffixWidget,
    this.onTap,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        style: const TextStyle(color: Colors.black87),
        // initialValue: initValue,
        readOnly: readOnly,
        enabled: enable,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          prefixIconColor: Colors.grey,
          hoverColor: Colors.grey.withOpacity(0.1),
          focusColor: Colors.grey,
          fillColor: Colors.grey.withOpacity(0.2),
          filled: !enable ? true : false,
          labelStyle: const TextStyle(color: Colors.grey),
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
          hintText: text,
          labelText: text,
          suffixIcon: suffixWidget,
          helperText: helperText,
          helperStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
        ),
        validator: (String? value) {
          if (isRequired) {
            if (value == null || value.isEmpty) {
              return "$text is required";
            }
          }
          return null;
        },
        onTap: onTap,
      ),
    );
  }
}
