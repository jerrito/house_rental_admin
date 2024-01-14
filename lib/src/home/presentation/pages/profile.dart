import 'package:flutter/material.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/bottom_nav_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar:  BottomNavigationBarWidget(index: 3,),
      body: const Center(
        child: Text("Profile"),
      ),

    );
  }
}