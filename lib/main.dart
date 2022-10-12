import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_clean/app/app.dart';
import 'package:flutter/material.dart';
import './injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'lang',
      // fallbackLocale: Locale('en', 'US'),
      saveLocale: true,
      startLocale: const Locale('ar'),
      useOnlyLangCode: true,
      child: App()));
}
