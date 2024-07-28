import 'dart:io';

import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextOverflow? overflow;
  final double? size;
  final double? height;
  final int? maxLine;
  final String? family;
  final bool? isBold;
  final FontStyle fontStyle;
  final TextStyle? style;
  final Locale? locale;
  final FontWeight? weight;
  final TextDecoration? decoration;
  final TextAlign? align;

  const AppText(
      this.text,
      {Key? key,
      this.color,
      this.overflow,
      this.size,
      this.weight,
      this.align,
      this.maxLine,
      this.locale,
      this.height,
      this.family,
      this.style,
      this.isBold,
      this.decoration, this.fontStyle = FontStyle.normal
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: size,
        height: height,
        decoration: decoration,
        fontFamily: family,
        color: color,
        // fontFamily: family,
        overflow: overflow,
        fontStyle: fontStyle,
        fontWeight: weight ?? (isBold == true ? FontWeight.w600 : FontWeight.w400)
      ),
      textAlign: align ?? TextAlign.start,
      selectionColor: Theme.of(context).primaryColor.withOpacity(0.15),
      maxLines: maxLine,
    );
  }
}
