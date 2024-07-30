import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocey_tag/core/enums/enum.dart';
import 'package:grocey_tag/core/models/item.dart';
import 'package:grocey_tag/services/nfc_service.dart';
import 'package:grocey_tag/widgets/scan_tag/scan_tag_widget.dart';

class WriteNFCWidget extends ConsumerStatefulWidget {
  final Item item;
  const WriteNFCWidget({required this.item, super.key});

  @override
  ConsumerState<WriteNFCWidget> createState() => _WriteNFCWidgetState();
}

class _WriteNFCWidgetState extends ConsumerState<WriteNFCWidget> {
  @override
  void initState() {
    super.initState();
    _startWriting();
  }

  void _startWriting() async {
    final nfcService = ref.read(nfcServiceProvider);
    await nfcService.writeNfcTag(widget.item).then(
      (result) {
        Navigator.pop(context, result);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScanNFCTagWidget(
      popResult: NFCWriteResult(status: NfcWriteStatus.cancel),
    );
  }
}
