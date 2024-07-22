import 'package:get/get.dart';
import 'package:sheetal_raj_jal/Binding/addressFormBinding.dart';
import 'package:sheetal_raj_jal/Binding/addressListBinding.dart';
import 'package:sheetal_raj_jal/Binding/homebinding.dart';
import 'package:sheetal_raj_jal/Binding/languageBinding.dart';
import 'package:sheetal_raj_jal/Binding/loginBinding.dart';
import 'package:sheetal_raj_jal/Binding/order_binding.dar.dart';
import 'package:sheetal_raj_jal/Binding/registrationBinding.dart';
import 'package:sheetal_raj_jal/Binding/splash_binding.dart';
import 'package:sheetal_raj_jal/Binding/supportBinding.dart';
import 'package:sheetal_raj_jal/controllers/cartController.dart';
import 'package:sheetal_raj_jal/controllers/checkoutController.dart';
import 'package:sheetal_raj_jal/controllers/planController.dart';
import 'package:sheetal_raj_jal/screens/OrderPage.dart';
import 'package:sheetal_raj_jal/screens/SupportPage.dart';
import 'package:sheetal_raj_jal/screens/addressFormScreen.dart';
import 'package:sheetal_raj_jal/screens/addressListScreen.dart';
import 'package:sheetal_raj_jal/screens/cartPage.dart';
import 'package:sheetal_raj_jal/screens/checkoutPage.dart';
import 'package:sheetal_raj_jal/screens/language_selection_screen.dart';
import 'package:sheetal_raj_jal/screens/login_screen.dart';
import 'package:sheetal_raj_jal/screens/mainNavigation.dart';
import 'package:sheetal_raj_jal/screens/planScreen.dart';
import 'package:sheetal_raj_jal/screens/registration_screen.dart';
import 'package:sheetal_raj_jal/screens/splashScreen.dart';

// class AppPages {
//   static final routes = [
//     GetPage(
//       name: '/register',
//       page: () => const RegistrationScreen(),
//       binding: RegistrationBinding(),
//     ),
//     GetPage(
//       name: '/login',
//       page: () => const LoginScreen(),
//       binding: BindingsBuilder(() {
//         Get.put(LoginController());
//       }),
//     ),
//     // Other routes...
//     GetPage(
//       name: '/addresses',
//       page: () => const AddressListScreen(),
//       binding: AddressListBinding(),
//     )
//   ];
// }

part 'app_routes.dart';

/// [pages]
class AppPages {
  static var transitionDuration = const Duration(
    milliseconds: 250,
  );
  // static const initial = Routes.firstPage;
  // static const initial1 = Routes.dashBoardPage;
  static const initial = Routes.splashPage;

  static final pages = [
    GetPage<dynamic>(
      name: _Paths.splashPage,
      transitionDuration: transitionDuration,
      page: SplashScreen.new,
      binding: SplashBinding(),
      transition: Transition.cupertino,
    ),
    GetPage<dynamic>(
      name: _Paths.loginPage,
      transitionDuration: transitionDuration,
      page: LoginScreen.new,
      binding: LoginBinding(),
      transition: Transition.cupertino,
    ),
    GetPage<dynamic>(
      name: _Paths.registration,
      transitionDuration: transitionDuration,
      page: RegistrationScreen.new,
      binding: RegistrationBinding(),
      transition: Transition.cupertino,
    ),
    GetPage<dynamic>(
      name: _Paths.homePage,
      transitionDuration: transitionDuration,
      page: MainNavigation.new,
      binding: HomeBinding(),
      transition: Transition.cupertino,
    ),
    GetPage<dynamic>(
      name: _Paths.language,
      transitionDuration: transitionDuration,
      page: LanguageSelectionScreen.new,
      binding: LanguageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage<dynamic>(
      name: _Paths.orders,
      transitionDuration: transitionDuration,
      page: OrderPage.new,
      binding: OrderPageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage<dynamic>(
      name: _Paths.plans,
      transitionDuration: transitionDuration,
      page: PlansPage.new,
      binding: BindingsBuilder(() {
            Get.lazyPut<PlansController>(() => PlansController());
          }),
      transition: Transition.cupertino,
    ),
    GetPage<dynamic>(
      name: _Paths.support,
      transitionDuration: transitionDuration,
      page: SupportPage.new,
      binding: SupportBinding(),
      transition: Transition.cupertino,
    ),
    GetPage<dynamic>(
      name: _Paths.cartPage,
      transitionDuration: transitionDuration,
      page: CartPage.new,
      binding: BindingsBuilder(() {
            Get.lazyPut<CartController>(() => CartController());
          }),
      transition: Transition.cupertino,
    ),
    GetPage<dynamic>(
      name: _Paths.checkoutPage,
      transitionDuration: transitionDuration,
      page: CheckoutPage.new,
      binding: BindingsBuilder(() {
            Get.lazyPut<CheckoutController>(() => CheckoutController());
          }),
      transition: Transition.cupertino,
    ),
    // GetPage<dynamic>(
    //   name: _Paths.mapPage,
    //   transitionDuration: transitionDuration,
    //   page: MapPage.new,
    //   binding: HomeBinding(),
    //   transition: Transition.cupertino,
    // ),
    GetPage<dynamic>(
      name: _Paths.addAddresses,
      transitionDuration: transitionDuration,
      page: AddressFormScreen.new,
      binding: AddressFormBinding(),
      transition: Transition.cupertino,
    ),
    GetPage<dynamic>(
      name: _Paths.addresses,
      transitionDuration: transitionDuration,
      page: AddressListScreen.new,
      binding: AddressListBinding(),
      transition: Transition.cupertino,
    ),
    
  ];
}
