import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<bool> checkNfcAvailable;
  String _readFromNfcTag = "";
  String _itemName = "";
  int _itemQuantity = 0;
  double _price = 0.0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    checkNfcAvailable = NfcManager.instance.isAvailable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC Reader/Writer'),
      ),
      body: FutureBuilder(
        future: checkNfcAvailable,
        builder: (context, snapshot) {
          if (snapshot.data == false) {
            return const Center(child: Text("NFC not available"));
          }

          return Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _readNfcTag,
                      child: const Text('Read from NFC Tag'),
                    ),
                    ElevatedButton(
                      onPressed: _showWriteDialog,
                      child: const Text('Write to NFC Tag'),
                    ),
                    const SizedBox(height: 20),
                    Text('Read Data: $_readFromNfcTag'),
                  ],
                ),
              ),
              if (_isLoading)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey.withOpacity(0.2),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _readNfcTag() {
    setState(() {
      _isLoading = true;
    });

    NfcManager.instance.startSession(onDiscovered: (NfcTag badge) async {
      var ndef = Ndef.from(badge);

      if (ndef != null && ndef.cachedMessage != null) {
        String tempRecord = "";
        for (var record in ndef.cachedMessage!.records) {
          tempRecord =
              "$tempRecord${String.fromCharCodes(record.payload.sublist(record.payload[0] + 1))}";
        }

        try {
          Map<String, dynamic> jsonData = jsonDecode(tempRecord);
          setState(() {
            _readFromNfcTag = jsonData.toString();
          });
        } catch (e) {
          // Handle JSON decoding error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to decode JSON data'),
            ),
          );
        }
      } else {
        // Show a snackbar for example
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No data'),
          ),
        );
      }

      NfcManager.instance.stopSession();
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _writeToNfcTag(Map<String, dynamic> data) async {
    setState(() {
      _isLoading = true;
    });

    String jsonString = jsonEncode(data);
    List<int> bytes = utf8.encode(jsonString);

    if (bytes.length > 255) {
      throw Exception('Data too large to write to NFC tag');
    }

    NdefRecord record = NdefRecord.createText(jsonString);
    NdefMessage message = NdefMessage([record]);

    try {
      await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        var ndef = Ndef.from(tag);

        if (ndef == null) {
          throw Exception('Tag is not NDEF formatted');
        }

        ndef.write(message).then(
          (_) {
            if (ndef.isWritable) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data written to NFC tag successfully'),
                ),
              );
            } else {
              throw Exception('Failed to write to NFC tag');
            }

            NfcManager.instance.stopSession();
            setState(() {
              _isLoading = false;
            });
          },
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
        ),
      );
      NfcManager.instance.stopSession();
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showWriteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Write to NFC Tag'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Item Name'),
                onChanged: (value) {
                  _itemName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Item Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _itemQuantity = int.tryParse(value) ?? 0;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _price = double.tryParse(value) ?? 0.0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Map<String, dynamic> data = {
                  'itemName': _itemName,
                  'itemQuantity': _itemQuantity,
                  'price': _price,
                };
                _writeToNfcTag(data);
                Navigator.of(context).pop();
              },
              child: const Text('Write'),
            ),
          ],
        );
      },
    );
  }
}
