import 'dart:async';

import 'package:ecommerce_clean/app/cubit_app_main/bloc_main_cubit.dart';
import 'package:ecommerce_clean/config/routes/app_navigator.dart';
import 'package:ecommerce_clean/core/utils/app_colors.dart';
import 'package:ecommerce_clean/core/utils/utils.dart';
import 'package:ecommerce_clean/core/widgets/button.dart';
import 'package:ecommerce_clean/features/auth/presentation/cubit/pin_code_cubit/pin_code_cubit.dart';
import 'package:ecommerce_clean/features/auth/presentation/pages/login_page.dart';
import 'package:ecommerce_clean/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class PinPage extends StatefulWidget {
  const PinPage({Key? key, this.isForget = false}) : super(key: key);
  final bool isForget;
  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 60;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer!.cancel();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController verFicationCode = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final appModel = BlocProvider.of<BlocMainCubit>(context, listen: false);
    var currentLocal = Localizations.localeOf(context).languageCode;

    return BlocProvider(
      create: (BuildContext context) => sl<PinCodeCubit>(),
      child: WillPopScope(
        onWillPop: ()async { 
           await Navigator.pushNamed(context, "/login");
           return true;
         },
        child: Scaffold(
          backgroundColor: const Color(0xffffffffff),
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                AppNavigator.push(context: context,screen: LoginPage());
              },
            ),
            title: Text(
              "كود التحقق",
              style: TextStyle(color: Colors.black, fontSize: 20.h),
            ),
          ),
          body:  Form(
              key: _formKey,
              child: GestureDetector(
                // onTap: () {
                //   FocusManager.instance.primaryFocus?.unfocus();
                // },
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * .4,
                            alignment: Alignment.center,
                           decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/logo.png"))),
                          ),
                        ),
                        Text(
                          "برجاء ادخال كود التأكيد الذى تم ارساله على الاميل",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          appModel.repository.loadAppData()!.email!.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Directionality(
                          textDirection: currentLocal == "ar"
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          child: PinCodeTextField(
                            length: 4,
                            appContext: context,

                            // controller: _pincodeController,
                            animationType: AnimationType.fade,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              // FilteringTextInputFormatter.digitsOnly
                            ],

                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.underline,
                                fieldHeight: 50.h,
                                fieldWidth: 50.w,
                                activeColor: const Color(0xFF70C8B8),
                                disabledColor: Colors.black,
                                selectedColor: Color(0xFF70C8B8),
                                inactiveColor: Colors.black26,
                                inactiveFillColor: Color(0xFF70C8B8)),
                            pastedTextStyle: const TextStyle(
                              color: Color(0xFF70C8B8),
                              fontWeight: FontWeight.bold,
                            ),
                            controller: verFicationCode,

                            onChanged: (String value) {},
                            onCompleted: (value) {
                              print(verFicationCode.text);
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter PinCode";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 60.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  ' $secondsRemaining',
                                  style: const TextStyle(
                                      color: primary, fontSize: 10),
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: enableResend
                                  ? () {
                                      // model.resendCode(context: context);
                                      _resendCode();
                                    }
                                  : null,
                              child: Text(
                                "اعادة ارسال؟",
                                style: TextStyle(
                                    color: enableResend
                                        ? primary
                                        : Colors.black,
                                    fontSize: 14.sp),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                       GenericButton(
                                width: double.infinity,
                                gradient: const LinearGradient(colors: [
                                  primary,
                                  primary,
                                ]),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // model.activate(
                                    //     isforget: widget.isForget,
                                    //     context: context,
                                    //     verfication: verFicationCode.text);
                                  }
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Text(
                                  "تأكيد",
                                  style: Utils.textStyleColor(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ),
      
    );
  }
}
