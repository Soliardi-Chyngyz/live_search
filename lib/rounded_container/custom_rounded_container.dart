import 'package:flutter/material.dart';

class CustomRoundedContainer extends StatelessWidget {
  const CustomRoundedContainer({
    super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.padding = const EdgeInsets.symmetric(vertical: 31),
    this.onTap,
    required this.child,
    this.borderRadiusGeometry,
    this.backGround = Colors.transparent,
    this.isShowBoxShadow = false,
    this.radius = 8,
    this.isShowBorder = true,
    this.boxShadows,
    this.width = double.infinity,
    this.boxBorder,
    this.gradient,
    this.height,
    this.strokeWidth = 1,
    this.showSplash = true,
  });

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Function()? onTap;
  final Widget child;
  final double? height;
  final double? width;
  final Color backGround;
  final bool isShowBoxShadow;
  final double radius;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final bool isShowBorder;
  final List<BoxShadow>? boxShadows;
  final BoxBorder? boxBorder;
  final Gradient? gradient;
  final double strokeWidth;
  final bool showSplash;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: gradient != null ? null : backGround,
        gradient: gradient,
        border: boxBorder ?? (isShowBorder ? Border.all(color: Colors.grey, width: strokeWidth) : null),
        borderRadius: borderRadiusGeometry ?? BorderRadius.all(Radius.circular(radius)),
        boxShadow: boxShadows,
      ),
      child: ClipRRect(
          borderRadius: borderRadiusGeometry ?? BorderRadius.all(Radius.circular(radius)),
          child: showSplash
              ? Material(
                  surfaceTintColor: backGround,
                  shadowColor: backGround,
                  color: backGround,
                  child: InkWell(
                    onTap: () => onTap?.call(),
                    child: Padding(
                      padding: padding ?? EdgeInsets.zero,
                      child: child,
                    ),
                  ),
                )
              : InkWell(
                  onTap: () => onTap?.call(),
                  child: Padding(
                    padding: padding ?? EdgeInsets.zero,
                    child: child,
                  ),
                )),
    );
  }
}

class NonClickableCustomRoundedContainer extends StatelessWidget {
  const NonClickableCustomRoundedContainer({
    super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.padding = const EdgeInsets.symmetric(vertical: 31),
    required this.child,
    this.borderRadiusGeometry,
    this.backGround = Colors.transparent,
    this.isShowBoxShadow = false,
    this.radius = 8,
    this.isShowBorder = true,
    this.boxShadows,
    this.width = double.infinity,
    this.boxBorder,
    this.height,
  });

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget child;
  final double? height;
  final double? width;
  final Color backGround;
  final bool isShowBoxShadow;
  final double radius;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final bool isShowBorder;
  final List<BoxShadow>? boxShadows;
  final BoxBorder? boxBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backGround,
        border: boxBorder ?? (isShowBorder ? Border.all(color: Colors.grey) : null),
        borderRadius: borderRadiusGeometry ?? const BorderRadius.all(Radius.circular(8)),
        boxShadow: boxShadows,
      ),
      child: ClipRRect(
        borderRadius: borderRadiusGeometry ?? const BorderRadius.all(Radius.circular(8)),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}
