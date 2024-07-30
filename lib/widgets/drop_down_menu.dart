import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/utils/string-extensions.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/apptext.dart';

class DropDownMenu<T> extends StatelessWidget {
  final T? selectedOption;
  final Function(T) onSelect;
  final List<T> data;
  final bool enabled;
  final String hint;
  const DropDownMenu({
    super.key,
    required this.onSelect,
    required this.data,
    this.selectedOption,
    this.enabled = true,
    this.hint = 'Option',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.sp,
      width: 75.sp,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Theme.of(context)
                .disabledColor
                .withOpacity(0.5), // Border color
            width: 0.8, // Border width
          ),
        ),
      ),
      child: PopupMenuButton<T>(
        onSelected: onSelect,
        enabled: enabled,
        itemBuilder: (BuildContext context) {
          return data.map<PopupMenuItem<T>>((choice) {
            return PopupMenuItem<T>(
              value: choice,
              child: Builder(builder: (context) {
                var text = choice.toString();

                if (choice is Enum) {
                  text = (choice as Enum).name.toCapitalized();
                }
                return AppText(
                  text,
                  weight: FontWeight.w600,
                );
              }),
            );
          }).toList();
        },
        child: Row(
          children: [
            5.sp.sbW,
            Expanded(
              child: FittedBox(
                child: Padding(
                  padding: 10.sp.padV,
                  child: Builder(
                    builder: (context) {
                      var text = selectedOption?.toString() ?? hint;
                      if (selectedOption != null && selectedOption is Enum) {
                        text = (selectedOption as Enum).name.toCapitalized();
                      }
                      return AppText(
                        text,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 12),
                      );
                    },
                  ),
                ),
              ),
            ),
            5.sp.sbW,
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
