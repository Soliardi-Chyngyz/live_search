import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? placeholder;
  final TextInputType? inputType;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onChanged;
  final Function(String? value)? onSaved;
  final Function(String? value)? onSubmitted;
  final String? Function(String? value)? validator;
  final bool checkOfErrorOnFocusChange;
  final Widget? prefixIcon;
  final String? error;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? helperText;
  final int? maxLines;
  final String? initialValue;
  final String? title;
  final String? label;
  final String? subTitle;
  final int? maxLength;
  final String? hintText;
  final String? prefix;
  final bool? enabled;
  final Color? titleColor;
  final TextStyle? hintTextStyle;
  final String? additionLabel;
  final double? height;
  final TextAlign textAlign;
  final Color? fillColor;
  final Color? enabledBorderColor;

  @override
  State<StatefulWidget> createState() => _AppTextField();

  const AppTextField({
    super.key,
    this.placeholder,
    this.controller,
    this.inputType,
    this.focusNode,
    this.textInputAction,
    this.validator,
    this.title,
    this.label,
    this.subTitle,
    this.autofocus = false,
    this.inputFormatters,
    this.onChanged,
    this.onSaved,
    this.onSubmitted,
    this.checkOfErrorOnFocusChange = false,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.helperText,
    this.maxLines = 1,
    this.initialValue,
    this.maxLength,
    this.hintText,
    this.prefix,
    this.enabled,
    this.hintTextStyle,
    this.titleColor,
    this.error,
    this.additionLabel,
    this.height,
    this.textAlign = TextAlign.start,
    this.fillColor,
    this.enabledBorderColor,
  });
}

class _AppTextField extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          RichText(
            text: TextSpan(
              text: widget.title!,
              children: [
                if (widget.additionLabel?.isNotEmpty == true)
                  TextSpan(
                    text: widget.additionLabel!,
                  ),
              ],
            ),
          ),
        if (widget.title != null) const SizedBox(height: 8),
        SizedBox(
          height: widget.height,
          child: TextFormField(
            enabled: widget.enabled,
            autovalidateMode: AutovalidateMode.disabled,
            focusNode: widget.focusNode,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            initialValue: widget.initialValue,
            controller: widget.controller,
            style: theme.textTheme.bodyLarge,
            autofocus: widget.autofocus,
            keyboardType: widget.inputType,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
            textAlignVertical:
                widget.maxLines != null && widget.maxLines! > 1 ? TextAlignVertical.top : TextAlignVertical.center,
            onFieldSubmitted: widget.onSubmitted ?? (_) => FocusScope.of(context).nextFocus(),
            validator: widget.validator,
            cursorColor: theme.primaryColor,
            obscureText: widget.inputType == TextInputType.visiblePassword ? widget.obscureText! : false,
            textAlign: widget.textAlign,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              filled: true,
              isDense: false,
              label: widget.label != null ? Text(widget.label!) : null,
              helperText: widget.helperText,
              hintText: widget.hintText,
              counterText: '',
              prefix: widget.prefix != null ? Text(widget.prefix!, style: theme.textTheme.bodyLarge) : null,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: widget.suffixIcon,
              ),
              suffixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 24),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: widget.maxLines != null && widget.maxLines! > 1 ? 12 : 0,
              ),
              focusColor: Colors.grey,
              fillColor: widget.fillColor ??
                  (widget.enabled == null || widget.enabled! ? theme.scaffoldBackgroundColor : Colors.grey),
              hintStyle: widget.hintTextStyle,
              helperStyle: theme.textTheme.titleMedium,
              errorStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: widget.enabledBorderColor ?? _enabledBorderColor,
                  // color: Colors.red,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: theme.colorScheme.onSecondary,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(width: 1, color: theme.colorScheme.onSecondary),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(width: 1, color: theme.colorScheme.error),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(width: 1, color: theme.colorScheme.error),
              ),
            ),
          ),
        ),
        if (widget.subTitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    widget.subTitle!,
                    style: theme.textTheme.bodySmall!.copyWith(color: theme.hintColor),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Color get _enabledBorderColor {
    final controller = widget.controller;
    if (controller == null) {
      return Colors.grey;
    }

    return controller.text.isNotEmpty ? Colors.grey : Colors.grey.withOpacity(.6);
  }
}
