import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agribridge/providers/cart_provider.dart';
import 'package:agribridge/screens/home_page.dart';
import 'package:agribridge/screens/cart_screen.dart';
import 'package:agribridge/screens/vendor_opportunities_screen.dart';
import 'package:agribridge/screens/vendor_form_screen.dart';
import 'package:agribridge/screens/contact_screen.dart';
import 'package:agribridge/widgets/floating_cart_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const VendorOpportunitiesScreen(),
    const ContactScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Vendor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_support),
            label: 'Contact',
          ),
        ],
      ),
      floatingActionButton: const FloatingCartButton(),
    );
  }
}
