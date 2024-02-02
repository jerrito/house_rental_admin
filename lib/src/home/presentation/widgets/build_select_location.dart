import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rental_admin/core/size/sizes.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_textfield.dart';

buildSelectLocation(BuildContext context) {
  TextEditingController controller=TextEditingController();
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: Sizes().height(context, 0.7),
        //  decoration: BoxDecoration(),
       child: Column(
         children: [

         const Text("Search location"),

           Row(
             children: [
               DefaultTextfield(
                  controller:controller ,
                   label: '',
                ),

                GestureDetector(
                  onTap:(){
                    
                  },
                  child: SvgPicture.asset(
                    ""
                  ),
                )
             ],
           ),


         ],
       )

        );
      });
}
