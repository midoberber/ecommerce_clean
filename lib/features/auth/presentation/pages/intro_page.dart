import 'package:ecommerce_clean/app/cubit_app_main/bloc_main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntoPage extends StatelessWidget {
  const IntoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocMainCubit>(context, listen: false);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red, title: Text(" Intro")),
      body: Center(
          child: TextButton(
        onPressed: () {
          bloc.seenIntro();
        },
        child: Text("Intro"),
      )),
    );
  }
}
