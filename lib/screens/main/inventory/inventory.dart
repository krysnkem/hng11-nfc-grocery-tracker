import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:grocey_tag/core/constants/app_images.dart';
import 'package:grocey_tag/core/constants/pallete.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/app_button.dart';
import 'package:grocey_tag/widgets/apptext.dart';
import 'package:grocey_tag/widgets/text-field-widget.dart';

import '../../../widgets/filter.dart';
import '../edit-item/edit-item-screen.dart';

class Inventory extends StatefulWidget {
  final Function(int) onNavigationItem;
  const Inventory({super.key, required this.onNavigationItem});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  List<String> filterItems = ["Date Bought", "Quantity", "Expiry Date"];

  String? selectedFilter;

  onSelect(String val) {
    selectedFilter = val;
  }

  List<Map<String, dynamic>> filteredItem = [];

  searchItems(String? val) {
    if (val == null) {
      filteredItem = item;
    } else if (val.length == 0) {
      filteredItem = item;
    } else {
      filteredItem = item.where((item) {
        return item["title"]!.toLowerCase().contains(val.toLowerCase()) ||
            item["purchase date"]!.toLowerCase().contains(val.toLowerCase()) ||
            item["expiry date"]!.toLowerCase().contains(val.toLowerCase()) ||
            item["measureUnit"]!.toLowerCase().contains(val.toLowerCase()) ||
            item["quantity"]!.toString().contains(val);
      }).toList();
    }
    setState(() {});
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

  @override
  void initState() {
    filteredItem = item;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isempty = false;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Inventory"),
          actions: [
            SvgPicture.asset(
              AppImages.addlist,
              height: 24.sp,
              width: 24.sp,
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
                    TextSpan(text: "here", style: TextStyle(color: Colors.grey))
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
                              onChanged: searchItems,
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
                      child: ListView.builder(
                        itemCount: filteredItem.length,
                        itemBuilder: (context, index) {
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
                                        filteredItem[index]['title'],
                                        size: 16.sp,
                                        weight: FontWeight.w500,
                                      ),
                                      const Spacer(),
                                      trailer(
                                          date: filteredItem[index]
                                              ["purchase date"],
                                          text: 'Purchase:')
                                    ],
                                  ),
                                  subtitle: Row(children: [
                                    AppText(
                                      ""
                                      "${filteredItem[index]['quantity'].toString()} ${filteredItem[index]["measureUnit"]} left",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(fontSize: 11.sp),
                                    ),
                                    const Spacer(),
                                    trailer(
                                      date: filteredItem[index]["expiry date"],
                                      text: "Expiry:",
                                    ),
                                  ]),
                                ),
                                10.h.sbH
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ));
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
