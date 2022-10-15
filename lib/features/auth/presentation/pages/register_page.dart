import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_clean/core/utils/app_colors.dart';
import 'package:ecommerce_clean/core/utils/utils.dart';
import 'package:ecommerce_clean/core/utils/validator.dart';
import 'package:ecommerce_clean/core/widgets/button.dart';
import 'package:ecommerce_clean/core/widgets/generic_field.dart';
import 'package:ecommerce_clean/core/widgets/passWord_field.dart';
import 'package:ecommerce_clean/features/auth/presentation/cubit/register_cubit/cubit/register_cubit.dart';
import 'package:ecommerce_clean/features/auth/presentation/pages/login_page.dart';
import 'package:ecommerce_clean/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<RegisterCubit>(),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Form(
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
                          image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"))),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      tr("fullName"),
                      style: Utils.textStyleColor(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GenericField(
                        labeltext: tr("fullName"),
                        controller: fullName,
                        validation: (value) => Validator.name(value)),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      tr("numberOreEmail"),
                      style: Utils.textStyleColor(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GenericField(
                        hintText: tr("numberOreEmail"),
                        controller: email,
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
                      tr("phone"),
                      style: Utils.textStyleColor(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GenericField(
                        labeltext: tr("phone"),
                        controller: phone,
                        validation: (value) => Validator.phone(value)),
                    const SizedBox(
                      height: 15,
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
                          if (val.length < 7) {
                            return "Password Is Incorrect";
                          }

                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      tr("confirmPassword"),
                      style: Utils.textStyleColor(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Passwordfield(
                        labeltext: tr("confirmPassword"),
                        controller: confirmPassword,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Your Confirm Password";
                          }
                          if (val.length < 7) {
                            return "Confirm Password Is Shoort";
                          }
                          if (val != password.text) {
                            return "Password Not Equal";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 12.h,
                    ),
                    Center(
                      child: GenericButton(
                        width: 200.w,
                        gradient: const LinearGradient(colors: [
                          primary,
                          primary,
                        ]),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {}
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Text(
                          tr("signUp"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Center(
                        child: Text(
                          tr("login"),
                          style: TextStyle(
                            fontSize: 14.sp,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
