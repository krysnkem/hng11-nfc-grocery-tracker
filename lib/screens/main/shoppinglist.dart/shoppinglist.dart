import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/apptext.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/scanmodal.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<String> items = ['Milk', 'Sugar', 'Garri', 'Rice', 'Beans'];
  List<bool> checked = [
    false,
    false,
    false,
    false,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                "Shopping List",
                size: 22.sp,
                weight: FontWeight.w600,
              ),
              AppText(
                  "This is an automated list of items running low on stocks"),
            ],
          ),
        ),
        body: Column(
          children: [
            20.h.sbH,
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Checkbox(
                        activeColor: Colors.green,
                        onChanged: (bool? value) {
                          setState(() {
                            checked[index] = value!;
                          });
                        },
                        value: checked[index],
                      ),
                      title: Row(
                        children: [
                          AppText(items[index]),
                          40.w.sbW,
                          AppText("(0)"),
                        ],
                      ),
                      trailing: SizedBox(
                          width: 68.sp,
                          height: 28.sp,
                          child: AppButton(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ScanModalwidget(
                                      itemName: items[index],
                                      checked: checked[index],
                                    );
                                  });
                            },
                            isOutline: true,
                            textColor: Colors.grey.shade400,
                            text: "Restock",
                            borderColor: Colors.grey.shade400,
                            borderRadius: 16.sp,
                          )),
                    );
                  }),
            )
          ],
        ));
  }
}
