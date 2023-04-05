import 'package:flutter/material.dart';
import 'package:onroad/authenticatio/user/user_or_providr.dart';
import 'package:onroad/mainScreens/main_screens.dart';
import 'package:onroad/tabPages/profile/editprofile.dart';
import '../../authenticatio/provider/login_screen_provider.dart';
import '../../global/global.dart';

class ProfileTabPage extends StatelessWidget {
  const ProfileTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => const MainScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Brand Bold',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.dark_mode_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            15.0,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 15,
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: const AssetImage(
                      'images/user.png',
                    ),
                    backgroundColor: Colors.grey.withOpacity(0.01),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  'User Name',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Brand Bold',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 220.0,
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => const EditProfile(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 79, 115, 17),
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Brand Bold',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35.0,
                ),
                const Divider(
                  color: Color.fromARGB(
                    255,
                    79,
                    115,
                    17,
                  ),
                ),
                ProfileMenuWidget(
                  title: 'Settings',
                  icon: Icons.settings,
                  textColor: Colors.black,
                  endIcon: true,
                  onPress: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileMenuWidget(
                  title: 'Update',
                  icon: Icons.update,
                  textColor: Colors.black,
                  endIcon: true,
                  onPress: () {},
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Divider(
                  color: Color.fromARGB(
                    255,
                    79,
                    115,
                    17,
                  ),
                ),
                ProfileMenuWidget(
                  title: 'Information',
                  icon: Icons.info_rounded,
                  textColor: Colors.black,
                  endIcon: true,
                  onPress: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileMenuWidget(
                  title: 'Logout',
                  icon: Icons.logout,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    fAuth.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => const UserProvider(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });
  final String title;
  // ignore: non_constant_identifier_names
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            30.0,
          ),
          color: Colors.grey[200],
        ),
        child: Icon(
          (icon),
          color: Colors.black,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontFamily: 'Brand Bold',
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      trailing: endIcon
          ? Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  30.0,
                ),
                color: Colors.grey[200],
              ),
              child: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
              ),
            )
          : null,
    );
  }
}
