import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocey_tag/core/enums/enum.dart';
import 'package:grocey_tag/services/nfc_service.dart';
import 'package:grocey_tag/widgets/scan_tag/scan_tag_widget.dart';

class ReadNFCWidget extends ConsumerStatefulWidget {
  const ReadNFCWidget({super.key});

  @override
  ConsumerState<ReadNFCWidget> createState() => _ReadNFCWidgetState();
}

class _ReadNFCWidgetState extends ConsumerState<ReadNFCWidget> {
  @override
  void initState() {
    super.initState();
    _startReading();
  }

  void _startReading() async {
    final nfcService = ref.read(nfcServiceProvider);
    await nfcService.readNfcTag().then(
      (result) {
        Navigator.pop(context, result);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScanNFCTagWidget(
      popResult: NFCReadResult(status: NfcReadStatus.cancel),
    );
  }
}
