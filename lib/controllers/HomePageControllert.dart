import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sheetal_raj_jal/controllers/cartController.dart';
import 'package:sheetal_raj_jal/controllers/languageController.dart';
import 'package:sheetal_raj_jal/controllers/loginController.dart';
import 'package:sheetal_raj_jal/screens/planScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/product.dart';
import '../screens/HomeScreen.dart';
import '../screens/OrderPage.dart';
import '../screens/SupportPage.dart';

class HomePageController extends GetxController {
  final _selectedIndex = 0.obs;
  int productIndex = 0;
  String currentGreeting = '';
  List<Product> products = List.empty(growable: true);
  bool isLoading = true;
  String getLocation = 'Unknown';
  CartController cartController = CartController();
  LanguageController languageController = LanguageController();
  LoginController loginController = LoginController();
  @override
  void onInit() {
    currentGreeting = greeting();
    isLoading = true;
    fetchProducts();
    getCurrentLocPosition();
    super.onInit();
  }

  Future<void> getCurrentLocPosition() async {
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) {
      getLocation = "Location Disabled";
      return;
    }
    getLocation = "Loading...";
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position.latitude + position.longitude);

      List<Placemark> addresses =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark firstAddress = addresses.first;
      print(firstAddress);

      String userAddress = firstAddress.locality.toString();
      getLocation = userAddress;
      print('$userAddress ---sj');
    } catch (e) {
      print(e.toString());
      getLocation = 'Error getting location: $e';
    }
    update();
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'morn';
    }
    if (hour < 17) {
      return 'after';
    }
    if (hour < 22) {
      return 'even';
    }
    return 'night';
  }

  int get selectedIndex => _selectedIndex.value;
  final _pages = [
    const HomePage(),
    const OrderPage(),
    const PlansPage(),
    const SupportPage(),
  ];

  void changeIndex(int index) {
    _selectedIndex.value = index;
  }


 get currentPage => _pages[selectedIndex];

  Future<void> fetchProducts() async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select()
          .order('name');
      final List<dynamic> data = response as List<dynamic>;
      products = data.map((json) => Product.fromJson(json)).toList();
      isLoading = false;
    } catch (e) {
      isLoading = false;

      print('Error fetching products: $e');
      rethrow;
    }
    update();
  }
}
