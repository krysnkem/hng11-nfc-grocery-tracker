import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/core/constants/pallete.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';

import 'apptext.dart';

class AppTextField extends StatefulWidget {
  final String? hintText;
  final String? Function(String?)? validator;
  final String? hint;
  final String? labelText;
  final bool readonly;
  final bool borderless;
  final bool isPassword;
  final Widget? suffixIcon;
  final Widget? errorWidget;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? label;
  final Widget? prefix;
  final double? textSize;
  final double? borderRadius;
  final Color? hintColor;
  final Color? fillColor;
  final Color? textColor;
  final bool? enabled;
  final bool? overrideIconColor;
  final VoidCallback? onTap;
  final InputBorder? enabledBorder;
  final int? maxLength;
  final int maxHeight;
  final bool? haveText;
  final TextCapitalization? textCapitalization;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final double? boxWidth;

  const AppTextField({
    Key? key,
    this.readonly = false,
    this.borderless = false,
    this.isPassword = false,
    this.hintText,
    this.hint,
    this.onChanged,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.autofillHints,
    this.suffixIcon,
    this.textSize,
    this.haveText,
    this.maxLength,
    this.labelText,
    this.label,
    this.contentPadding,
    this.prefix,
    this.maxHeight = 1,
    this.hintColor,
    this.textColor,
    this.inputFormatters,
    this.errorWidget,
    this.enabled,
    this.fillColor,
    this.overrideIconColor,
    this.enabledBorder,
    this.boxWidth, this.borderRadius, this.textCapitalization,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focusNode = FocusNode();
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        isVisible = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: widget.boxWidth ?? size.width,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.hintText != null
              ? Column(
            children: [
              AppText(
                widget.hintText ?? "",
                size: widget.textSize ?? 14.sp,
                color: widget.hintColor,
                // isBold: true,
                align: TextAlign.start,
              ),
              2.0.sbH,
            ],
          )
              : 0.0.sbH,
          TextFormField(
            textAlign: TextAlign.start,
            validator: widget.validator,
            autofillHints: widget.autofillHints,
            onEditingComplete: widget.onEditingComplete,
            onFieldSubmitted: widget.onFieldSubmitted,
            textCapitalization: widget.textCapitalization==null? TextCapitalization.none: widget.textCapitalization!,
            maxLines: widget.maxHeight,
            focusNode: _focusNode,
            maxLength: widget.maxLength,
            onChanged: (val) {
              if (widget.onChanged != null) {
                widget.onChanged!(val);
              }
            },
            onTap: widget.onTap,
            readOnly: widget.readonly,
            enabled: widget.enabled,
            obscureText: widget.isPassword ? !isVisible : false,
            textInputAction: TextInputAction.next,
            controller: widget.controller,
            style: Theme.of(context).textTheme.bodyMedium,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              filled: true, // Add this line to enable filled decoration
              errorMaxLines: 3,
              counter: 0.0.sbH,
              hintText: widget.hint,
              enabled: widget.enabled ?? true,
              fillColor: widget.fillColor ?? Colors.transparent,
              error: widget.errorWidget,
              prefixIconColor: widget.overrideIconColor == true
                  ? null
                  : const Color(0xFFD9D9D9),
              suffixIconColor: widget.overrideIconColor == true
                  ? null
                  : const Color(0xFFD9D9D9),
              prefixIcon: widget.prefix == null
                  ? null
                  : SizedBox(
                  height: 40,
                  width: 40,
                  child: Align(
                      alignment: Alignment.center, child: widget.prefix)),
              suffixIcon: widget.suffixIcon ??
                  (widget.isPassword
                      ? IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: widget.suffixIcon ??
                          Icon(
                            !isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            size: 20,
                          ))
                      : widget.suffixIcon),

              label: widget.label,
              labelText: widget.labelText,
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: widget.textColor ?? const Color(0xFFD9D9D9)),
              isDense: true,
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                      widget.borderless ? Colors.transparent : primaryColor,
                      width: 0.8),
                  borderRadius: BorderRadius.circular(widget.borderRadius?? 8)),
              enabledBorder: widget.enabledBorder ??
                  OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.8,
                          color: widget.borderless
                              ? Colors.transparent
                              : Theme.of(context)
                              .disabledColor
                              .withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(widget.borderRadius?? 8)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 0.8),
                  borderRadius: BorderRadius.circular(widget.borderRadius?? 8)),
              errorStyle:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.borderless ? Colors.transparent : Colors.red),
              ),
              disabledBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.transparent, width: 0.8),
                  borderRadius: BorderRadius.circular(widget.borderRadius?? 8)),
            ),
            keyboardType: widget.keyboardType,
          )
        ],
      ),
    );
  }
}