import 'dart:io';

import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
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
                  Card(
                    elevation: 2,
                    child: TextFormField(
                      controller: convertText,
                      maxLines: 9,
                      decoration: textInputDecoration.copyWith(
                        label: Text(
                          "Your text here",
                          style: textStyleText,
                        ),
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
                          style: buttonRound.copyWith(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
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
                    child: Card(
                      elevation: 2,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        width: MediaQuery.of(context).size.width,
                        color: Theme.of(context).primaryColor.withOpacity(.08),
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
                                    _shareQRImage();
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
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Card(
                elevation: 2,
                child: Container(
                  margin:
                      EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).primaryColor.withOpacity(.08),
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
            ),
          ],
        ),
      ),
    );
  }

  Future _shareQRImage() async {
    final image = await QrPainter(
      data: qrText,
      version: QrVersions.auto,
      gapless: false,
      eyeStyle:
          const QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.white),
      color: Colors.white,
      dataModuleStyle: const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square, color: Colors.white),
    ).toImageData(200.0); // Generate QR code image data

    final filename = 'qr_code.png';

    final tempDir =
        await getTemporaryDirectory(); // Get temporary directory to store the generated image

    final file = await File('${tempDir.path}/$filename')
        .create(); // Create a file to store the generated image

    var bytes = image!.buffer.asUint8List(); // Get the image bytes

    await file.writeAsBytes(bytes); // Write the image bytes to the file

    final path = await Share.file(
      qrText,
      filename,
      bytes,
      'image/png',
    );
    // logger.e('QR code shared to: ${file.path}');
  }
}
