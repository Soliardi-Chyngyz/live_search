import 'package:flutter/material.dart';
import 'package:live_search/text_field/app_text_field.dart';

class AppSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String? value)? onChanged;
  final bool enabled;
  final String hintText;
  final BoxFit boxFit;
  final Widget? prefixIcon;

  const AppSearchTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.enabled = true,
    this.hintText = 'Поиск',
    this.boxFit = BoxFit.none,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      inputType: TextInputType.text,
      onChanged: onChanged,
      enabled: enabled,
      hintText: hintText,
      prefixIcon: prefixIcon,
    );
  }
}
