import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanner/CreateHome.dart';
import 'package:scanner/HistoryHome.dart';
import 'package:scanner/MoreHome.dart';
import 'package:scanner/Navigation.dart';
import 'package:scanner/ScannerHome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /*get permission*/
  Future<void> getPermission() async {
    await Permission.phone.request();
    await Permission.photos.request();
    await Permission.contacts.request();

    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
      //add more permission to request here.
    ].request();

    if (statuses[Permission.storage]!.isDenied) {
      Fluttertoast.showToast(
          backgroundColor: Colors.indigo, msg: "Permission Denied");
    } else if (statuses[Permission.camera]!.isDenied) {
      Fluttertoast.showToast(
          backgroundColor: Colors.indigo, msg: "Permission Denied");
    } else {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColorDark: Colors.deepPurple,
        primaryColorLight: Colors.white,
        fontFamily: 'Poppins',
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen(Home) widget.
        '/': (context) => const Navigation(),
        '/scannerHome': (context) => const ScannerHome(),
        '/historyHome': (context) => const HistoryHome(),
        '/createHome': (context) => const CreateHome(),
        '/moreHome': (context) => const MoreHome(),
        // '/moreServices': (context) => const MoreServices(),
      },
    );
  }
}
