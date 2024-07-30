import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocey_tag/core/enums/enum.dart';
import 'package:grocey_tag/core/models/item.dart';
import 'package:nfc_manager/nfc_manager.dart';

const String APPKEY = 'grocery_tag';

class NFCReadResult {
  final NfcReadStatus status;
  final Item? data;
  final String? error;

  NFCReadResult({required this.status, this.data, this.error});
}

class NFCWriteResult {
  final NfcWriteStatus status;
  final String? error;

  NFCWriteResult({required this.status, this.error});
}

class NFCService {
  Future<bool> isNfcAvailable() async {
    return await NfcManager.instance.isAvailable();
  }

  Future<NFCReadResult> readNfcTag() async {
    Completer<NFCReadResult> completer = Completer();

    try {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        var ndef = Ndef.from(tag);
        if (ndef != null && ndef.cachedMessage != null) {
          String tempRecord = "";
          for (var record in ndef.cachedMessage!.records) {
            tempRecord += String.fromCharCodes(
                record.payload.sublist(record.payload[0] + 1));
          }

          try {
            Map<String, dynamic> jsonData = jsonDecode(tempRecord);
            if (jsonData.containsKey('grocery_tag')) {
              Item item = Item.fromJson(jsonData);
              completer.complete(
                  NFCReadResult(status: NfcReadStatus.success, data: item));
            } else {
              completer.complete(
                NFCReadResult(status: NfcReadStatus.notForApp),
              );
            }
          } catch (e) {
            completer.complete(
              NFCReadResult(
                  status: NfcReadStatus.error,
                  error: 'Failed to decode JSON data'),
            );
          }
        } else {
          completer.complete(
            NFCReadResult(status: NfcReadStatus.empty),
          );
        }
        NfcManager.instance.stopSession();
      });
    } catch (e) {
      NFCReadResult(status: NfcReadStatus.error, error: 'an error occured');
    }

    return completer.future;
  }

  Future<NFCWriteResult> writeNfcTag(Item item) async {
    Completer<NFCWriteResult> completer = Completer();
    final metaData = item.toJson();
    metaData[APPKEY] = APPKEY;

    String jsonString = jsonEncode(metaData);
    List<int> bytes = utf8.encode(jsonString);

    if (bytes.length > 255) {
      return NFCWriteResult(
        status: NfcWriteStatus.error,
        error: 'Data too large to write to NFC tag',
      );
    }

    NdefRecord record = NdefRecord.createText(jsonString);
    NdefMessage message = NdefMessage([record]);
    try {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        var ndef = Ndef.from(tag);

        if (ndef == null) {
          completer.complete(NFCWriteResult(
              status: NfcWriteStatus.error,
              error: 'Tag is not NDEF formatted'));
        } else if (ndef.isWritable) {
          try {
            await ndef.write(message);
            completer.complete(NFCWriteResult(status: NfcWriteStatus.success));
          } catch (e) {
            completer.complete(
              NFCWriteResult(
                  status: NfcWriteStatus.error,
                  error: 'Failed to write to NFC tag'),
            );
          }
        } else {
          completer.complete(NFCWriteResult(
              status: NfcWriteStatus.error, error: 'Tag is not writable'));
        }
        NfcManager.instance.stopSession();
      });
    } catch (e) {
      completer.complete(
        NFCWriteResult(status: NfcWriteStatus.error, error: 'An error occured'),
      );
    }

    return completer.future;
  }
}

final nfcServiceProvider = Provider((ref) => NFCService());
