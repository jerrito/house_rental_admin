import 'package:flutter/material.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/bottom_nav_bar.dart';

class AddHomePage extends StatefulWidget {
  const AddHomePage({super.key});

  @override
  State<AddHomePage> createState() => _AddHomePageState();
}

class _AddHomePageState extends State<AddHomePage> {
  final homeNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  BottomNavigationBarWidget(index: 1,),
      appBar: AppBar(
        title: const Text("Add Home or Room"),
      ),
      body: Column(
        children: [

          DefaultTextfield(
            controller: homeNameController,
            hintText: "Enter home name",
            label: "Home name",

          ),

          DefaultTextfield(
            controller: homeNameController,
            hintText: "Enter rent amount",
            label: "Rent amount",
          ),

           DefaultTextfield(
            controller: homeNameController,
            hintText: "Enter home description",
            label: "Home Description",
          ),


          

        ],
      ),
    );
  }
}
