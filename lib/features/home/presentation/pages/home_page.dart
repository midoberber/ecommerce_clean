import 'package:ecommerce_clean/app/cubit_app_main/bloc_main_cubit.dart';
import 'package:ecommerce_clean/config/routes/app_navigator.dart';
import 'package:ecommerce_clean/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocMainCubit>(context, listen: false);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red, title: Text(" Home")),
      body: Center(
          child: TextButton(
        onPressed: () {
          bloc.repository.loadAppData()!.isGuestUser == true
              ? AppNavigator.push(context: context, screen: LoginPage())
              : null;
        },
        child: bloc.repository.loadAppData()!.isGuestUser == true
            ? Text("Guest Now")
            : Text("Home User Now"),
      )),
    );
  }
}
