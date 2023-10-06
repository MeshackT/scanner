import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanner/CreateHome.dart';
import 'package:scanner/HistoryHome.dart';
import 'package:scanner/MoreHome.dart';
import 'package:scanner/Navigation.dart';
import 'package:scanner/ScannerHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DatabaseHelper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initDB(); // Initialize the database
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool darkModeEnabled = false;

  Future<void> _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      darkModeEnabled = prefs.getBool('my_switch_state') ?? false;
    });
  }

  //switch state
  Future<void> _saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('my_switch_state', value);
  }

  void toggleDarkMode(bool value) {
    setState(() {
      darkModeEnabled = value;
    });
    _saveSwitchState(value);
  }

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.grey),
    );
    // initial state of the switch
    // bool darkModeEnabled = false;

    MaterialColor myColor = const MaterialColor(
      0xC2C2C2FF,
      <int, Color>{
        50: Color(0xffeeeeee),
        100: Color(0xffcccccc),
        200: Color(0xffd3d3d3),
        300: Color(0xffa2a2a2),
        400: Color(0xffd5d5d5),
        500: Color(0xffc2c2c2),
        600: Color(0xffa2a2a2),
        700: Color(0xffc4c2c2),
        800: Color(0xffb9b8b8),
        900: Color(0xffc9c8c8),
      },
    );
    // Define light and dark themes
    final ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.indigo,
      primaryColorDark: Colors.deepPurple,
      primaryColorLight: Colors.white,
      fontFamily: 'Poppins',
      iconTheme: const IconThemeData(color: Colors.white),
    );

    final ThemeData darkTheme = ThemeData(
      primarySwatch: myColor,
      primaryColorLight: Colors.grey.shade800,
      fontFamily: 'Poppins',
      iconTheme: const IconThemeData(
        color: Color(0xE7151533),
      ),
    );

    return MaterialApp(
      title: 'QR Scanner',
      theme: darkModeEnabled ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen(Home) widget.
        '/': (context) => Navigation(
            darkModeEnabled: darkModeEnabled, toggleDarkMode: toggleDarkMode),
        '/scannerHome': (context) => const ScannerHome(),
        '/historyHome': (context) => const HistoryHome(),
        '/createHome': (context) => const CreateHome(),
        '/moreHome': (context) => MoreHome(
            darkModeEnabled: darkModeEnabled, toggleDarkMode: toggleDarkMode),
        // '/moreServices': (context) => const MoreServices(),
      },
    );
  }
}
