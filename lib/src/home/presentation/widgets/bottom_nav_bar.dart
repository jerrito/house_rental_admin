import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rental_admin/assets/svgs/svg_constants.dart';
import 'package:go_router/go_router.dart';

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
        print(value);
        if (value == 0) {
          widget.index = value;
        
          setState(() {});
          context.goNamed("homePage");
        }
        if (value == 1) {
          widget.index = value;
        
          setState(() {});
          context.goNamed("addHome");
        }
        if (value == 2) {
          widget.index = value;
          setState(() {});
          context.goNamed("editHome");
        } 
        if(value==3){
          widget.index == value;
          setState(() {});
          context.goNamed("profile");
        }
      },
      items: [
        buildNav(callSVG, "Home"),
        buildNav(bookMarkSVG, "Add"),
        buildNav(editSVG, "Edit"),
        buildNav(userSVG, "Profile"),
      ],
    );
  }
}

BottomNavigationBarItem buildNav(String svg, String? label) {
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(svg),
    activeIcon: SvgPicture.asset(
      svg,
      colorFilter: const ColorFilter.mode(Colors.lightBlue, BlendMode.srcIn),
    ),
    label: label,
  );
}
