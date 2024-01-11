import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rental_admin/assets/svgs/svg_constants.dart';
import 'package:house_rental_admin/core/strings/app_strings.dart';
import 'package:house_rental_admin/core/theme%20copy/colors.dart';
import 'package:house_rental_admin/core/usecase/usecase.dart';
import 'package:house_rental_admin/core/widgets/bottom_sheet.dart';
import 'package:house_rental_admin/locator.dart';
import 'package:house_rental_admin/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/build_house_document_change.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:house_rental_admin/src/home/presentation/bloc/home_bloc.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/bottom_nav_bar.dart';

class AddHomePage extends StatefulWidget {
  const AddHomePage({super.key});

  @override
  State<AddHomePage> createState() => _AddHomePageState();
}

class _AddHomePageState extends State<AddHomePage> {
  final homeBloc = locator<HomeBloc>();
  final formKey = GlobalKey<FormBuilderState>();
  final homeNameController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isImageAvailable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: bottomSheetButton(
        context: context,
        label: "Validate",
        onPressed: () {
          if (formKey.currentState!.saveAndValidate() == true) {
            homeBloc.add(
              AddMultipleImageEvent(
                params: NoParams(),
              ),
            );
            // Map<String, dynamic> params = {
            //   "phone_number": widget.owner.phoneNumber,
            //   "path": profileURL,
            // };
            // homeBloc.add(addHomeEvent(params: params));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        index: 1,
      ),
      appBar: AppBar(
        title: const Text("Add Home or Room"),
      ),
      body: BlocConsumer(
        listener: (BuildContext context, state) {

          if(state is UpLoadMultipleImageLoaded){
            Map<String, dynamic> params = {
              "name": homeNameController.text,
              "description": descriptionController.text,
              "amount": amountController.text,
              // "bed_room_count": bedRoomCount,
              // "bath_room_count": bathRoomCount,
              "images": state.imageURL[0],
            };
            homeBloc.add(AddHomeEvent(params: params));
          }
          if(state is AddHomeLoaded){

          }

          if(state is AddHomeError){

          }
        },
        bloc: homeBloc,
        builder: (context, state) {
          if (state is UpLoadMultipleImageLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // if(state is ){

          // }
          return FormBuilder(
            key: formKey,
            child: Column(
              children: [
                FormBuilderField<String>(
                    name: "homeName",
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return fieldRequired;
                      }
                      if (value!.length <= 5) {
                        return mustBeCharacters;
                      }
                      return null;
                    },
                    builder: (context) {
                      return DefaultTextfield(
                        controller: homeNameController,
                        hintText: "Enter home name",
                        label: "Home name",
                      );
                    }),
                FormBuilderField<num>(
                    name: "rentAmount",
                    validator: (value) {
                      if (value?.isNaN ?? true) {
                        return fieldRequired;
                      }
                      // if (value!. <= 1) {
                      //   return mustBeCharacters;
                      // }
                      return null;
                    },
                    builder: (context) {
                      return DefaultTextfield(
                        textInputType: TextInputType.number,
                        controller: amountController,
                        hintText: "Enter rent amount",
                        label: "Rent amount",
                      );
                    }),
                FormBuilderField<String>(
                    name: "homeDescription",
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return fieldRequired;
                      }
                      if (value!.length <= 2) {
                        return mustBeCharacters;
                      }
                      return null;
                    },
                    builder: (context) {
                      return DefaultTextfield(
                        controller: descriptionController,
                        hintText: "Enter home description",
                        label: "Home Description",
                      );
                    }),
                BlocConsumer(
                  bloc: homeBloc,
                  builder: (context, state) {
                    if (state is AddMultipleImageLoaded) {
                      return SizedBox(
                        width: 180,
                        height: 150,
                        child: CarouselSlider.builder(
                          itemCount: state.files.length,
                          itemBuilder: (context, index, value) {
                            final paths = state.files[index].path;

                            return ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.file(
                                File(paths),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 150,
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: 150,
                            reverse: true,
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      width: 180,
                      height: 150,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                width: 180,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: searchTextColor3,
                                ),
                                child: SvgPicture.asset(cameraSVG)),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                homeBloc.add(
                                    AddMultipleImageEvent(params: NoParams()));
                              },
                              child: SvgPicture.asset(
                                editSVG,
                                color: housePrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  listener: (BuildContext context, state) {
                    if (state is AddMultipleImageError) {
                      debugPrint(state.errorMessage);
                    }
                  },
                ),
              ],
            ),
          );
        },
        
      ),
    );
  }
}
