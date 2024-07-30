import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/core/constants/pallete.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/app-card.dart';
import 'package:grocey_tag/widgets/apptext.dart';

import '../../../core/constants/app_images.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/empty-state.dart';
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

  bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppText(
            "Shopping List",
            size: 22.sp,
            weight: FontWeight.w600,
          ),
        ),
        body: isEmpty
            ? const EmptyListState(
                text: "No Item in Shopping List",
                lottieFile: AppImages.emptyInventory)
            : Column(
                children: [
                  Padding(
                    padding: 16.sp.padH,
                    child: const Row(
                      children: [
                        Expanded(
                          child: AppText(
                              "This is an automated list of items running low on stocks"),
                        ),
                      ],
                    ),
                  ),
                  16.sp.sbH,
                  Expanded(
                    child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  items[index],
                                  size: 16.sp,
                                  weight: FontWeight.w600,
                                ),
                                40.w.sbW,
                                AppText("Quantity left: (0)"),
                              ],
                            ),
                            trailing: AppCard(
                              backgroundColor: whiteColor,
                              bordered: true,
                              radius: 30.sp,
                              borderWidth: 0.6.sp,
                              expandable: true,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.sp, vertical: 10.sp),
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
                              child: AppText(
                                "Restock",
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ));
  }
}
