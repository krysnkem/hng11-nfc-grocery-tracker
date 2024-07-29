import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:grocey_tag/core/constants/app_images.dart';
import 'package:grocey_tag/core/constants/pallete.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/app_button.dart';
import 'package:grocey_tag/widgets/apptext.dart';
import 'package:grocey_tag/widgets/searchbar.dart';

import '../../../widgets/filter.dart';
import 'items-details.dart';

class Inventory extends StatelessWidget {
  final Function(int) onNavigationItem;
  const Inventory({super.key, required this.onNavigationItem});

  @override
  Widget build(BuildContext context) {
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
          title: Text("Inventory"),
          actions: [
            SvgPicture.asset(
              AppImages.addlist,
              height: 24.sp,
              width: 24.sp,
            ),
            10.w.sbW
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
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppSearchbar(
                        width: 273.sp,
                        height: 32.sp,
                        backgroundColor: Colors.white,
                        borderWidth: 0.5,
                      ),
                      20.w.sbW,
                      filterbutton(
                        onTap: () {},
                      ),
                    ],
                  ),
                  15.h.sbH,
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: item.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Itemsdetails()));
                          },
                          child: Column(
                            children: [
                              ListTile(
                                title: Row(
                                  children: [
                                    AppText(
                                      item[index]['title'],
                                      size: 16.sp,
                                      weight: FontWeight.w500,
                                    ),
                                    Spacer(),
                                    trailer(
                                        date: item[index]["purchase date"],
                                        text: 'Purchase:')
                                  ],
                                ),
                                subtitle: Row(children: [
                                  AppText(item[index]['quantity'].toString(),
                                      weight: FontWeight.w400, size: 11.sp),
                                  5.w.sbW,
                                  AppText(item[index]["measureUnit"],
                                      weight: FontWeight.w400, size: 11.sp),
                                  2.w.sbW,
                                  AppText(
                                    "left",
                                    weight: FontWeight.w300,
                                    size: 11.sp,
                                  ),
                                  Spacer(),
                                  trailer(
                                    date: item[index]["expiry date"],
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
    return Row(
      children: [
        AppText(
          text,
          weight: FontWeight.w400,
          size: 11,
        ),
        AppText(date, weight: FontWeight.w400, size: 11)
      ],
    );
  }
}
