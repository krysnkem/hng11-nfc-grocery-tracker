import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocey_tag/core/constants/app_images.dart';
import 'package:grocey_tag/core/constants/constants.dart';
import 'package:grocey_tag/core/constants/pallete.dart';
import 'package:grocey_tag/screens/main/home/widgets/activity-list-item.dart';
import 'package:grocey_tag/utils/snack_message.dart';

import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/app-card.dart';
import 'package:grocey_tag/widgets/app_button.dart';
import 'package:grocey_tag/widgets/apptext.dart';

import '../../../services/nfc_service.dart';
import '../../../utils/app-bottom-sheet.dart';
import '../../../utils/get-device-name.dart';
import '../../../widgets/scan-tage-widget.dart';
import '../add-item/add-item-screen.dart';
import '../edit-item/edit-item-screen.dart';
import 'widgets/dashboard_card.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onNavigationItem;
  const HomeScreen({super.key, required this.onNavigationItem});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? checkNfcAvailable;
  final NFCService _nfcService = NFCService();
  bool _isLoading = false;

  updateTag(bool update){
    appBottomSheet(ScanTagWidget(onTap: !update? readTag: ()=> _writeToNfcTag({
      'itemName': "Start",
      'itemQuantity': 9,
      'price': 300,
    }),), height: 462.sp);
  }

  showOption(){
    appBottomSheet(Column(
      children: [
        AppButton(
          text: "Update Item",
          isOutline: true,
          borderColor: primaryColor,
          textColor: primaryColor,
          onTap: (){
            navigationService.goBack();
            updateTag(false);
          },
        ),
        10.sp.sbH,
        AppButton(
          text: "Add Item",
          isOutline: true,
          borderColor: primaryColor,
          textColor: primaryColor,
          onTap: (){
            navigationService.goBack();
            updateTag(true);
          },
        ),
        10.sp.sbH,
        AppButton(
          text: "Cancel",
          onTap: navigationService.goBack,
          backGroundColor: Colors.red,
          borderColor: Colors.red,
        ),
        16.sp.sbH
      ],
    ));
  }

  Future<void> _writeToNfcTag(Map<String, dynamic> data) async {

    // FOR TESTING
    navigationService.navigateToWidget(const AddItemScreen());

    // USE THIS LATER UNCOMMENT THE BELOW

    // if(checkNfcAvailable== true){
    //   _nfcService.readNfcTag((data) {
    //     navigationService.navigateToWidget(const EditItemScreen());
    //   }, (error) {
    //     showCustomToast(error);
    //   });
    //   return;
    // }
    // showCustomToast("Your phone: \"${await getDeviceName()}\" doesn't have the facility to use NFC");


  }

  readTag()async{

    // FOR TESTING
    navigationService.navigateToWidget(const EditItemScreen());

    // USE THIS LATER UNCOMMENT THE BELOW


    // if(checkNfcAvailable== true){
    //   _nfcService.readNfcTag((data) {
    //   navigationService.navigateToWidget(const EditItemScreen());
    //   }, (error) {
    //       showCustomToast(error);
    //   });
    //   return;
    // }
    // showCustomToast("Your phone: \"${await getDeviceName()}\" doesn't have the facility to use NFC");
  }

  List<Map<String, dynamic>> historyItem = [
    {
      "title": "Mr Beast Choco",
      "date": "16 July at 09:32",
      "measureUnit": "KG",
      "quantity": 5,
    },
    {
      "title": "Melon Pods",
      "date": "16 July at 09:32",
      "measureUnit": "Cups",
      "quantity": 10,
    },
    {
      "title": "Green Peas",
      "date": "16 July at 09:32",
      "measureUnit": "KG",
      "quantity": 2,
    },
    {
      "title": "Pasta",
      "date": "16 July at 09:32",
      "measureUnit": "Packs",
      "quantity": 2,
    },
    {
      "title": "Indomie",
      "date": "16 July at 09:32",
      "measureUnit": "Carton",
      "quantity": 1,
    },

  ];

  bool show = true;

  init()async{
    checkNfcAvailable = await _nfcService.isNfcAvailable();
    print(checkNfcAvailable);
  }

  @override
  void initState() {
    init();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:show?  AppBar(
        title: Text("Welcome back!"),
      ): null,
      body: show?
      ListView(
        padding: EdgeInsets.only(top: 0.sp, left: 16.sp, right: 16.sp),
        children: [
          AppText(
            "Inventory Summary:",
            size: 16.sp,
            weight: FontWeight.w500,
          ),
          16.sp.sbH,
          Row(
            children: [
              DashBoardCard(
                count: 15,
                svgImage: AppImages.inventory,
                title: "Total items",
              ),
              16.sp.sbW,
              DashBoardCard(
                count: 3,
                svgImage: AppImages.trend,
                title: "Running low",
              ),
            ],
          ),
          16.sp.sbH,
          Row(
            children: [
              DashBoardCard(
                count: 6,
                svgImage: AppImages.warning,
                title: "Expiring soon",
              ),
              16.sp.sbW,
              DashNavigateCard(
                onTap: ()=> widget.onNavigationItem(1),
              ),
            ],
          ),
          30.sp.sbH,
          AppText(
            "Quick Actions:",
            size: 16.sp,
            weight: FontWeight.w500,
          ),
          16.sp.sbH,
          Row(
            children: [
              Expanded(
                child: AppButton(
                  onTap: showOption,
                  text: "Scan Item Tag",
                ),
              ),
              16.sp.sbW,
              Expanded(
                child: AppButton(
                  onTap: ()=> widget.onNavigationItem(2),
                  isOutline: true,
                  text: "View Shop List",
                ),
              ),

            ],
          ),
          30.sp.sbH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                "Recent Activity:",
                size: 16.sp,
                weight: FontWeight.w500,
              ),
              AppCard(
                heights: 28.sp,
                // onTap: ,
                widths: 85.sp,
                padding: 0.0.padA,
                radius: 24.sp,
                backgroundColor: const Color(0xFFDEDEDE),
                child: const Center(child: AppText("View all", weight: FontWeight.w600,)),
              )
            ],
          ),
          16.sp.sbH,
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: historyItem.length,
            itemBuilder: (context, index){
              return ActivityHistoryItem(
                title: historyItem[index]["title"],
                date: historyItem[index]["date"],
                quantity: historyItem[index]["quantity"],
                measureUnit: historyItem[index]["measureUnit"]
              );
            }
          ),
          30.sp.sbH
        ],
      ):
      Padding(
        padding: 16.sp.padA,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.noContent,
              height: 150.sp,
              width: 150.sp,
            ),
            10.sp.sbH,
            AppText(
              "Welcome to GroceyTag",
              size: 22.sp,
              isBold: true,
            ),
            4.sp.sbH,
            AppText(
              "Start managing your groceries\neffectively with NFC tags",
              align: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            20.sp.sbH,
            AppButton(
              onTap: (){},
              text: "Register Your first Item",
            )
          ],
        ),
      ),
    );
  }
}
