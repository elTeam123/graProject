
import 'package:flutter/material.dart';
import 'package:onroad/tabPages/profile/editprofile.dart';
import '../../authenticatio/provider/login_screen_provider.dart';
import '../../global/global.dart';

class ProfileTabPage extends StatelessWidget {
  const ProfileTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 115, 17),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.chevron_left_outlined,
            size: 35.0,
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Brand Bold',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.dark_mode_outlined,
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
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(
                          'images/signup.png',
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Container(
                        height: 40.0,
                        width: 45.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.green.withOpacity(.8),
                        ),
                        child: MaterialButton(
                          onPressed: () {

                          },
                          child: const Icon(
                            Icons.edit_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                        builder: (c) => LoginScreen(),
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
          color: Colors.green.withOpacity(
            0.3,
          ),
        ),
        child: Icon(
          (icon),
          color: const Color.fromARGB(
            255,
            79,
            115,
            17,
          ),
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
                color: Colors.green.withOpacity(
                  0.3,
                ),
              ),
              child: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color.fromARGB(
                  255,
                  79,
                  115,
                  17,
                ),
              ),
            )
          : null,
    );
  }
}

