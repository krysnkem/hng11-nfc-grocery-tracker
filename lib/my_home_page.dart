import 'package:flutter/material.dart';

import 'nfc_service.dart';

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

  final NFCService _nfcService = NFCService();

  @override
  void initState() {
    super.initState();
    checkNfcAvailable = _nfcService.isNfcAvailable();
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

    _nfcService.readNfcTag(
      (data) {
        setState(() {
          _readFromNfcTag = data;
          _isLoading = false;
        });
      },
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
          ),
        );
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  Future<void> _writeToNfcTag(Map<String, dynamic> data) async {
    setState(() {
      _isLoading = true;
    });

    _nfcService.writeNfcTag(
      data,
      (successMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(successMessage),
          ),
        );
        setState(() {
          _isLoading = false;
        });
      },
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
        setState(() {
          _isLoading = false;
        });
      },
    );
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
