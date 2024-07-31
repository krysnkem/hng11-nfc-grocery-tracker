import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocey_tag/core/constants/app_images.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/apptext.dart';
import 'package:intl/date_time_patterns.dart';

class Inputboxes extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Icon? prefixpath;
  const Inputboxes(
      {super.key,
      required this.text,
      this.prefixpath,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text),
        Container(
          width: width,
          height: height,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                borderSide: BorderSide(width: 0.5.sp),
              ),
              prefixIcon: prefixpath,
            ),
          ),
        ),
      ],
    );
  }
}

class QuantityInput extends StatelessWidget {
  final String text;
  final double width;
  final double height;

  const QuantityInput(
      {super.key,
      required this.text,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text),
        Container(
          width: width,
          height: height,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.sp),
                    bottomLeft: Radius.circular(12.sp)),
                borderSide: BorderSide(width: 0.5.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class quantity extends StatefulWidget {
  const quantity({super.key});

  @override
  _quantityState createState() => _quantityState();
}

class _quantityState extends State<quantity> {
  String? _selectedValue = 'Litre';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 5.w.padA,
      width: 75.sp,
      height: 48.sp,
      decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
          ),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12), topRight: Radius.circular(12))),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: _selectedValue,
        items: [
          DropdownMenuItem(
            value: 'Litre',
            child: Text('Litre'),
          ),
          DropdownMenuItem(
            value: 'Unit',
            child: Text('Unit'),
          ),
          DropdownMenuItem(
            value: 'Kg',
            child: Text('Kg'),
          ),
        ],
        onChanged: (String? newValue) {
          setState(() {
            _selectedValue = newValue;
          });
        },
        isExpanded: true,
        underline: Container(),
        hint: Text('Select Quantity'),
      ),
    );
  }
}
