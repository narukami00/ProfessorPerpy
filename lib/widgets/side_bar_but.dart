import 'package:flutter/material.dart';
import 'package:perp_clone/theme/colors.dart';

class SideBarBut extends StatelessWidget {
  final bool isCollapsed;
  final IconData icon;
  final String text;
  const SideBarBut({
    super.key,
    required this.isCollapsed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isCollapsed
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: Icon(icon, color: AppColors.whiteColor, size: 22),
        ),
        isCollapsed
            ? SizedBox()
            : Text(
                text,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
      ],
    );
  }
}
