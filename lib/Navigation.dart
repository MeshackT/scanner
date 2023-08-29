import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'CreateHome.dart';
import 'HistoryHome.dart';
import 'MoreHome.dart';
import 'ScannerHome.dart';

class Navigation extends StatefulWidget {
  final bool darkModeEnabled;
  final Function(bool) toggleDarkMode;
  const Navigation(
      {Key? key, required this.darkModeEnabled, required this.toggleDarkMode})
      : super(key: key);
  static const routeName = '/';

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  //current index of screen
  int selectedIndex = 0;

  PageController pageController = PageController(initialPage: 0);

  // //switch state
  // Future<void> _saveSwitchState(bool value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('my_switch_state', value);
  // }
  //
  // void toggleDarkMode(bool value) {
  //   setState(() {
  //     darkModeEnabled = value;
  //   });
  //   _saveSwitchState(value);
  // }

  //change the index when selected
  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    //list of screens
    final screens = [
      const ScannerHome(),
      const HistoryHome(),
      const CreateHome(),
      MoreHome(
          darkModeEnabled: widget.darkModeEnabled,
          toggleDarkMode: widget.toggleDarkMode),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      extendBody: true,
      body: PageView(
        controller: pageController,
        children: screens,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.transparent,
            hoverColor: Theme.of(context).primaryColorDark.withOpacity(.8),
            gap: 8,
            activeColor: Theme.of(context).primaryColorLight,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Theme.of(context).primaryColor,
            color: Theme.of(context).primaryColor.withOpacity(.7),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.history,
                text: 'Recent',
              ),
              GButton(
                icon: Icons.create,
                text: 'Create',
              ),
              GButton(
                icon: Icons.more,
                text: 'More',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: changeTab,
          ),
        ),
      ),
    );
  }
}
