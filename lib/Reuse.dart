import 'package:flutter/material.dart';

class Reuse {
  String title = "";
  String subtitle = "";
  late BuildContext context;

  static double value1 = 0;
  static double value2 = 0;
  static double value3 = 0;
  static double value4 = 0;

  static ClipRRect HeaderText(context, title, subtitle) {
    final contextDataColor = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 8,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: contextDataColor.primaryColorLight,
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: contextDataColor.primaryColorLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static ClipRRect buttonScan(
      context,
      String title,
      double value1,
      double value2,
      double value3,
      double value4,
      Future<void> Function() todoFunction) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(value1),
        bottomRight: Radius.circular(value2),
        topRight: Radius.circular(value3),
        topLeft: Radius.circular(value4),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 8,
        width: MediaQuery.of(context).size.width / 2,
        child: ElevatedButton(
          onPressed: () => todoFunction,
          child: Text(title),
        ),
      ),
    );
  }

  static SizedBox spaceBetween() {
    return SizedBox(
      height: 10,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> callSnack(
      BuildContext context, results) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          results,
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        ),
      ),
    );
  }
}

ButtonStyle buttonRound = OutlinedButton.styleFrom(
  elevation: 1,
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20))),
);

TextStyle textStyleText = TextStyle(
    fontWeight: FontWeight.normal, letterSpacing: 1, color: Colors.indigo);

InputDecoration textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.indigo, width: 2),
    borderRadius: BorderRadius.circular(8),
  ),
  border: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.indigo, width: 2),
    borderRadius: BorderRadius.circular(8),
  ),
);
