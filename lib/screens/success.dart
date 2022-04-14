import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tree_app/utils/colors.dart';
import 'package:tree_app/utils/global_variables.dart';

class SScreen extends StatefulWidget {
  const SScreen({Key? key}) : super(key: key);

  @override
  State<SScreen> createState() => _SScreenState();
}

class _SScreenState extends State<SScreen> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        iconSize: 30,
        backgroundColor: thirdColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navTapped,
        currentIndex: _page,
      ),
    );
  }
}
