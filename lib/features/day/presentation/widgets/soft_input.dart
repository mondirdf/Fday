import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class SoftInput extends StatelessWidget {
  const SoftInput({
    super.key,
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: const TextStyle(color: AppColors.primaryText),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.secondaryText),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
