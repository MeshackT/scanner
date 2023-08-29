import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';
import 'package:scanner/ScannerHome.dart';

import 'DatabaseHelper.dart';
import 'Reuse.dart';

class HistoryHome extends StatefulWidget {
  const HistoryHome({Key? key}) : super(key: key);
  static const routeName = '/HistoryHome';

  @override
  State<HistoryHome> createState() => _HistoryHomeState();
}

class _HistoryHomeState extends State<HistoryHome> {
  late Future<List<ScannedData>> _scannedData;
  final DateTime _dateFormater = DateTime.now();

  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  _updateScannedList() {
    _scannedData = DatabaseHelper.instance.getScannedList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateScannedList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _databaseHelper.getScannedList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Reuse.HeaderText(
                      context, "History", "A list of my recent scans"),
                  Reuse.spaceBetween(),
                  Text(
                    "No Data yet...",
                    style: textStyleText.copyWith(
                        color: Theme.of(context).primaryColor),
                  ),
                  Reuse.spaceBetween(),
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else if (snapshot.data.length <= 0) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Reuse.HeaderText(
                        context, "History", "A list of my recent scans"),
                    Reuse.spaceBetween(),
                    Reuse.spaceBetween(),
                    Reuse.spaceBetween(),
                    Text(
                      "No Data yet...",
                      style: textStyleText.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Reuse.spaceBetween(),
                    Reuse.spaceBetween(),
                    SizedBox(
                      child: Center(
                        child: Image.asset("assets/logo.png"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Theme.of(context).primaryColorLight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Reuse.HeaderText(
                          context, "History", "A list of my recent scans"),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Scans: ${snapshot.data!.length.toString()}",
                            textAlign: TextAlign.center,
                            style: textStyleText.copyWith(
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).primaryColor),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(200.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 18,
                              color: Theme.of(context).primaryColor,
                              child: TextButton.icon(
                                onPressed: () async {
                                  showThis();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 18,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                label: Text(
                                  'All',
                                  style: textStyleText.copyWith(
                                      fontSize: 14,
                                      color:
                                          Theme.of(context).primaryColorLight),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ListView.builder(
                            // reverse: true,
                            // padding: const EdgeInsets.only(bottom: 130.0),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              // Use the actual data
                              final scannedData = snapshot.data![index];

                              String timeDate = DateFormat('MMM d, h:mm a')
                                  .format(scannedData.date!);
                              return GestureDetector(
                                onDoubleTap: () async {
                                  try {
                                    searchData(context, scannedData.content);
                                  } on Exception catch (e) {
                                    // Anything else that is an exception
                                    logger.e(scannedData.id);
                                    if (kDebugMode) {
                                      print('Unknown exception: $e');
                                    }
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Container(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.03),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.7),
                                          child: Icon(Icons.link),
                                        ),
                                        title: SelectableText(
                                          scannedData.content!,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        subtitle: Text(
                                          "${timeDate.toString()}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(.49)),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(.7),
                                          ),
                                          onPressed: () async {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CupertinoAlertDialog(
                                                    title: const Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Confirm',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    content: Text(
                                                      "Permanently delete this previously scanned data?",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorDark
                                                              .withOpacity(
                                                                  .70)),
                                                    ),
                                                    actions: <Widget>[
                                                      Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                  'No',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                //Delete the record
                                                                try {
                                                                  // Call the delete function here
                                                                  await _databaseHelper
                                                                      .deletingScannedData(snapshot
                                                                          .data![
                                                                              index]
                                                                          .id)
                                                                      .then((value) =>
                                                                          _updateScannedList())
                                                                      .whenComplete(
                                                                        () => setState(
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        }),
                                                                      );
                                                                  // Update the UI by reloading the data

                                                                  logger
                                                                      .e(index);
                                                                } catch (e) {}
                                                              },
                                                              child: Text(
                                                                'Yes',
                                                                style:
                                                                    TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future showThis() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          // );
          return AlertDialog(
            title: const Text(
              textAlign: TextAlign.center,
              'Confirm',
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.w700),
            ),
            content: Text(
              "Permanently delete this previously scanned data?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark.withOpacity(.70)),
            ),
            actions: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        //Delete the record
                        try {
                          DatabaseHelper.instance.deletingAllScannedData();
                          await _databaseHelper
                              .deletingAllScannedData()
                              .then((value) => _updateScannedList())
                              .whenComplete(
                                () => setState(() {
                                  Navigator.of(context).pop();
                                }),
                              );
                        } catch (e) {}
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

Future<dynamic> searchData(BuildContext context, String content) {
  return showDialog(
    useSafeArea: false,
    context: context,
    builder: (context) => Scaffold(
      appBar: AppBar(
        elevation: .5,
        title: Text(
          "Qr Code content",
          style: textStyleText.copyWith(
              color: Theme.of(context).primaryColorLight, fontSize: 16),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Reuse.spaceBetween(),
            Reuse.spaceBetween(),
            Reuse.HeaderText(context, "Overview ", "See your previous results"),
            Reuse.spaceBetween(),
            Reuse.spaceBetween(),
            SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 5,
                child: Image.asset("assets/logo.png")),
            Card(
              elevation: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                color: Theme.of(context).primaryColorLight,
                child: SelectableText(
                  content,
                  style: textStyleText.copyWith(
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Reuse.spaceBetween(),
            Reuse.spaceBetween(),
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                color: Theme.of(context).primaryColor,
                child: IconButton(
                    onPressed: () async {
                      try {
                        if (content.isNotEmpty || content.length > 0) {
                          await FlutterShare.share(
                            title: 'QR code results',
                            text: content.toString(),
                          );
                        } else {
                          Reuse.callSnack(
                            context,
                            "There's no content",
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
                      color: Theme.of(context).primaryColorLight,
                    )),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
