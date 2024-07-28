import 'dart:convert';

import 'package:nfc_manager/nfc_manager.dart';

class NFCService {
  Future<bool> isNfcAvailable() {
    return NfcManager.instance.isAvailable();
  }

  Future<void> readNfcTag(
      Function(String) onReadSuccess, Function(String) onError) async {
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
          onReadSuccess(jsonData.toString());
        } catch (e) {
          onError('Failed to decode JSON data');
        }
      } else {
        onError('No data');
      }
      NfcManager.instance.stopSession();
    });
  }

  Future<void> writeNfcTag(Map<String, dynamic> data,
      Function(String) onWriteSuccess, Function(String) onError) async {
    String jsonString = jsonEncode(data);
    List<int> bytes = utf8.encode(jsonString);

    if (bytes.length > 255) {
      onError('Data too large to write to NFC tag');
      return;
    }

    NdefRecord record = NdefRecord.createText(jsonString);
    NdefMessage message = NdefMessage([record]);

    try {
      await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        var ndef = Ndef.from(tag);

        if (ndef == null) {
          onError('Tag is not NDEF formatted');
          return;
        }

        if (ndef.isWritable) {
          await ndef.write(message);
          onWriteSuccess('Data written to NFC tag successfully');
        } else {
          onError('Failed to write to NFC tag');
        }

        NfcManager.instance.stopSession();
      });
    } catch (e) {
      onError(e.toString());
      NfcManager.instance.stopSession();
    }
  }
}
