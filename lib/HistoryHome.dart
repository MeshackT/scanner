import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
        future: _scannedData,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Reuse.HeaderText(
                      context, "History", "A list of my recent scans"),
                  Reuse.spaceBetween(),
                  Text(
                    "No Data yet...",
                    style: textStyleText,
                  ),
                  Reuse.spaceBetween(),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }

          return Padding(
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
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                      reverse: true,
                      // padding: const EdgeInsets.only(bottom: 130.0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        // Use the actual data
                        final scannedData = snapshot.data![index];

                        String timeDate = DateFormat('MMM d, h:mm a')
                            .format(scannedData.date!);
                        return InkWell(
                          onDoubleTap: () async {
                            try {} on Exception catch (e) {
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
                              padding: const EdgeInsets.symmetric(vertical: 4),
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
                                  title: Text(
                                    scannedData.content!,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  subtitle: Text(
                                    timeDate.toString(),
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
                                      // Call the delete function here
                                      await _databaseHelper
                                          .deletingScannedData(
                                              snapshot.data![index].id)
                                          .then((value) => _updateScannedList())
                                          .whenComplete(
                                            () => setState(() {
                                              // _updateScannedList(); // This function should update _dataList
                                            }),
                                          );
                                      // Update the UI by reloading the data

                                      logger.e(index);
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
          );
        });
  }
}
