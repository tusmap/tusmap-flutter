import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tusmap_flutter/controllers/main_screen_controller.dart';
import 'package:tusmap_flutter/screens/main.dart';
import 'package:tusmap_flutter/screens/search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = [Main(), Search()];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainScreenController>(
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              pages[MainScreenController.to.selectNavigationBarIdx],
            ],
          ),
        ),
      ),
    );
  }
}
