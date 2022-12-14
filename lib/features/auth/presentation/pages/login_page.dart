import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_clean/app/cubit_app_main/bloc_main_cubit.dart';
import 'package:ecommerce_clean/config/routes/app_navigator.dart';
import 'package:ecommerce_clean/core/utils/app_colors.dart';
import 'package:ecommerce_clean/core/utils/assets_manager.dart';
import 'package:ecommerce_clean/core/utils/utils.dart';
import 'package:ecommerce_clean/core/widgets/generic_field.dart';
import 'package:ecommerce_clean/core/widgets/passWord_field.dart';
import 'package:ecommerce_clean/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_clean/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:ecommerce_clean/features/home/presentation/pages/home_page.dart';
import 'package:ecommerce_clean/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();

  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<LoginCubit>(),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body:
              //  Consumer<LoginProvider>(
              //   builder: (BuildContext context, model, Widget? child) =>
              Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200.h,
                      decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage(logo))),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      tr("Email"),
                      style: Utils.textStyleColor(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GenericField(
                        hintText: tr("numberOreEmail"),
                        controller: fullName,
                        validation: (val) {
                          if (val!.isEmpty) {
                            return "Enter Your Email";
                          }
                          if (val.length < 4) {
                            return "EmailInvlaide";
                          }

                          return null;
                        }),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      tr("password"),
                      style: Utils.textStyleColor(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Passwordfield(
                        hinttext: tr("password"),
                        controller: password,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Your Password";
                          }
                          if (val.length < 4) {
                            return "Password Is Incorrect";
                          }

                          return null;
                        }),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             ForgetPasswordPage()));
                          },
                          child: Text(
                            tr("forgetPassword"),
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    // model.isloading == true
                    //     ? const Center(
                    //         child: CircularProgressIndicator.adaptive(),
                    //       )
                    //     :
                    Center(
                      child: BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginErrorState) {
                            print('error is ${state.message}');
                            // showToast(state.message);
                          }
                          if (state is LoginSuccessState) {
                            BlocProvider.of<BlocMainCubit>(context,
                                    listen: false)
                                .updateData(state.appData);
                            // AppstateNavigator.push(
                            //     context: context, screen: HomePage());
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoadingState) {
                            return const CircularProgressIndicator.adaptive();
                          } else {
                            return GenericButton(
                              width: 200.w,
                              gradient: const LinearGradient(colors: [
                                primary,
                                primary,
                              ]),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginCubit>(context,
                                          listen: false)
                                      .login(
                                          context: context,
                                          loginParams: LoginParams(
                                              email: fullName.text,
                                              password: password.text));
                                }
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Text(
                                tr("login"),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tr("dontHaveAccount"),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SignUpPage()));
                          },
                          child: Text(
                            tr("signUp"),
                            style: TextStyle(
                              fontSize: 14.sp,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     // Navigator.push(
                    //     //     context,
                    //     //     MaterialPageRoute(
                    //     //         builder: (context) => SignUpPage()));
                    //   },
                    //   child: Center(
                    //     child: Text(
                    //      "Login AS guest",
                    //       style: TextStyle(
                    //         fontSize: 14.sp,
                    //         decoration: TextDecoration.underline,
                    //         fontWeight: FontWeight.bold,
                    //         color: primary,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
