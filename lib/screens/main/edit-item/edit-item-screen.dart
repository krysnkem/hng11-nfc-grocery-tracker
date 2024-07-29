import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/core/constants/constants.dart';
import 'package:grocey_tag/core/constants/pallete.dart';
import 'package:grocey_tag/utils/date-util.dart';
import 'package:grocey_tag/utils/snack_message.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/apptext.dart';
import 'package:grocey_tag/widgets/text-field-widget.dart';

import '../../../utils/app-bottom-sheet.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/scan-tage-widget.dart';

class EditItemScreen extends StatefulWidget {
  const EditItemScreen({super.key});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController warningQuantityController = TextEditingController();
  TextEditingController additionalNoteController = TextEditingController();
  TextEditingController purchaseDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();

  @override
  void initState() {
    // nameController = TextEditingController(text: "Mr Beast Choco");
    // quantityController = TextEditingController(text: "40");
    // warningQuantityController = TextEditingController(text: "5");
    // additionalNoteController = TextEditingController(text: "Buy frozen ones next time.");
    // purchaseDateController = TextEditingController(text: "03/06/2023");
    // expiryDateController = TextEditingController(text: "03/06/2023");
    super.initState();
  }

  DateTime purchaseDate = DateTime.now();
  DateTime? purchased;

  DateTime expiryDate = DateTime.now();
  DateTime? expires;

  String? selectedOption;
  List<String> data = ["Litres", "KGs", "Cups", "Packs", "Cartons"];

  onChangeData(String val){
    selectedOption = val;
    setState(() { });
  }

  onChange(String? val){
    setState(() { });
  }

  submit(){
    appBottomSheet(ScanTagWidget(onTap: readTag,), height: 462.sp);
  }

  readTag()async{

    // FOR TESTING
    showCustomToast("Item Updated Successfully", success: true);
    navigationService.goBack();

    // USE THIS LATER UNCOMMENT THE BELOW


    // if(checkNfcAvailable== true){
    //   _nfcService.readNfcTag((data) {
    //   showCustomToast("Item Updated Successfully", success: true);
    //   navigationService.goBack();
    //   }, (error) {
    //       showCustomToast(error);
    //   });
    //   return;
    // }
    // showCustomToast("Your phone: \"${await getDeviceName()}\" doesn't have the facility to use NFC");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText("Item Details", size: 22.sp, weight: FontWeight.w600,),
            AppText("Details of items in inventory", size: 12.sp)
          ],
        ),
      ),
      body: GestureDetector(
        onTap: ()=> FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: 16.sp.padA,
          child: SafeArea(
            top: false,
            bottom: true,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: 0.0.padA,
                    children: [
                      AppTextField(
                        hintText:  "Item Name",
                        controller: nameController,
                        hint: "Enter Item Name",
                        onChanged: onChange,
                      ),
                      10.sp.sbH,
                      AppTextField(
                        hintText:  "Quantity",
                        controller: quantityController,
                        hint: "Enter Item Quantity",
                        suffixIcon: DropDownMenu(onSelect: onChangeData, data: data, selectedOption: selectedOption,),
                        contentPadding: 16.sp.padH,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: onChange,
                        keyboardType: TextInputType.number,
                      ),
                      10.sp.sbH,
                      AppTextField(
                        hintText:  "Warning Quantity",
                        controller: warningQuantityController,
                        suffixIcon: DropDownMenu(onSelect: onChangeData, data: data, selectedOption: selectedOption,),
                        contentPadding: 16.sp.padH,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        hint: "Enter Quantity were warning will be sent",
                        keyboardType: TextInputType.number,
                        onChanged: onChange,
                      ),
                      10.sp.sbH,
                      AppTextField(
                        hintText:  "Purchase Date",
                        controller: purchaseDateController,
                        prefix: Icon(Icons.calendar_month_outlined, color: blackColor, size: 25.sp),
                        onTap: pickPurchaseDate,
                        hint: "Select Purchase Date",
                        readonly: true,
                      ),
                      10.sp.sbH,
                      AppTextField(
                        hintText:  "Expiry Date",
                        controller: expiryDateController,
                        prefix: Icon(Icons.calendar_month_outlined, color: blackColor, size: 25.sp,),
                        onTap: pickExpiryDate,
                        hint: "Select Expiry Date",
                        readonly: true,
                      ),
                      10.sp.sbH,
                      AppTextField(
                        hintText:  "Additional Notes",
                        controller: additionalNoteController,
                        onChanged: onChange,
                        hint: "Add Additional notes",
                      ),
                      10.sp.sbH,

                    ],
                  )
                ),
                16.sp.sbH,
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        isOutline: true,
                        text: "Cancel",
                        onTap: navigationService.goBack,
                      ),
                    ),
                    16.sp.sbW,
                    Expanded(
                      child: AppButton(
                        text: "Save",
                        onTap: submit,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<DateTime?> pickDateTime(
      DateTime initialDate, {
        required bool pickDate,
        DateTime? firstDate,
        DateTime? endDate,
      }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate?? DateTime(1900),
        lastDate: endDate ?? DateTime.now(),
      );
      if (date == null) return null;

      final time =
      Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeOfDay == null) return null;
      final date =
      DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Future pickPurchaseDate(
      {bool picDate = true}) async {
    final date = await pickDateTime(
      purchaseDate,
      pickDate: picDate,
    );
    if (date == null) return null;
    purchaseDate = date;
    purchased = date;
    purchaseDateController =TextEditingController(text: DateUtil.toDates(purchaseDate));
    setState(() { });
  }


  Future pickExpiryDate(
      {bool picDate = true}) async {
    final date = await pickDateTime(
      purchaseDate,
      pickDate: picDate,
      endDate: DateTime(2100),
      firstDate: purchaseDate
    );
    if (date == null) return null;
    expiryDate = date;
    expires = date;
    expiryDateController =TextEditingController(text: DateUtil.toDates(expiryDate));
    setState(() { });
  }


}


class DropDownMenu extends StatelessWidget {
  final String? selectedOption;
  final Function(String) onSelect;
  final List<String> data;
  const DropDownMenu({super.key, required this.onSelect, required this.data, this.selectedOption});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.sp,
      width: 75.sp,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color:Theme.of(context).disabledColor.withOpacity(0.5),  // Border color
            width: 0.8,          // Border width
          ),
        ),
      ),
      child: PopupMenuButton<String>(
        onSelected: onSelect,
        itemBuilder: (BuildContext context) {
          return data.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: AppText(choice, weight: FontWeight.w600,),
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
                  child: AppText(
                    selectedOption??"Options",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
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