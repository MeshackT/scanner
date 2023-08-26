import 'dart:typed_data';

import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'Reuse.dart';

class CreateHome extends StatefulWidget {
  const CreateHome({Key? key}) : super(key: key);
  static const routeName = '/CreateHome';

  @override
  State<CreateHome> createState() => _CreateHomeState();
}

class _CreateHomeState extends State<CreateHome> {
  TextEditingController convertText = TextEditingController();
  String qrText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Reuse.HeaderText(
                      context, "Converting", "Convert your text to a qr code"),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: convertText,
                    maxLines: 9,
                    decoration: textInputDecoration.copyWith(
                      hintText: "Your text here",
                      hintStyle: textStyleText.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).primaryColor.withOpacity(.7),
                      ),
                    ),
                    style: textStyleText,
                    textAlign: TextAlign.center,
                    autocorrect: true,
                    textAlignVertical: TextAlignVertical.center,
                    onSaved: (value) {
                      //Do something with the user input.
                      convertText.text = value!;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () async {
                            //validate the inputs
                            try {
                              setState(() {
                                qrText = convertText.text.trim();
                              });
                            } on Exception catch (e) {
                              // TODO
                              Fluttertoast.showToast(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  msg:
                                      "failed to send the feedback, please try again later");
                            }
                          },
                          style: buttonRound,
                          child: Text(
                            "Create",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Reuse.spaceBetween(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                                  shareImage();
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
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                color: Theme.of(context).primaryColor.withOpacity(.02),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Center(
                    child: QrImageView(
                      data: qrText,
                      version: QrVersions.auto,
                      size: 200.0,
                      gapless: true,
                      errorCorrectionLevel: QrErrorCorrectLevel.H,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> shareImage() async {
    final qrImageData =
        await QrPainter(data: qrText, version: QrVersions.auto, gapless: true)
            .toImageData(200);
    final qrImageFile = await saveImage(qrImageData!);

    if (qrImageFile != null) {
      await Share.file('QR Code', 'qrcode.png',
          qrImageData.buffer.asUint8List(), 'image/png');
    }
  }

  Future<Uint8List?> saveImage(ByteData data) async {
    // final buffer = data.buffer.asUint8List();
    // final directory = await getTemporaryDirectory();
    // final imageFile = File('${directory.path}/qrcode.png');
    //
    // await imageFile.writeAsBytes(buffer);
    //
    // return imageFile.readAsBytes();
  }
}
