import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectFromMapPage extends StatefulWidget {
  const SelectFromMapPage({super.key});

  @override
  State<SelectFromMapPage> createState() => _SelectFromMapPageState();
}

class _SelectFromMapPageState extends State<SelectFromMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Container(

      child:  GoogleMap(
          initialCameraPosition: 
          CameraPosition(target: LatLng(
          5.00, .22
          )),

        )
      ),
    );
  }
}