import 'package:get/get.dart';
import 'package:tusmap_flutter/controllers/main_screen_controller.dart';

class MainPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainScreenController());
  }
  
}