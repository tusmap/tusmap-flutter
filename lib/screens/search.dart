import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderController extends GetxController {
  Rx<double> range = 10000.0.obs; //again initialized it to a Rx<double>

  void setRange(double range) {
    this.range.value = range; //updating the value of Rx Variable.
  }
}

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  final sx =
      Get.put(SliderController()); //putting the controller in the widget tree

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          _searchRoute(),
          const SizedBox(height: 16),
          _way(),
          const SizedBox(height: 16),
          _slider()
        ],
      ),
    ));
  }

  Row _slider() {
    return Row(
      children: [
        Text("희망 이동 비용"),
        Expanded(
          child: Obx(
            () => Slider(
              value: sx.range.value,
              min: 10000, //initialized it to a double
              max: 100000, //initialized it to a double
              divisions: 100000,
              label: sx.range.round().toString(),
              onChanged: (double value) {
                sx.setRange(value);
              },
            ),
          ),
        ),
        Obx(() => Text("${sx.range.round()}")),
      ],
    );
  }

  Row _way() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.local_taxi),
            Icon(Icons.add),
            Icon(Icons.train),
          ],
        ),
        Icon(Icons.time_to_leave),
        Icon(Icons.directions_walk),
      ],
    );
  }

  Row _searchRoute() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.transform,
          size: 30,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _textfield()),
                  const SizedBox(width: 16),
                  Icon(Icons.close),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _textfield()),
                  const SizedBox(width: 16),
                  Icon(Icons.more_vert),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _textfield() {
    return SizedBox(
      height: 40,
      child: const TextField(
        decoration: InputDecoration(
          fillColor: Colors.grey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        //no Underline
      ),
    );
  }
}
