import 'package:get/get.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/presentation_for_doctors_screen/product_image_presentation_screen/product_image_presentation_view.dart';
import 'package:rosewell_life_science/Screens/home_screen/home_binding.dart';
import 'package:rosewell_life_science/Screens/home_screen/home_view.dart';
import 'package:rosewell_life_science/Screens/password_screen/passoword_binding.dart';
import 'package:rosewell_life_science/Screens/password_screen/password_view.dart';
import 'package:rosewell_life_science/Screens/signin_screen/signin_binding.dart';
import 'package:rosewell_life_science/Screens/signin_screen/signin_view.dart';
import 'package:rosewell_life_science/Screens/splash_screen/splash_binding.dart';
import 'package:rosewell_life_science/Screens/splash_screen/splash_view.dart';

part 'app_routes.dart';

Duration transitionDuration = const Duration(milliseconds: 400);

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: Routes.signInScreen,
      page: () => const SignInView(),
      binding: SignInBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: Routes.passwordScreen,
      page: () => const PasswordView(),
      binding: PasswordBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: Routes.productImagePresentationScreen,
      page: () => const ProductImagePresentationView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),
  ];
}
