import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
   if(value==0){
    
   }
      },
      items: [
        buildNav("",""),
        buildNav("",""),
        buildNav("",""),
        buildNav("",""),
      ],
    );
  }
}

BottomNavigationBarItem buildNav(String svg,String? label) {
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(svg),
    label: label,

    );
}
