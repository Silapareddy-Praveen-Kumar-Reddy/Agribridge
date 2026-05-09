import 'package:flutter/material.dart';
import 'package:agribridge/screens/home_page.dart';
import 'package:agribridge/screens/vendor_opportunities_screen.dart';
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

  final List<({IconData icon, String label})> _navItems = const [
    (icon: Icons.home_rounded, label: 'Home'),
    (icon: Icons.store_rounded, label: 'Vendor'),
    (icon: Icons.contact_support_rounded, label: 'Contact'),
  ];

  bool _isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 720;

  @override
  Widget build(BuildContext context) {
    final desktop = _isDesktop(context);

    if (desktop) {
      // ── Desktop layout: top AppBar navigation ──────────────────────────
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.black12,
          surfaceTintColor: Colors.white,
          title: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF34A853),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.eco, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              const Text(
                'AgriBridge',
                style: TextStyle(
                  color: Color(0xFF34A853),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          actions: [
            ..._navItems.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final selected = _selectedIndex == i;
              return TextButton.icon(
                onPressed: () => setState(() => _selectedIndex = i),
                icon: Icon(
                  item.icon,
                  size: 18,
                  color: selected
                      ? const Color(0xFF34A853)
                      : Colors.black54,
                ),
                label: Text(
                  item.label,
                  style: TextStyle(
                    color: selected
                        ? const Color(0xFF34A853)
                        : Colors.black54,
                    fontWeight: selected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              );
            }),
            const SizedBox(width: 12),
            const FloatingCartButton(),
            const SizedBox(width: 16),
          ],
        ),
        body: _screens[_selectedIndex],
      );
    }

    // ── Mobile layout: bottom navigation ───────────────────────────────
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF34A853),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: _navItems
            .map((item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.label,
                ))
            .toList(),
      ),
      floatingActionButton: const FloatingCartButton(),
    );
  }
}
