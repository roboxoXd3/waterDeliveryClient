import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({super.key, 
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.home, 'home'.tr, 0),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.shopping_bag, 'orders'.tr, 1),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.calendar_today, 'plans'.tr, 2),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.support_agent, 'support'.tr, 3),
              label: '',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: onItemTapped,
        ),
      ),
    );
  }

  Widget _buildIcon(IconData iconData, String label, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(selectedIndex == index ? 8.0 : 5.0),
          decoration: BoxDecoration(
            color: selectedIndex == index
                ? Colors.blue.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(iconData),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: selectedIndex == index ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }
}
