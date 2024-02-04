import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental_admin/assets/svgs/svg_constants.dart';
import 'package:house_rental_admin/core/size/sizes.dart';
import 'package:house_rental_admin/core/spacing/whitspacing.dart';
import 'package:house_rental_admin/locator.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:house_rental_admin/src/home/presentation/bloc/home_bloc.dart';

buildSelectLocation(BuildContext context) {
  TextEditingController controller = TextEditingController();
  final homeBloc = locator<HomeBloc>();
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            height: Sizes().height(context, 0.7),
            //  decoration: BoxDecoration(),
            child: Column(
              children: [
                const Text("Search location"),

                //Space(context,0.02 ),

                Row(
                  children: [
                    BlocConsumer(
                      bloc: homeBloc,
                      listener: (context, state) {
                        if (state is PlaceSearchLoaded) {
                          print(state.placeSearch);
                        }

                        if (state is PlaceSearchError) {
                          print(state.errorMessage);
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: 300,
                          child: DefaultTextfield(
                            onChanged: (value) {
                              Map<String, dynamic> params = {};
                              homeBloc.add(PlaceSearchEvent(params: params));
                            },
                            controller: controller,
                            label: '',
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        context.goNamed("map");
                      },
                      child: SvgPicture.asset(
                        callSVG,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ],
            ));
      });
}
