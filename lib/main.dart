import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tusmap_flutter/binding/main_screen_binding.dart';
import 'package:tusmap_flutter/screens/home.dart';
import 'package:tusmap_flutter/screens/search.dart';
import 'package:tusmap_flutter/themes/color_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'tus map',
      theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Home(), binding: MainPageBinding()),
        GetPage(name: '/search', page: () => Search())
      ],
    );
  }
}