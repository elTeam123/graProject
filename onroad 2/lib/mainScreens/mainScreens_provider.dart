import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:onroad/provider_TabPages/notifications_tabpage.dart';
import 'package:onroad/provider_TabPages/provider_hometabpage.dart';
import 'package:onroad/provider_TabPages/provider_profile/provider_profile.dart';

class MainScreenProvider extends StatefulWidget {
  const MainScreenProvider({super.key});

  @override
  State<MainScreenProvider> createState() => _MainScreenProviderState();
}

class _MainScreenProviderState extends State<MainScreenProvider>
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

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////////الجزء الخاص بالخروج من التطبيق //////////////////////////
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Are you sure you want to exit?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () => {
                  Navigator.of(context).pop(true),
                  SystemNavigator.pop(),
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [
            ProviderHomeTabPage(),
            // Notifications(),
            ProviderProfileTabPage(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white60,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 10,
            ),
            child: GNav(
              backgroundColor: Colors.white60,
              color: Colors.black,
              activeColor: Colors.black,
              tabBackgroundColor: Colors.green,
              gap: 16,
              onTabChange: onItemClicked,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                // GButton(
                //   icon: Icons.notifications,
                //   text: 'Notifications',
                // ),
                GButton(
                  icon: Icons.person_rounded,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
