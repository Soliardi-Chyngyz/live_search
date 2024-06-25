import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_search/text_field/app_text_field.dart';

class AppSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String? value)? onChanged;
  final bool enabled;
  final String hintText;
  final BoxFit boxFit;

  const AppSearchTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.enabled = true,
    this.hintText = 'Поиск',
    this.boxFit = BoxFit.none,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      inputType: TextInputType.text,
      onChanged: onChanged,
      enabled: enabled,
      hintText: hintText,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.asset(
          'assets/icons/search.svg',
          fit: BoxFit.none,
          width: 10,
          height: 10,
        ),
      ),
    );
  }
}
