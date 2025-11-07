import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension SizerExt on num {
  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height
  double get h => this * appSizer.getSize.height / 100;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.w -> will take 20% of the screen's width
  double get w => this * appSizer.getSize.width / 100;

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  double get sp => this * (appSizer.getSize.width / 3) / 100;
}

class AppSizer {
  Size _size = const Size(100, 100);

  Orientation _orientation = Orientation.portrait;

  Size get getSize => _size;

  Orientation get getOrientation => _orientation;

  void setSize(Size value) {
    _size = value;
  }

  void setOrientation(Orientation orientation) {
    _orientation = orientation;
  }
}

AppSizer appSizer = AppSizer();

Future<void> setSize(Size size) async {
  appSizer.setSize(size);
}

Future<void> setOrientation(Orientation orientation) async {
  appSizer.setOrientation(orientation);
}

Size getSize() {
  return appSizer.getSize;
}

Rx<Orientation> getOrientation() {
  return appSizer.getOrientation.obs;
}
