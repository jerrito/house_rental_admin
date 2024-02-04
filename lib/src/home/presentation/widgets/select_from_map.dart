import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:house_rental_admin/core/size/sizes.dart';
import 'package:house_rental_admin/core/spacing/whitspacing.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_button.dart';
import 'package:geolocator/geolocator.dart';

class SelectFromMapPage extends StatefulWidget {
  const SelectFromMapPage({super.key});

  @override
  State<SelectFromMapPage> createState() => _SelectFromMapPageState();
}

class _SelectFromMapPageState extends State<SelectFromMapPage> {
  Future<Position> getLocation() async {
    final geolocator = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return geolocator;
  }

  Position? loc;

  void mapCreated(GoogleMapController controller) async{
    loc = await getLocation();
          setState(() {}); 
    mapController = controller;
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: GoogleMap(
        onMapCreated: mapCreated,
        minMaxZoomPreference: const MinMaxZoomPreference(10, 16),
        initialCameraPosition: CameraPosition(
          target: LatLng(loc?.latitude ?? 5.00, loc?.longitude ?? .22),
          zoom: 14.0,
          bearing: loc?.heading ?? 0
        ),
        myLocationEnabled: true,
        onTap: (latLng) async {
          context.pop({});
          
          showModalBottomSheet(
            context: context,
            builder: ((context) {
              return Container(
                height: Sizes().height(context, 0.32),
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes().width(context, 0.054),
                  vertical: Sizes().height(context, 0.02),
                ),
                child: Column(
                  children: [
                    Text("Location"),
                    Space().height(context, 0.02),
                    Text(""),
                    DefaultButton(label: "Save", onTap: () {})
                  ],
                ),
              );
            }),
          );
        },
      )),
    );
  }
}
