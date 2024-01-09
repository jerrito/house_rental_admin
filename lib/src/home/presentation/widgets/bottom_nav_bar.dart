import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  int index;
  BottomNavigationBarWidget({super.key, required this.index});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        if (value == 0) {
          widget.index = 0;
          setState(() {});
        }
        if (value == 1) {
          widget.index = 1;
          setState(() {});
        }
        if (value == 2) {
          widget.index = 2;
          setState(() {});
        } else {
          value == 3;
          setState(() {});
        }
      },
      items: [
        buildNav("", ""),
        buildNav("", ""),
        buildNav("", ""),
        buildNav("", ""),
      ],
    );
  }
}

BottomNavigationBarItem buildNav(String svg, String? label) {
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(svg),
    label: label,
  );
}
