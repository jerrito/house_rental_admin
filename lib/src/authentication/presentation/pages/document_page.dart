import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:house_rental_admin/assets/images/image_constants.dart';
import 'package:house_rental_admin/core/size/sizes.dart';
import 'package:house_rental_admin/core/spacing/whitspacing.dart';
import 'package:house_rental_admin/core/strings/app_strings.dart';
import 'package:house_rental_admin/core/theme/colors.dart';
import 'package:house_rental_admin/core/widgets/bottom_sheet.dart';
import 'package:house_rental_admin/locator.dart';
import 'package:house_rental_admin/src/authentication/domain/entities/owner.dart';
import 'package:house_rental_admin/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:house_rental_admin/src/home/presentation/pages/home_page.dart';

class DocumentSubmissionPage extends StatefulWidget {
  final Map<String, dynamic> owner;
  const DocumentSubmissionPage({
    Key? key,
    required this.owner,
  }) : super(key: key);

  @override
  State<DocumentSubmissionPage> createState() => _DocumentSubmissionPageState();
}

class _DocumentSubmissionPageState extends State<DocumentSubmissionPage> {
  final authBloc = locator<AuthenticationBloc>();
  final auth = FirebaseAuth.instance;
  String? profileURL;
  final houseGPSAddressController = TextEditingController();
  final townOrCityController = TextEditingController();
  final roleController = TextEditingController();
  final houseDocumentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Document Submission"),
        ),
        bottomSheet: bottomSheetButton(
          context: context,
          label: "Validate",
          onPressed: () {
            final users = {
              "house_GPS_address": houseGPSAddressController.text,
              "town_or_city": townOrCityController.text,
              "role": roleController.text,
              "phone_number": widget.owner["phoneNumber"],
              "uid": widget.owner["uid"],
              "first_name": widget.owner["first_name"],
              "last_name": widget.owner["last_name"],
              "email": widget.owner["email"],
              "password": widget.owner["password"],
              "profile_URL": profileURL,
            };

            authBloc.add(
              SignupEvent(users: users),
            );
          },
        ),
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            bloc: authBloc,
            listener: (context, state) {
              if (state is GenericError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }

              if (state is SignupLoaded) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return HomePage(
                      uid: widget.owner["uid"],
                      isLogin: false,
                      phoneNumber: widget.owner["phone_number"],
                    );
                  }),
                );
                //  GoRouter.of(context).pushReplacementNamed("homePage");
              }
            },
            builder: (context, state) {
              if (state is SignupLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes().height(context, 0.02)),
                  child: Column(
                    children: [
                      FormBuilderField<String>(
                          name: "profileURL",
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
                            return CircleAvatar(
                              radius: 45,
                              backgroundColor: searchTextColor1,
                              backgroundImage: profileURL != null
                                  ? Image.asset(profileURL!).image
                                  : Image.asset(user1Image,
                                          width: 100, height: 100)
                                      .image,
                            );
                          }),

                          Space().height(context,0.04),

                      //GPS Address
                      FormBuilderField<String>(
                          name: "GPSAddress",
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
                              controller: houseGPSAddressController,
                              label: "GPS Address",
                              hintText: "Enter your GPS Address",
                            );
                          }),

                      //town or city
                      FormBuilderField<String>(
                          name: "townOrCity",
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
                              controller: townOrCityController,
                              label: "Town or City",
                              hintText: "Enter your Town or City",
                            );
                          }),

                    
                    FormBuilderField<String>(
                          name: "profileURL",
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
                            return Column(
                              children: [
                               const Text("House Document",),
                                Container(
                                  width: 180,height:150,
                                  decoration:BoxDecoration(
                                    color: searchTextColor1,
                                    image: DecorationImage(image: 
                                    profileURL != null
                                      ? Image.asset(profileURL!).image
                                      : Image.asset(user1Image,
                                              width: 100, height: 100)
                                          .image,)
                                  ),
                                 
                                ),
                              ],
                            );
                          }),
                     

                      Space().height(context, 0.02),
                    ],
                  ),
                ),
              );
            }));
  }
}
