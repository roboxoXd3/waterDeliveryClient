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
  var products = <Product>[].obs;
  var isLoading = true.obs;
CartController cartController = CartController();
LanguageController languageController = LanguageController();
LoginController loginController = LoginController();
  @override
  void onInit() {
    fetchProducts();
    super.onInit();
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
    // TODO: Implement navigation to other pages
  }

  get currentPage => _pages[selectedIndex];

  // final List<Product> products = [
  //   Product(
  //     id: '1',
  //     nameKey: '15_litre'.tr,
  //     price: 50.0,
  //     imageUrl: 'assets/15litreJar.png',
  //   ),
  //   Product(
  //     id: '2',
  //     nameKey: '25_litre'.tr,
  //     price: 80.0,
  //     imageUrl: 'assets/25LitreJar.png',
  //   ),
  //   // Add more products as needed
  // ];

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response = await Supabase.instance.client
          .from('products')
          .select()
          .order('name');
      final List<dynamic> data = response as List<dynamic>;
      products.value = data.map((json) => Product.fromJson(json)).toList();
      print("Products in the database are: ${products[0].name}");
      print("Products in the database are: ${products[0].description}");
      print("Products in the database are: ${products[0].imageUrl}");
      print("Products in the database are: ${products[0].id}");
      // return (response as List<dynamic>).cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error fetching products: $e');
      rethrow; // Re-throw the error after logging
    }
  }
}
