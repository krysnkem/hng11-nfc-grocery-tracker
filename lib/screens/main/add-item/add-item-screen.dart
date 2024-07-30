import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/core/constants/constants.dart';
import 'package:grocey_tag/core/constants/pallete.dart';
import 'package:grocey_tag/utils/date-util.dart';
import 'package:grocey_tag/utils/snack_message.dart';
import 'package:grocey_tag/utils/validator.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/apptext.dart';
import 'package:grocey_tag/widgets/text-field-widget.dart';

import '../../../services/nfc_service.dart';
import '../../../utils/app-bottom-sheet.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/scan-tage-widget.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController warningQuantityController = TextEditingController();
  TextEditingController additionalNoteController = TextEditingController();
  TextEditingController purchaseDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  DateTime purchaseDate = DateTime.now();
  DateTime? purchased;

  DateTime expiryDate = DateTime.now();
  DateTime? expires;

  String? selectedOption;
  List<String> data = ["Litres", "KGs", "Cups", "Packs", "Cartons"];

  onChangeData(String val){
    selectedOption = val;
    formKey.currentState?.validate();
    setState(() { });
  }

  onChange(String? val){
    formKey.currentState?.validate();
    setState(() { });
  }

  submit(){
    appBottomSheet(ScanTagWidget(onTap:()=> _writeToNfcTag(
        {
          'name': nameController.text.trim(),
          'quantity': quantityController.text.trim(),
          'alertQuantity': warningQuantityController.text.trim(),
          'expiryDate': expires,
          'purchaseDate': purchased,
          'measureUnit': selectedOption,
          'additionalNote': additionalNoteController.text.trim(),
        }
    ),), height: 462.sp);
  }

  Future<void> _writeToNfcTag(Map<String, dynamic> data) async {
    final NFCService _nfcService = NFCService();

    _nfcService.writeNfcTag(
      data,
          (successMessage) {
        showCustomToast("Item Updated Successfully", success: true);
        navigationService.goBack();
      },
          (errorMessage) {
            showCustomToast(errorMessage);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText("Add new item", size: 22.sp, weight: FontWeight.w600,),
      ),
      body: Form(
        key: formKey,
        child: GestureDetector(
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
                          validator: emptyValidator,
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
                          validator: (val){
                            String value = quantityController.text.trim();
                            if(value.isEmpty){
                              return "Quantity cannot be empty";
                            }
                            if(value == "0"){
                              return "Quantity must be more than \"0\"";
                            }
                            if(int.tryParse(value) == null){
                              return "Quantity must be a number";
                            }
                            return null;
                          },
                        ),
                        10.sp.sbH,
                        AppTextField(
                          hintText:  "Quantity for alert",
                          controller: warningQuantityController,
                          suffixIcon: DropDownMenu(onSelect: onChangeData, data: data, selectedOption: selectedOption,),
                          contentPadding: 16.sp.padH,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          hint: "Enter Quantity were warning will be sent",
                          keyboardType: TextInputType.number,
                          onChanged: onChange,
                          validator: (val){
                            String value = warningQuantityController.text.trim();
                            if(value.isEmpty){
                              return "Quantity for alert cannot be empty";
                            }
                            if(value == "0"){
                              return "Quantity for alert must be more than \"0\"";
                            }
                            if(int.tryParse(value) == null){
                              return "Quantity for alert must be a number";
                            }
                            return null;
                          },
                        ),
                        10.sp.sbH,
                        AppText(
                          "What amount should this item be automatically added to the Shop List",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                          align: TextAlign.start,
                        ),
                        16.sp.sbH,
                        AppTextField(
                          hintText:  "Purchase Date",
                          controller: purchaseDateController,
                          prefix: Icon(Icons.calendar_month_outlined, color: blackColor, size: 25.sp),
                          onTap: pickPurchaseDate,
                          hint: "Select Purchase Date",
                          readonly: true,
                          validator: (val){
                            if(purchased == null){
                              return "Purchase Date must be set";
                            }
                            return null;
                          },
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
                          validator: emptyValidator,
                        ),
                        10.sp.sbH,

                      ],
                    )
                  ),
                  16.sp.sbH,
                  AppButton(
                    text: "Save",
                    onTap: formKey.currentState?.validate() == true && selectedOption != null? submit: null,
                  )
                ],
              ),
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
    formKey.currentState?.validate();
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
    formKey.currentState?.validate();
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
