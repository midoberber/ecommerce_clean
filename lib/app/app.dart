import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_clean/app/app_data.dart';
import 'package:ecommerce_clean/app/cubit_app_main/bloc_main_cubit.dart';
import 'package:ecommerce_clean/core/utils/app_colors.dart';
import 'package:ecommerce_clean/features/home/presentation/pages/home_page.dart';
import 'package:ecommerce_clean/features/auth/presentation/pages/intro_page.dart';
import 'package:ecommerce_clean/features/auth/presentation/pages/login_page.dart';
import 'package:ecommerce_clean/features/auth/presentation/pages/pin_code_page.dart';
import 'package:ecommerce_clean/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => sl<BlocMainCubit>(),
          ),
        ],
        child: BlocConsumer<BlocMainCubit, BlocMainState>(
            listener: (context, state) {
          if (state is UpdateDataState) {
            log(state.appData.toString());
          } else {
            log(state.props.toString());
          }
        },
            // ignore: prefer_typing_uninitialized_variables
            builder: (context, state) {
          final bloc = BlocMainCubit(repository: sl());

          Widget currentPage;
          switch (bloc.appState) {
            case AppState.notSeenTutorial:
              currentPage = // import 'package:flutter/material.dart';
                  IntoPage();

              break;
            case AppState.guest:
              currentPage = HomePage();

              break;
            case AppState.authenticated:
              currentPage = HomePage();

              break;
            case AppState.unauthenticated:
              currentPage = LoginPage();
              break;
            // case AppState.notCompleted:
            //   currentPage = ComplateInfo();
            //   break;
            case AppState.notVerified:
              currentPage = PinPage();
              break;
            default:
              currentPage = Scaffold(
                appBar: AppBar(
                  title: Text("Loading"),
                ),
              );
              ;
          }
          return MaterialApp(
              theme: ThemeData(
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                  ),
                  fontFamily: "Almarai",
                  hintColor: black,
                  backgroundColor: Colors.white,
                  primaryColor: primary,
                  scrollbarTheme: ScrollbarThemeData().copyWith(
                    thumbColor: MaterialStateProperty.all(Color(0xffff8297)),
                  ),
                  colorScheme:
                      ColorScheme.fromSwatch().copyWith(secondary: primary)),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              routes: {
                "/login": (_) => LoginPage(),
                // "/Home": (_) => HomeMain(),
                "/pinPage": (_) => PinPage(),
                '/': (context) => currentPage,
              },
              home: Builder(
                  builder: (context) => ScreenUtilInit(
                        designSize: Size(MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height),
                        minTextAdapt: true,
                        splitScreenMode: true,
                        builder: (BuildContext context, Widget? child) =>
                            currentPage,
                      )));
        }));
  }
}
