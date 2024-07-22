part of 'app_pages.dart';

/// A chunks of routes and the path names which will be used to create
/// routes in [AppPages].
/// 
abstract class Routes {
  static const splashPage = _Paths.splashPage;
  static const loginPage = _Paths.loginPage;
  static const homePage = _Paths.homePage;
  static const registration = _Paths.registration;
  static const language = _Paths.language;
  static const orders = _Paths.orders;
  static const plans = _Paths.plans;
  static const support = _Paths.support;
  static const cartPage = _Paths.cartPage;
  static const mapPage = _Paths.mapPage;
  static const checkoutPage = _Paths.checkoutPage;
  static const addAddresses = _Paths.addAddresses;
  static const addresses = _Paths.addresses;
  
}

abstract class _Paths {
  static const splashPage = '/splashPage';
  static const loginPage = '/loginPage';
  static const homePage = '/homePage';
  static const registration = '/registration';
  static const language = '/language';
  static const orders = '/orders';
  static const plans = '/plans';
  static const support = '/support';
  static const cartPage = '/cartPage';
  static const mapPage = '/mapPage';
  static const checkoutPage = '/checkoutPage';
  static const addAddresses = '/addAddresses';
  static const addresses = '/addresses';
 
}