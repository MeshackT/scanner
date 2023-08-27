import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scanner/Reuse.dart';

import 'feedbackclass.dart';

class MoreHome extends StatelessWidget {
  const MoreHome({Key? key}) : super(key: key);
  static const routeName = '/MoreScanner';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Reuse.HeaderText(
                  context, "Generals", "Send us feedback and share"),
              Reuse.spaceBetween(),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  color: Theme.of(context).primaryColor.withOpacity(1),
                  child: Center(
                    child: Text(
                      "Send Us Feedback",
                      style: textStyleText.copyWith(
                          color: Theme.of(context).primaryColorLight),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      color: Theme.of(context).primaryColorLight,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 20,
                      child: TextButton(
                        onPressed: () {
                          showSheetToSendUsFeedback(context);
                        },
                        child: Text(
                          "Feedback",
                          textAlign: TextAlign.left,
                          style: textStyleText.copyWith(
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  Reuse.spaceBetween(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      color: Theme.of(context).primaryColor.withOpacity(1),
                      child: Center(
                        child: Text(
                          "More apps",
                          style: textStyleText.copyWith(
                              color: Theme.of(context).primaryColorLight),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          color: Theme.of(context).primaryColorLight,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 20,
                          child: TextButton(
                            onPressed: () {
                              showSheetToShare(context);
                            },
                            child: Text(
                              "More",
                              textAlign: TextAlign.left,
                              style: textStyleText.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Container(
                      color: Theme.of(context).primaryColor.withOpacity(1),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(
                        child: Text(
                          "About this application",
                          style: textStyleText.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Apple SD Gothic Neo',
                              color: Theme.of(context).primaryColorLight),
                        ),
                      ),
                    ),
                  ),
                  Reuse.spaceBetween(),
                  Reuse.spaceBetween(),
                  Card(
                    elevation: 2,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      color: Theme.of(context).primaryColor.withOpacity(.04),
                      child: Text(
                        "An easy to use qr scanner application designed to convert"
                        " qr codes to readable text and convert text into qr images "
                        "like sequence.\nYour camera and storage access is required to "
                        "use this application",
                        textAlign: TextAlign.center,
                        style: textStyleText.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                  Reuse.spaceBetween(),
                  Text(
                    "Version: 1.0.1",
                    textAlign: TextAlign.center,
                    style: textStyleText.copyWith(fontSize: 14),
                  )
                ],
              ),
            ]),
      ),
    );
  }
}

showSheetToShare(BuildContext context) {
  showModalBottomSheet(
    barrierColor: Theme.of(context).primaryColor.withOpacity(.1),
    isScrollControlled: true,
    enableDrag: true,
    elevation: 1,
    clipBehavior: Clip.antiAlias,
    context: context,
    builder: (context) {
      return Wrap(
        alignment: WrapAlignment.center,
        children: [
          SingleChildScrollView(
            child: Container(
              color: Theme.of(context).primaryColorLight,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Share these applications with your friends",
                        textAlign: TextAlign.center,
                        style: textStyleText.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Divider(
                          height: 7,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          FlutterShare.share(
                              title: "E-Board application",
                              chooserTitle: "E-Board application",
                              text: "Download E-board on appStore",
                              linkUrl:
                                  "https://play.google.com/store/apps/details?id=com.eq.yueway");
                        },
                        child: Text(
                          "E-Board",
                          textAlign: TextAlign.start,
                          style: textStyleText.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          FlutterShare.share(
                              title: "Yueway Go application",
                              chooserTitle: "Yueway Go application",
                              text: "Download Yueway Go on appStores",
                              linkUrl:
                                  "https://play.google.com/store/apps/details?id=com.yueway.yueway_go");
                        },
                        child: Text(
                          "Yueway Go",
                          textAlign: TextAlign.start,
                          style: textStyleText.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          FlutterShare.share(
                              title: "E-Board application",
                              chooserTitle: "Yueway application",
                              text: "Download Yueway on appStores",
                              linkUrl:
                                  "https://play.google.com/store/apps/details?id=com.eq.yueway");
                        },
                        child: Text(
                          "Yueway Security",
                          style: textStyleText.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          FlutterShare.share(
                              title: "E-Board application",
                              chooserTitle: "Revival Life Ministry application",
                              text:
                                  "Download Revival Life Ministry application on appStores",
                              linkUrl: "https://play.google.com/store/apps/det"
                                  "ails?id=com.yueway.revival_life_ministry");
                        },
                        child: Text(
                          "Revival Life Ministry",
                          style: textStyleText.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

//TODO Show bottom Sheet To add Subject to the learner
showSheetToSendUsFeedback(BuildContext context) {
  //controllers
  TextEditingController nameOfSender = TextEditingController();
  TextEditingController emailOfSender = TextEditingController();
  TextEditingController messageOfSender = TextEditingController();
  TextEditingController subjectOfSender = TextEditingController();

  showModalBottomSheet(
    isScrollControlled: true,
    barrierColor: Colors.transparent,
    enableDrag: true,
    elevation: 1,
    context: context,
    builder: (context) {
      return SafeArea(
        child: Container(
          color: Theme.of(context).primaryColorLight,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 0.0),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: buttonRound.copyWith(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text(
                        "Discard",
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 3),
                        child: Column(children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Container(
                              color: Theme.of(context).primaryColor,
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: Center(
                                child: Text(
                                  "What's your feedback?",
                                  style: textStyleText.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Apple SD Gothic Neo',
                                      color:
                                          Theme.of(context).primaryColorLight),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: nameOfSender,
                            maxLines: 1,
                            decoration: textInputDecoration.copyWith(
                              hintText: "Your name here",
                              hintStyle: textStyleText.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(1)),
                            ),
                            style: textStyleText,
                            textAlign: TextAlign.center,
                            autocorrect: true,
                            textAlignVertical: TextAlignVertical.center,
                            onSaved: (value) {
                              //Do something with the user input.
                              nameOfSender.text = value!;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: emailOfSender,
                            maxLines: 1,
                            decoration: textInputDecoration.copyWith(
                              hintText: "Your email here",
                              hintStyle: textStyleText.copyWith(
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(1),
                              ),
                            ),
                            style: textStyleText,
                            textAlign: TextAlign.center,
                            autocorrect: true,
                            textAlignVertical: TextAlignVertical.center,
                            onSaved: (value) {
                              //Do something with the user input.
                              emailOfSender.text = value!;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: subjectOfSender,
                            maxLines: 1,
                            decoration: textInputDecoration.copyWith(
                              hintText: "Your subject here",
                              hintStyle: textStyleText.copyWith(
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(1),
                              ),
                            ),
                            style: textStyleText,
                            textAlign: TextAlign.center,
                            autocorrect: true,
                            maxLength: 45,
                            textAlignVertical: TextAlignVertical.center,
                            onSaved: (value) {
                              //Do something with the user input.
                              subjectOfSender.text = value!;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: messageOfSender,
                            maxLines: 4,
                            decoration: textInputDecoration.copyWith(
                              hintText: "Your message here",
                              hintStyle: textStyleText.copyWith(
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(1),
                              ),
                            ),
                            style: textStyleText,
                            textAlign: TextAlign.center,
                            autocorrect: true,
                            textAlignVertical: TextAlignVertical.center,
                            onSaved: (value) {
                              //Do something with the user input.
                              messageOfSender.text = value!;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () async {
                                    if (nameOfSender.text.isEmpty ||
                                        emailOfSender.text.isEmpty ||
                                        subjectOfSender.text.isEmpty ||
                                        messageOfSender.text.isEmpty) {
                                      Reuse.callSnack(context,
                                          "Insert your details and message");
                                    } else {
                                      SendEmail.sendEmail(
                                        name: nameOfSender.text,
                                        message: messageOfSender.text,
                                        subject: subjectOfSender.text,
                                        email: emailOfSender.text,
                                      );
                                      Fluttertoast.showToast(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          msg:
                                              "Thank you for your feedback, your email submitted.");
                                      Navigator.of(context).pop();
                                    }
                                    nameOfSender.clear();
                                    messageOfSender.clear();
                                    subjectOfSender.clear();
                                    emailOfSender.clear();
                                  },
                                  style: buttonRound.copyWith(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                  ),
                                  child: Text(
                                    "Send",
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
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
    },
  );
}
