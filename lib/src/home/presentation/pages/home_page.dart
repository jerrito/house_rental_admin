import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rental_admin/locator.dart';
import 'package:house_rental_admin/src/authentication/domain/entities/owner.dart';
import 'package:house_rental_admin/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental_admin/src/home/presentation/bloc/home_bloc.dart';
import 'package:house_rental_admin/src/home/presentation/pages/add_home.dart';
import 'package:house_rental_admin/src/home/presentation/pages/edit_home.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/list_row_houses.dart';
import '../widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  final String? uid;
  final bool? isLogin;
  final String? phoneNumber;
  const HomePage({
    super.key,
    this.uid,
    this.isLogin,
    this.phoneNumber,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authBloc = locator<AuthenticationBloc>();
  final homeBloc = locator<HomeBloc>();
  final searchController = TextEditingController();
  Owner? owner;

  @override
  void initState() {
    super.initState();
    authBloc.add(const GetCacheDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint(user?.id);

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("My House/Rooms"),
        actions: [
          IconButton(
              onPressed: () {
                print(owner?.id);
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return AddHomePage(
                      id: owner?.id ?? "",
                      name: "${owner?.firstName} ${owner?.lastName}",
                      phoneNumber: owner?.phoneNumber ?? "");
                }));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        index: 0,
      ),
      body: BlocListener(
        bloc: authBloc,
        listener: (context, state) {
          if (state is GetCacheDataLoaded) {
            owner = state.owner;
            debugPrint(owner?.toMap().toString());
            setState(() {});
            Map<String, dynamic> params = {
              "id": owner?.id ?? "",
              "phone_number": owner?.phoneNumber ?? "",
            };
            homeBloc.add(GetAllHousesEvent(params: params));
          }
        },
        child: BlocConsumer(
            bloc: homeBloc,
            listener: (context, state) {
              if (state is GetAllHousesLoaded) {}

              if (state is GetAllHouseError) {
                debugPrint(state.errorMessage);
              }
            },
            builder: (context, state) {
              if (state is GetAllHousesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is GetAllHousesLoaded) {
                return ListView.builder(
                    itemCount: state.houses.docs.length,
                    itemBuilder: (context, index) {
                      return HouseRowDetails(
                        onTap: () {
                          print("touched $index");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditHomePage(
                                  house: state.houses.docs[index].data()),
                            ),
                          );
                        },
                        bedRoomCount:
                            state.houses.docs[index].data().bedRoomCount ?? 0,
                        bathRoomCount:
                            state.houses.docs[index].data().bathRoomCount ?? 0,
                        houseIMageURL:
                            state.houses.docs[index].data().images?[0] ?? "",
                        houseName:
                            state.houses.docs[index].data().houseName ?? "",
                        amount: state.houses.docs[index].data().amount ?? 0,
                      );
                    });
              }
              return const SizedBox();
            }),
      ),
    );
  }
}
