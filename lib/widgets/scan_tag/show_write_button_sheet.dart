import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/core/enums/enum.dart';
import 'package:grocey_tag/core/models/item.dart';
import 'package:grocey_tag/services/nfc_service.dart';
import 'package:grocey_tag/utils/app-bottom-sheet.dart';
import 'package:grocey_tag/widgets/scan_tag/write_nfc_widget.dart';

Future<NFCWriteResult> showWriteButtonSheet({
  required BuildContext context,
  required Item item,
}) {
  return appBottomSheet<NFCWriteResult>(
          WriteNFCWidget(
            item: item,
          ),
          height: 462.sp)
      .then(
    (value) =>
        value ??
        NFCWriteResult(
          status: NfcWriteStatus.cancel,
        ),
  );
}
