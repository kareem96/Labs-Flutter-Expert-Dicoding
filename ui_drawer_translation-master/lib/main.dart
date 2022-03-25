import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_drawer_translation/constants.dart';
import 'ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Drawer',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        iconTheme: ThemeData.light().iconTheme.copyWith(
              color: AppColor.disableFontColor,
            ),
        textTheme: GoogleFonts.robotoTextTheme(
          const TextTheme(
            headline6: TextStyle(
                color: AppColor.darkFontColor, fontWeight: FontWeight.bold),
            subtitle1: TextStyle(color: AppColor.lightFontColor),
            bodyText1: TextStyle(
                color: AppColor.darkFontColor, fontWeight: FontWeight.w500),
            bodyText2: TextStyle(color: AppColor.disableFontColor),
            caption: TextStyle(color: AppColor.disableFontColor),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
