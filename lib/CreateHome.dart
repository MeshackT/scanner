import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

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
  ScreenshotController screenshotController =
      ScreenshotController(); // Create a ScreenshotController

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
                    color: Theme.of(context).primaryColorLight,
                    child: TextFormField(
                      controller: convertText,
                      minLines: 1,
                      maxLines: 5,
                      decoration: textInputDecoration.copyWith(
                          fillColor: Theme.of(context).primaryColorLight,
                          label: Text(
                            "Text",
                            style: textStyleText.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).primaryColor),
                          ),
                          hintText: "Text / Phone number / Email and more...",
                          hintStyle: textStyleText.copyWith(
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).primaryColor.withOpacity(.7),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabled: true),
                      style: textStyleText.copyWith(
                          color: Theme.of(context).primaryColor),
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
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColorLight),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Card(
                      color: Theme.of(context).primaryColorLight,
                      elevation: 2,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        width: MediaQuery.of(context).size.width,
                        // color: Theme.of(context).primaryColor.withOpacity(.08),
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
                                  'Scanned results',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    try {
                                      _screenShot();
                                    } on Exception catch (e) {
                                      Reuse.callSnack(
                                        context,
                                        e.toString(),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.screenshot,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                  'Screenshot',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            )
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
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 0),
                child: Card(
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    // Theme.of(context).primaryColor.withOpacity(.08),
                    child: SingleChildScrollView(
                      child: Screenshot(
                        controller: screenshotController,
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: QrImageView(
                              data: qrText,
                              version: QrVersions.auto,
                              gapless: false,
                              eyeStyle: QrEyeStyle(
                                eyeShape: QrEyeShape.square,
                                color: Colors.black,
                              ),
                              dataModuleStyle: QrDataModuleStyle(
                                dataModuleShape: QrDataModuleShape.square,
                                color: Colors
                                    .black, // Set the QR code pattern color to black
                              ),
                              size: 220,
                              // Set the background color to white
                            ),
                          ),
                        ),
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

  Future<void> _screenShot() async {
    try {
      final capturedImage = await screenshotController.capture(
        delay: Duration(milliseconds: 10),
      );

      // Save the captured image to the gallery
      final result =
          await ImageGallerySaver.saveImage(capturedImage!, quality: 80);

      // Show the captured image in a CupertinoAlertDialog
      showCupertinoDialog<String>(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(
            "Your image is Saved",
            style: TextStyle(
              color: Colors.indigo.shade900,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).primaryColorLight, // Use Cupertino color
            ),
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.memory(
                capturedImage, //Display the captured image
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () async {
                // Share the captured image using esys_flutter_share_plus
                await Share.file('Share via', 'image.png',
                    capturedImage.buffer.asUint8List(), 'image/png');
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.share,
                    size: 50,
                    color: Colors.indigo.shade900,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Share",
                    style: TextStyle(
                        color: Colors.indigo.shade900,
                        fontSize: 25,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      Fluttertoast.showToast(
        gravity: ToastGravity.TOP,
        backgroundColor: Theme.of(context).primaryColorLight,
        msg: "Image saved under pictures",
        textColor: Theme.of(context).primaryColor,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future _shareQRImage() async {
    try {
      final image = await QrPainter(
        data: qrText,
        version: QrVersions.auto,
        gapless: false,
        eyeStyle: QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: Colors.white,
        ),
        dataModuleStyle: QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: Colors.black, // Set the QR code pattern color to black
        ),
      ).toImageData(200.0);

      final filename = 'qr_code.png';

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/$filename').create();

      var bytes = image!.buffer.asUint8List();

      await file.writeAsBytes(bytes);

      final path = await Share.file(
        qrText,
        filename,
        bytes,
        'image/png',
      );
    } catch (e) {
      print(e.toString());
    }
    // logger.e('QR code shared to: ${file.path}');
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          elevation: .5,
          title: Text("Qr Code"),
          actions: [
            IconButton(
                onPressed: () {
                  _shareQRImage();
                },
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                )),
          ],
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }
}
