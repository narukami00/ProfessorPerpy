import 'package:flutter/material.dart';
import 'package:perp_clone/theme/colors.dart';

class SearchBarBut extends StatefulWidget {
  final IconData icon;
  final String text;
  const SearchBarBut({super.key, required this.icon, required this.text});

  @override
  State<SearchBarBut> createState() => _SearchBarButState();
}

class _SearchBarButState extends State<SearchBarBut> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (event) => setState(() {
        isHovering = false;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isHovering ? AppColors.proButton : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(widget.icon, color: AppColors.iconGrey, size: 20),
            Text(widget.text, style: TextStyle(color: AppColors.textGrey)),
          ],
        ),
      ),
    );
  }
}
