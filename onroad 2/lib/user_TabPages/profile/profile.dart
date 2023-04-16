import 'package:flutter/material.dart';

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