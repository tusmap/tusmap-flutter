import 'package:get/get.dart';

class MainScreenController extends GetxController {
  static MainScreenController get to => Get.find();
  int selectNavigationBarIdx = 0;

  void changeIdx(int idx) {
    selectNavigationBarIdx = idx;
    update();
  }
}