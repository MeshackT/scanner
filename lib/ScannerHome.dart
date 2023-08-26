import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:scanner/Reuse.dart';
import 'package:sqflite/sqflite.dart';

import 'DatabaseHelper.dart';

class ScannerHome extends StatefulWidget {
  const ScannerHome({Key? key}) : super(key: key);
  static const routeName = '/scannerHome';

  @override
  State<ScannerHome> createState() => _ScannerHomeState();
}

class _ScannerHomeState extends State<ScannerHome> {
  String _scanBarcode = '';
  late final cnt = 0;
  late Database db;

  final dbHelper = DatabaseHelper();

  int randomNumber = 0;

  void generateRandomNumber() {
    final random = Random();
    setState(() {
      randomNumber =
          random.nextInt(1000000); // Generate a random number between 0 and 99
    });
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) {
      print(barcode);
      final scannedData = ScannedData(
        randomNumber, // The ID will be assigned automatically by the database
        barcode,
        DateTime.now(),
      );
      dbHelper.insertScannedData(scannedData);
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
      final scannedData = ScannedData(
        randomNumber, // The ID will be assigned automatically by the database
        barcodeScanRes,
        DateTime.now(),
      );
      dbHelper.insertScannedData(scannedData);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          Reuse.HeaderText(context, "Scan", "Select your scan"),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        topRight: Radius.circular(1000),
                        topLeft: Radius.circular(1000),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: ElevatedButton(
                            onPressed: () => scanQR(), child: Text('QR scan')),
                      ),
                    ),
                    Reuse.spaceBetween(),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(1000),
                        bottomRight: Radius.circular(1000),
                        topLeft: Radius.circular(0),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: ElevatedButton(
                            onPressed: () => scanQR(), child: Text('Bar Code')),
                      ),
                    ),
                    Reuse.spaceBetween(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        color: Theme.of(context).primaryColor.withOpacity(.04),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset(
                                    "assets/logo.png",
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Scan result',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () async {
                                  try {
                                    if (_scanBarcode.isNotEmpty ||
                                        _scanBarcode.length > 0) {
                                      await FlutterShare.share(
                                        title: 'QR code result:',
                                        text: _scanBarcode,
                                      );
                                    } else {
                                      Reuse.callSnack(
                                        context,
                                        "There's no scanned data to share",
                                      );
                                    }
                                  } on Exception catch (e) {
                                    Reuse.callSnack(
                                      context,
                                      e.toString(),
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.share,
                                  color: Theme.of(context).primaryColor,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                color: Theme.of(context).primaryColor.withOpacity(.03),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: _scanBarcode == ""
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Icon(
                            Icons.document_scanner_rounded,
                            color: Theme.of(context).primaryColor,
                            size: 220,
                          ),
                        )
                      : Center(
                          child: SelectableText(
                            _scanBarcode.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
