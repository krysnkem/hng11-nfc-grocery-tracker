import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocey_tag/core/constants/app_images.dart';
import 'package:grocey_tag/core/constants/constants.dart';
import 'package:grocey_tag/core/constants/pallete.dart';
import 'package:grocey_tag/core/enums/enum.dart';
import 'package:grocey_tag/core/models/item.dart';
import 'package:grocey_tag/providers/inventory_provider/inventory_provider.dart';
import 'package:grocey_tag/screens/main/add-item/add-item-screen.dart';
import 'package:grocey_tag/screens/main/edit-item/edit-item-screen.dart';
import 'package:grocey_tag/screens/main/home/widgets/confirm_should_over_write.dart';
import 'package:grocey_tag/utils/snack_message.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/app_button.dart';
import 'package:grocey_tag/widgets/apptext.dart';
import 'package:grocey_tag/widgets/scan_tag/show_read_button_sheet.dart';
import 'package:grocey_tag/widgets/text-field-widget.dart';
import 'package:intl/intl.dart';

import '../../../widgets/filter.dart';

class Inventory extends ConsumerStatefulWidget {
  final Function(int) onNavigationItem;
  const Inventory({super.key, required this.onNavigationItem});

  @override
  ConsumerState<Inventory> createState() => _InventoryState();
}

class _InventoryState extends ConsumerState<Inventory> {
  @override
  Widget build(BuildContext context) {
    List<String> filterItems = ["Date Bought", "Quantity", "Expiry Date"];

    String? selectedFilter;

    onSelect(String val) {
      selectedFilter = val;
    }

    List<Map<String, dynamic>> item = [
      {
        "title": "Bell Carrot",
        "purchase date": "22 January 2024",
        "expiry date": "22 Aug 2027",
        "measureUnit": "KG",
        "quantity": 5,
      },
      {
        "title": "Melon Pods",
        "purchase date": "22 January 2024",
        "expiry date": "22 Aug 2027",
        "measureUnit": "Cups",
        "quantity": 10,
      },
      {
        "title": "Green Peas",
        "purchase date": "22 January  2024",
        "expiry date": "22 Aug 2027",
        "measureUnit": "KG",
        "quantity": 2,
      },
      {
        "title": "Fettucine Pasta",
        "purchase date": "22 January  2024",
        "expiry date": "22 Aug 2027",
        "measureUnit": "Packs",
        "quantity": 2,
      },
      {
        "title": "Indomie",
        "purchase date": "22 January  2024",
        "expiry date": "22 Aug 2027",
        "measureUnit": "Carton",
        "quantity": 1,
      },
      {
        "title": "Terylyaki",
        "purchase date": "22 January  2024",
        "expiry date": "22 Aug 2027",
        "measureUnit": "litres",
        "quantity": 4,
      },
      {
        "title": "Japan Macha",
        "purchase date": "22 January  2024",
        "expiry date": "22 Aug 2027",
        "measureUnit": "units",
        "quantity": 2,
      },
    ];

    bool isempty = false;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Inventory"),
          actions: [
            IconButton(
              onPressed: onAddItem,
              icon: SvgPicture.asset(
                AppImages.addlist,
                height: 24.sp,
                width: 24.sp,
              ),
            ),
            16.w.sbW
          ],
        ),
        body: isempty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SvgPicture.asset(AppImages.noResults,
                        height: 150.sp, width: 184.61.sp),
                  ),
                  AppText(
                    "Inventory",
                    weight: FontWeight.bold,
                    size: 22.sp,
                  ),
                  AppText(
                    "Your items would be managed here ",
                    weight: FontWeight.w300,
                    size: 14.sp,
                  ),
                  10.h.sbH,
                  AppButton(
                    width: 358.sp,
                    height: 46.sp,
                    onTap: () {},
                    text: "Register Your first Item",
                  ),
                  30.h.sbH,
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "Confused? Learn how it works ",
                      style: TextStyle(color: blackColor),
                    ),
                    const TextSpan(
                        text: "here", style: TextStyle(color: Colors.grey))
                  ]))
                ],
              )
            : GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Column(
                  children: [
                    Padding(
                      padding: 16.sp.padH,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppTextField(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.sp, vertical: 7.sp),
                              prefix: Icon(
                                CupertinoIcons.search,
                                size: 26.sp,
                              ),
                              hint: "Search",
                            ),
                          ),
                          20.w.sbW,
                          Container(
                            height: 48.sp,
                            width: 88.sp,
                            alignment: Alignment.center,
                            child: PopupMenuButton<String>(
                              onSelected: onSelect,
                              itemBuilder: (BuildContext context) {
                                return filterItems.map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: AppText(
                                      choice,
                                      weight: FontWeight.w400,
                                      size: 12.sp,
                                    ),
                                  );
                                }).toList();
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Filterbutton(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    15.h.sbH,
                    Expanded(
                      child: Builder(builder: (context) {
                        final inventory = ref.watch(inventoryProvider);
                        return ListView.builder(
                          itemCount: inventory.items.length,
                          itemBuilder: (context, index) {
                            final item = inventory.items[index];
                            return GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => EditItemScreen()));
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Row(
                                      children: [
                                        AppText(
                                          item.name,
                                          size: 16.sp,
                                          weight: FontWeight.w500,
                                        ),
                                        const Spacer(),
                                        trailer(
                                            date: DateFormat('d MMM yyyy')
                                                .format(item.purchaseDate),
                                            text: 'Purchase:')
                                      ],
                                    ),
                                    subtitle: Row(children: [
                                      AppText(
                                        ""
                                        "${item.quantity} ${item.metric.name.toUpperCase()} left",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 11.sp),
                                      ),
                                      const Spacer(),
                                      trailer(
                                        date: DateFormat('d MMM yyyy')
                                            .format(item.expiryDate),
                                        text: "Expiry:",
                                      ),
                                    ]),
                                  ),
                                  10.h.sbH
                                ],
                              ),
                            );
                          },
                        );
                      }),
                    )
                  ],
                ),
              ));
  }

  void onAddItem() {
    () {
      showReadButtonSheet(context: context).then(
        (result) async {
          log('Result: ${result.status}');
          if (result.status == NfcReadStatus.success) {
            final item = result.data as Item;
            navigationService.navigateToWidget(EditItemScreen(item: item));
            return;
          }

          if (result.status == NfcReadStatus.empty) {
            return;
          }

          if (result.status == NfcReadStatus.notForApp) {
            toast('Data is not for this app');
            final shouldOverwrite = await confirmShouldOverWrite(context);

            if (shouldOverwrite) {
              navigationService.navigateToWidget(const AddItemScreen());
            }
            return;
          }

          if (result.error != null) {
            toast(result.error!);
          }
        },
      );
    };
    navigationService.navigateToWidget(const AddItemScreen());
  }
}

class trailer extends StatelessWidget {
  final String text;
  final String date;

  const trailer({
    super.key,
    required this.date,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$text ",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 11.sp),
          ),
          TextSpan(
            text: date,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
      textAlign: TextAlign.end,
    );
  }
}
