import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/core/constants/constants.dart';
import 'package:grocey_tag/core/constants/pallete.dart';
import 'package:grocey_tag/core/enums/enum.dart';
import 'package:grocey_tag/core/models/item.dart';
import 'package:grocey_tag/providers/inventory_provider/inventory_provider.dart';
import 'package:grocey_tag/utils/date-util.dart';
import 'package:grocey_tag/utils/snack_message.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/apptext.dart';
import 'package:grocey_tag/widgets/scan_tag/show_write_button_sheet.dart';
import 'package:grocey_tag/widgets/text-field-widget.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/drop_down_menu.dart';

class EditItemScreen extends ConsumerStatefulWidget {
  final Item item;
  const EditItemScreen({super.key, required this.item});

  @override
  ConsumerState<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends ConsumerState<EditItemScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController warningQuantityController = TextEditingController();
  TextEditingController additionalNoteController = TextEditingController();
  TextEditingController purchaseDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();

  @override
  void initState() {
    nameController = TextEditingController(text: widget.item.name);
    quantityController =
        TextEditingController(text: widget.item.quantity.toString());
    warningQuantityController =
        TextEditingController(text: widget.item.threshold.toString());
    additionalNoteController =
        TextEditingController(text: widget.item.additionalNote);
    expires = widget.item.expiryDate;
    purchased = widget.item.purchaseDate;
    expiryDate = widget.item.expiryDate;
    purchaseDate = widget.item.purchaseDate;
    purchaseDateController = TextEditingController(
        text: purchased != null ? DateUtil.toDates(purchaseDate) : null);
    expiryDateController = TextEditingController(
        text: expires != null ? DateUtil.toDates(expiryDate) : null);
    onChangeData(widget.item.metric);
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  DateTime purchaseDate = DateTime.now();
  DateTime? purchased;

  DateTime expiryDate = DateTime.now();
  DateTime? expires;

  Metric? selectedMetric;
  List<Metric> data = Metric.values;

  @override
  dispose() {
    super.dispose();
    nameController.dispose();
    quantityController.dispose();
    warningQuantityController.dispose();
    additionalNoteController.dispose();
    purchaseDateController.dispose();
    expiryDateController.dispose();
  }

  onChangeData(Metric val) {
    selectedMetric = val;
    setState(() {});
  }

  onChange(String? val) {
    setState(() {});
  }

  bool get allFieldsComplete {
    return nameController.text.isNotEmpty &&
        nameController.text != ' ' &&
        quantityController.text.isNotEmpty &&
        quantityController.text != ' ' &&
        warningQuantityController.text.isNotEmpty &&
        warningQuantityController.text != ' ' &&
        additionalNoteController.text.isNotEmpty &&
        additionalNoteController.text != ' ' &&
        purchaseDateController.text.isNotEmpty &&
        purchaseDateController.text != ' ' &&
        expiryDateController.text.isNotEmpty &&
        expiryDateController.text != ' ' &&
        selectedMetric != null;
  }

  submit() async {
    if (!allFieldsComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: toast('Fill all fields', success: false),
          backgroundColor: Colors.transparent,
        ),
      );
      return;
    }
    final writeData = Item(
      name: nameController.text.trim(),
      quantity: int.parse(quantityController.text.trim()),
      metric: selectedMetric!,
      purchaseDate: purchaseDate,
      expiryDate: expiryDate,
      additionalNote: additionalNoteController.text.trim(),
      threshold: int.parse(warningQuantityController.text.trim()),
    );

    await showWriteButtonSheet(
      context: context,
      item: writeData,
    ).then(
      (result) {
        if (result.status == NfcWriteStatus.success) {
          toast('Item saved');
          ref.read(inventoryProvider.notifier).updateItem(writeData);
          Navigator.pop(context);
        }

        dev.log('Result: ${result.status}');

        if (result.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: toast(result.error!, success: false),
              backgroundColor: Colors.transparent,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              "Item Details",
              size: 22.sp,
              weight: FontWeight.w600,
            ),
            AppText("Details of items in inventory", size: 12.sp)
          ],
        ),
      ),
      body: Form(
        key: formKey,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                        hintText: "Item Name",
                        controller: nameController,
                        hint: "Enter Item Name",
                        onChanged: onChange,
                      ),
                      10.sp.sbH,
                      AppTextField(
                        hintText: "Quantity",
                        controller: quantityController,
                        hint: "Enter Item Quantity",
                        suffixIcon: DropDownMenu<Metric>(
                          onSelect: onChangeData,
                          enabled: false,
                          hint: 'e.g KG',
                          data: data,
                          selectedOption: selectedMetric,
                        ),
                        contentPadding: 16.sp.padH,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: onChange,
                        keyboardType: TextInputType.number,
                      ),
                      10.sp.sbH,
                      AppTextField(
                        hintText: "Quantity for alert",
                        controller: warningQuantityController,
                        suffixIcon: DropDownMenu(
                          enabled: false,
                          hint: 'e.g KG',
                          onSelect: onChangeData,
                          data: data,
                          selectedOption: selectedMetric,
                        ),
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
                        hintText: "Purchase Date",
                        controller: purchaseDateController,
                        prefix: Icon(Icons.calendar_month_outlined,
                            color: blackColor, size: 25.sp),
                        onTap: pickPurchaseDate,
                        hint: "Select Purchase Date",
                        readonly: true,
                      ),
                      10.sp.sbH,
                      AppTextField(
                        hintText: "Expiry Date",
                        controller: expiryDateController,
                        prefix: Icon(
                          Icons.calendar_month_outlined,
                          color: blackColor,
                          size: 25.sp,
                        ),
                        onTap: pickExpiryDate,
                        hint: "Select Expiry Date",
                        readonly: true,
                      ),
                      10.sp.sbH,
                      AppTextField(
                        hintText: "Additional Notes",
                        controller: additionalNoteController,
                        onChanged: onChange,
                        hint: "Add Additional notes",
                        maxLength: 20,
                      ),
                      10.sp.sbH,
                    ],
                  )),
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
                          onTap: formKey.currentState?.validate() == true &&
                                  selectedMetric != null
                              ? submit
                              : null,
                        ),
                      ),
                    ],
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
        firstDate: firstDate ?? DateTime(1900),
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

  Future pickPurchaseDate({bool picDate = true}) async {
    final date = await pickDateTime(
      purchaseDate,
      pickDate: picDate,
    );
    if (date == null) return null;
    purchaseDate = date;
    purchased = date;
    purchaseDateController =
        TextEditingController(text: DateUtil.toDates(purchaseDate));
    setState(() {});
  }

  Future pickExpiryDate({bool picDate = true}) async {
    final date = await pickDateTime(purchaseDate,
        pickDate: picDate, endDate: DateTime(2100), firstDate: purchaseDate);
    if (date == null) return null;
    expiryDate = date;
    expires = date;
    expiryDateController =
        TextEditingController(text: DateUtil.toDates(expiryDate));
    setState(() {});
  }
}
