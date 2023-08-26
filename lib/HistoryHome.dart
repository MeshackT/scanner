import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scanner/Reuse.dart';
import 'package:sqflite/sqflite.dart';

import 'DatabaseHelper.dart';

class HistoryHome extends StatefulWidget {
  const HistoryHome({Key? key}) : super(key: key);
  static const routeName = '/HistoryHome';

  @override
  State<HistoryHome> createState() => _HistoryHomeState();
}

class _HistoryHomeState extends State<HistoryHome> {
  late Database db;
  DatabaseHelper dbHelper = DatabaseHelper();
  List<ScannedData> scannedDataList = []; // List to hold retrieved scanned data

  Future<void> loadScannedData() async {
    List<ScannedData> data = await dbHelper.getScannedDataList();
    setState(() {
      scannedDataList = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadScannedData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Reuse.HeaderText(context, "History", "A list of my recent scans"),
          SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 130.0),
              itemCount: scannedDataList.length,
              itemBuilder: (context, index) {
                final scannedData = scannedDataList[index];

                return InkWell(
                  onDoubleTap: () async {
                    try {} on Exception catch (e) {
                      // Anything else that is an exception
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
                        color: Theme.of(context).primaryColor.withOpacity(.03),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).primaryColor.withOpacity(.7),
                            child: Icon(Icons.link),
                          ),
                          title: Text(
                            "${scannedData.content} ${scannedData.id}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          subtitle: Text(
                            scannedData.timestamp.toString(),
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
                            onPressed: () {
                              dbHelper.delete(scannedData.id);
                              setState(() {});
                              print(scannedData.id);
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
        ],
      ),
    );
  }
}
