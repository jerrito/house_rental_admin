import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rental_admin/assets/svgs/svg_constants.dart';
import 'package:house_rental_admin/core/size/sizes.dart';
import 'package:house_rental_admin/core/spacing/whitspacing.dart';
import 'package:house_rental_admin/core/strings/app_strings.dart';
import 'package:house_rental_admin/core/theme%20copy/colors.dart';
import 'package:house_rental_admin/core/usecase/usecase.dart';
import 'package:house_rental_admin/core/widgets/bottom_sheet.dart';
import 'package:house_rental_admin/locator.dart';
import 'package:house_rental_admin/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_button.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:house_rental_admin/src/home/presentation/bloc/home_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/build_select_location.dart';

class AddHomePage extends StatefulWidget {
  final String id, phoneNumber ,name;
  const AddHomePage({
    super.key,
    required this.id,
    required this.phoneNumber,
    required this.name
  }); 

  @override
  State<AddHomePage> createState() => _AddHomePageState();
}

class _AddHomePageState extends State<AddHomePage> {
  final homeBloc = locator<HomeBloc>();
  final authBloc = locator<AuthenticationBloc>();
  final formKey = GlobalKey<FormBuilderState>();
  final homeNameController = TextEditingController();
  final amountController = TextEditingController();
  final bathRoomController = TextEditingController();
  final bedRoomController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isImageAvailable = true;
  List<String>? images = [];

  @override
  void initState() {
    print("${widget.id} jj");
    print("${widget.phoneNumber} jj");
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BlocConsumer(
        bloc: homeBloc,
        listener: (context, state) {
          if (state is UpLoadMultipleImageLoaded) {
            Map<String, dynamic> params = {
              "house_name": homeNameController.text,
              "description": descriptionController.text,
              "amount": num.parse(amountController.text),
              "bed_room_count": num.parse(bedRoomController.text),
              "bath_room_count": num.parse(bathRoomController.text),
              "images": state.imageURL,
              "owner": widget.name,
              "phone_number": widget.phoneNumber,
              "lat": "",
              "long": "",
              "category":""
              //"id": widget.id
            };
            homeBloc.add(
              AddHomeEvent(params: params),
            );
          }

          if (state is AddHomeLoaded) {
            context.goNamed("homePage");
          }

          if (state is AddHomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                ),
              ),
            );
            debugPrint(state.errorMessage);
          }

          if (state is UpLoadMultipleImageError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
            debugPrint(state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is AddHomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UpLoadMultipleImageLoading) {
          return  const Center(child: CircularProgressIndicator());
          }
          return bottomSheetButton(
            context: context,
            label: "Add Home",
            onPressed: () {
              if (formKey.currentState!.saveAndValidate() == true) {
                Map<String, dynamic> params = {
                  "phone_number": widget.phoneNumber,
                  "path": images,
                  "images": images?.length
                };
                homeBloc.add(UpLoadMultipleImageEvent(params: params));
              }
            },
          );
        },
      ),
      appBar: AppBar(
        title: const Text("Add Home or Room"),
      ),
      body: FormBuilder(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes().width(context, 0.04)),
                child: FormBuilderField<String>(
                    name: "homeName",
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return fieldRequired;
                      }
                      if (value!.length <= 1) {
                        return mustBeCharacters;
                      }
                      return null;
                    },
                    builder: (context) {
                      return DefaultTextfield(
                        controller: homeNameController,
                        hintText: "Enter home name",
                        label: "Home name",
                        errorText: context.errorText,
                        onChanged: (p0) => context.didChange(p0),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes().width(context, 0.04)),
                child: FormBuilderField<num>(
                    name: "rentAmount",
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return numberRequired;
                      }
                      if (value.isNaN) {
                        return numberRequired;
                      }
                      if (value <= 1) {
                        return mustBeAtleast;
                      }

                      return null;
                    },
                    builder: (context) {
                      return DefaultTextfield(
                          textInputType: TextInputType.number,
                          controller: amountController,
                          hintText: "Enter rent amount",
                          label: "Rent amount",
                          errorText: context.errorText,
                          onChanged: (p0) => context.didChange(
                                (num.parse(p0!)),
                              ));
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes().width(context, 0.04)),
                child: FormBuilderField<int>(
                    name: "bedRooms",
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return numberRequired;
                      }
                      if (value.isNaN) {
                        return numberRequired;
                      }
                      if (value <= 0) {
                        return mustBeAtleast;
                      }
                      if (value >= 13) {
                        return mustBeAtmost;
                      }
                      return null;
                    },
                    builder: (context) {
                      return DefaultTextfield(
                        textInputType: TextInputType.number,
                        controller: bedRoomController,
                        hintText: "Enter number of Bed Rooms",
                        label: "Number of Bed Rooms",
                        errorText: context.errorText,
                        onChanged: (p0) => context.didChange(
                          (int.parse(p0!)),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes().width(context, 0.04)),
                child: FormBuilderField<int>(
                    name: "bathRooms",
                    validator: (value) {
                      if (value?.isNaN ?? true) {
                        return numberRequired;
                      }
                      if (value! <= 0) {
                        return mustBeAtleast;
                      }
                      if (value >= 13) {
                        return mustBeAtmost;
                      }
                      return null;
                    },
                    builder: (context) {
                      return DefaultTextfield(
                        textInputType: TextInputType.number,
                        controller: bathRoomController,
                        hintText: "Enter number of Bath Rooms",
                        label: "Number of Bath Rooms",
                        errorText: context.errorText,
                        onChanged: (p0) => context.didChange(
                          (int.parse(p0!)),
                        ),
                      );
                    }),
              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: Sizes().width(context,0.04),),
                child:DefaultButton(
                  label: "Add Location",
                  onTap: (){
                    buildSelectLocation(context);
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes().width(context, 0.04)),
                child: Row(
                  children: [
                    const Text("House Image(s)"),
                    Space().width(context, 0.03),
                    GestureDetector(
                      onTap: () {
                        homeBloc.add(
                          AddMultipleImageEvent(
                            params: NoParams(),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        editSVG,
                        color: housePrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Space().height(context, 0.02),
              FormBuilderField<List<String>>(
                  name: "house_images",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return fieldRequired;
                    }

                    return null;
                  },
                  builder: (field) {
                    return InputDecorator(
                      decoration: InputDecoration(errorText: field.errorText),
                      child: BlocConsumer(
                        bloc: homeBloc,
                        builder: (context, state) {
                          if (state is AddMultipleImageLoaded) {
                            return SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: CarouselSlider.builder(
                                itemCount: state.files.length,
                                itemBuilder: (context, index, value) {
                                  final paths = state.files[index].path;

                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Sizes().width(context, 0.04)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                        File(paths ?? ""),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 150,
                                      ),
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
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Sizes().width(context, 0.04)),
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Sizes().width(context, 0.08)),
                                width: 180,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: searchTextColor3,
                                ),
                                child: GestureDetector(
                                    onTap: () {
                                      homeBloc.add(AddMultipleImageEvent(
                                          params: NoParams()));
                                    },
                                    child: SvgPicture.asset(cameraSVG))),
                          );
                        },
                        listener: (BuildContext context, state) {
                          if (state is AddMultipleImageError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  state.errorMessage,
                                ),
                              ),
                            );
                            debugPrint(state.errorMessage);
                          }
                          if (state is AddMultipleImageLoaded) {
                            for (int i = 0; i < state.files.length; i++) {
                              images?.add(state.files[i].path!);
                            }
                            field.didChange(images);
                          }
                        },
                      ),
                    );
                  }),
              FormBuilderField<String>(
                  name: "homeDescription",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return fieldRequired;
                    }
                    if (value!.length <= 1) {
                      return mustBeCharacters;
                    }
                    return null;
                  },
                  builder: (field) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes().width(context, 0.04)),
                      child: DefaultTextArea(
                        //height: 100,
                        controller: descriptionController,
                        hintText: "Enter home description",
                        label: "Home Description",
                        errorText: field.errorText,
                        onChanged: (p0) => field.didChange(p0),
                      ),
                    );
                  }),
              Space().height(context, 0.02)
            ],
          ),
        ),
      ),
    );
  }
}
