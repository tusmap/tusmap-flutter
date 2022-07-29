import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tusmap_flutter/controllers/main_screen_controller.dart';
import 'package:tusmap_flutter/screens/main.dart';
import 'package:tusmap_flutter/screens/search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = [
    Main(),
    Search()
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainScreenController>(
      builder: (controller) => Scaffold(
        body: pages[MainScreenController.to.selectNavigationBarIdx],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            onTap: (idx) => MainScreenController.to.changeIdx(idx),
            currentIndex: MainScreenController.to.selectNavigationBarIdx,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Map'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search'
              ),
            ],
          )
        ),
      ),
    );
  }
}