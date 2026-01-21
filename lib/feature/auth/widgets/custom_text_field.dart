import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    // Styling from requirements:
    // Width: 343 (Handled by parent constraints usually, but flexible here)
    // Height: 56 (Container height or content padding adjustments)
    // Border Radius: 7.63px
    // Border Width: 0.95px
    // Padding: 16px

    return SizedBox(
      height: 56, // Enforcing height as requested
      // width: 343, // Ideally let width be flexible based on parent padding
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 16, // Typical size matching 56px height
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 7.63,
                  ), // Padding + Gap
                  child: Icon(prefixIcon, color: Colors.grey),
                )
              : const SizedBox(width: 16), // Padding if no icon
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 24,
          ),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ), // Padding: 16px
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.63), // Border Radius
            borderSide: const BorderSide(
              width: 0.95, // Border Width
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.63),
            borderSide: BorderSide(width: 0.95, color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.63),
            borderSide: const BorderSide(
              width: 0.95,
              color: Color(0xFF1B5E20), // Active color
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.63),
            borderSide: const BorderSide(width: 0.95, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.63),
            borderSide: const BorderSide(width: 0.95, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
