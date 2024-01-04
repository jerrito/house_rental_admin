import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rental_admin/core/size/sizes.dart';
import 'package:house_rental_admin/core/spacing/whitspacing.dart';
import 'package:house_rental_admin/core/widgets/bottom_sheet.dart';
import 'package:house_rental_admin/locator.dart';
import 'package:house_rental_admin/src/authentication/domain/entities/owner.dart';
import 'package:house_rental_admin/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:house_rental_admin/src/home/presentation/pages/home_page.dart';

class DocumentSubmissionPage extends StatefulWidget {
  final Owner owner;
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
              "phone_number": widget.owner.phoneNumber,
              "uid": widget.owner.uid ,
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
                              uid: widget.owner.uid,
                              isLogin: false,
                              phoneNumber: widget.owner.phoneNumber,
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
                      //firstName
                      DefaultTextfield(
                        controller: houseGPSAddressController,
                        label: "GPS Address",
                        hintText: "Enter your GPS Address",
                      ),

                      //last Name
                      DefaultTextfield(
                        controller: townOrCityController,
                        label: "Town or City",
                        hintText: "Enter your Town or City",
                      ),

                      //email
                      DefaultTextfield(
                        controller: roleController,
                        label: "Role",
                        hintText: "Enter your role",
                      ),

                      //email
                      DefaultTextfield(
                        controller: houseDocumentController,
                        label: "House Document",
                        hintText: "Enter your House Document",
                      ),


                      Space().height(context, 0.02),
                    ],
                  ),
                ),
              );
            }));
  }
}
