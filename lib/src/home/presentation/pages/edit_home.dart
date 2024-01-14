import 'package:flutter/material.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/bottom_nav_bar.dart';

class EditHomePage extends StatefulWidget {
  const EditHomePage({super.key});

  @override
  State<EditHomePage> createState() => _EditHomePageState();
}

class _EditHomePageState extends State<EditHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar:  BottomNavigationBarWidget(index: 2,),
      body:  Container(
        child:const Center(
          child:Text("Edit Page")
        )
      ),
    );
  }
}