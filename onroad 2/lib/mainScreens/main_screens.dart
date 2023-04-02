import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:onroad/tabPages/Home_TabPage.dart';
import 'package:onroad/tabPages/Notifications.dart';
import 'package:onroad/tabPages/Profile_TabPage.dart';
import 'package:onroad/tabPages/Ratings_TabPage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          HomeTabPage(),
          RatingsTabPage(),
          ProfileTabPage(),
          Notifications(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white60,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 13,
          ),
          child: GNav(
            backgroundColor: Colors.white60,
            color: Colors.black,
            activeColor: Colors.black,
            tabBackgroundColor: Colors.green,
            gap: 8,
            onTabChange: onItemClicked,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.miscellaneous_services_rounded,
                text: 'Services',
              ),
              GButton(
                icon: Icons.notifications,
                text: 'Notifications',
              ),
              GButton(
                icon: Icons.person_rounded,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
