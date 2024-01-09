import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rental_admin/locator.dart';
import 'package:house_rental_admin/src/authentication/domain/entities/owner.dart';
import 'package:house_rental_admin/src/authentication/presentation/bloc/authentication_bloc.dart';

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
      bottomNavigationBar: BottomNavigationBarWidget(index: 0,),
      body:BlocConsumer(
          bloc: authBloc,
          listener: (context, state) {
            if (state is GetCacheDataLoaded) {
              owner = state.owner;
              debugPrint(owner?.toMap().toString());
              setState(() {});
            }
          },
        builder: (context,state) {
          return Column(
            children: [
            Text(owner?.firstName ?? "d"),
          
          ],);
        }
      )
    );
  }
}
