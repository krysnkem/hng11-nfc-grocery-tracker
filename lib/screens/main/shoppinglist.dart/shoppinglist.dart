import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/core/constants/constants.dart';
import 'package:grocey_tag/core/enums/enum.dart';
import 'package:grocey_tag/core/models/item.dart';
import 'package:grocey_tag/providers/inventory_provider/inventory_provider.dart';
import 'package:grocey_tag/screens/main/add-item/add-item-screen.dart';
import 'package:grocey_tag/screens/main/home/widgets/confirm_should_over_write.dart';
import 'package:grocey_tag/screens/main/shoppinglist.dart/restockitem.dart';
import 'package:grocey_tag/utils/snack_message.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/apptext.dart';
import 'package:grocey_tag/widgets/scan_tag/show_read_button_sheet.dart';

import '../../../widgets/app_button.dart';

class ShoppingList extends ConsumerStatefulWidget {
  const ShoppingList({super.key});

  @override
  ConsumerState<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends ConsumerState<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    final shoppingList = ref.watch(inventoryProvider.notifier).shoppingList;
    return Scaffold(
        appBar: AppBar(
          title: AppText(
            "Shopping List",
            size: 22.sp,
            weight: FontWeight.w600,
          ),
        ),
        body: Column(
          children: [
            const AppText(
              "This is an automated list of items running low on stocks",
            ),
            20.h.sbH,
            Expanded(
              child: ListView.builder(
                  itemCount: shoppingList.length,
                  itemBuilder: (context, index) {
                    var item = shoppingList[index];
                    return ListTile(
                      title: Row(
                        children: [
                          AppText(item.name),
                          40.w.sbW,
                          AppText("(${item.quantity})"),
                          40.w.sbW,
                          if (item.isExpired) ...[
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const AppText(
                                'Expired',
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 11),
                              ),
                            ),
                          ],
                        ],
                      ),
                      trailing: SizedBox(
                          width: 68.sp,
                          height: 28.sp,
                          child: AppButton(
                            onTap: () {
                              ///TODO:REMOVE
                              navigationService.navigateToWidget(
                                Restockitem(
                                  item: item,
                                ),
                              );
                              return;

                              ///TODO:REMOVE
                              showReadButtonSheet(context: context).then(
                                (result) async {
                                  log('Result: ${result.status}');
                                  if (result.status == NfcReadStatus.success) {
                                    final item = result.data as Item;
                                    if (item.name != shoppingList[index].name) {
                                      showError(
                                        context,
                                        'This tag belongs to another Item',
                                      );
                                    } else {
                                      navigationService.navigateToWidget(
                                        Restockitem(
                                          item: item,
                                        ),
                                      );
                                    }
                                    return;
                                  }

                                  if (result.status == NfcReadStatus.empty) {
                                    showError(context, 'This tag is empty');
                                    return;
                                  }

                                  if (result.status ==
                                      NfcReadStatus.notForApp) {
                                    var message = 'Data is not for this app';
                                    showError(context, message);
                                    final shouldOverwrite =
                                        await confirmShouldOverWrite(context);

                                    if (shouldOverwrite) {
                                      navigationService.navigateToWidget(
                                          const AddItemScreen());
                                    }
                                    return;
                                  }

                                  if (result.error != null) {
                                    toast(result.error!);
                                  }
                                },
                              );
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

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showError(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: toast(
          message,
          success: false,
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
