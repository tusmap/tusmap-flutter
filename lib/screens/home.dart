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
              if (MainScreenController.to.selectNavigationBarIdx == 0)
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          elevation: 4,
                          child: SizedBox(
                            height: 50,
                            child: const TextField(
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.list, color: Colors.black),
                                suffixIcon:
                                    Icon(Icons.mic, color: Colors.black),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              //no Underline
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                          onPressed: () {},
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.purple),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: const Text(
                                '검색',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Stack(
              children: [
                BottomNavigationBar(
                  onTap: (idx) => MainScreenController.to.changeIdx(idx),
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.purple,
                  currentIndex: MainScreenController.to.selectNavigationBarIdx,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.location_on),
                      label: '주변',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.train_sharp),
                      label: '길찾기',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
