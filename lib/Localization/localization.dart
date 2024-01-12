import 'package:get/get.dart';
import 'package:rosewell_life_science/Localization/en_IN.dart';
import 'package:rosewell_life_science/Localization/gu_IN.dart';
import 'package:rosewell_life_science/Localization/hi_IN.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en_IN': enIN,
      'hi_IN': hiIN,
      'gu_IN': guIN,
    };
  }
}
