import 'package:flutter/material.dart';
import 'product_list_screen.dart';
import 'vendor_opportunities_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  bool _isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 720;

  @override
  Widget build(BuildContext context) {
    final desktop = _isDesktop(context);

    return Scaffold(
      backgroundColor: const Color(0xFF34A853),
      // Only show the drawer AppBar on mobile (desktop uses MainScreen's AppBar)
      appBar: desktop
          ? null
          : AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black87),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              title: const Text(
                'MENU',
                style: TextStyle(color: Colors.black87),
              ),
            ),
      drawer: desktop
          ? null
          : Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Color(0xFF34A853)),
                    child: Text(
                      'AgriBridge',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2E7D32), Color(0xFF34A853), Color(0xFF66BB6A)],
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              // Max width so content doesn't stretch on 27" monitors
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: desktop ? 48.0 : 20.0,
                  vertical: desktop ? 60.0 : 40.0,
                ),
                child: desktop
                    ? _buildDesktopLayout(context)
                    : _buildMobileLayout(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Desktop: two-column hero ──────────────────────────────────────────
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: hero text + CTA
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Farm Fresh,\nDelivered Direct.',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Connect directly with local farmers.\nNo middlemen. Better prices. Fresher produce.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildDesktopCTA(context, 'Shop Vegetables',
                      Icons.eco_rounded, 'Vegetables'),
                  _buildDesktopCTA(context, 'Lifestyle Products',
                      Icons.spa_rounded, 'Lifestyle'),
                  _buildDesktopCTA(context, 'Become a Vendor',
                      Icons.store_rounded, 'Vendor'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 60),
        // Right: logo/illustration
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.eco,
                  size: 100,
                  color: Color(0xFF34A853),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'AGRIBRIDGE',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Farmer • Consumer • Future',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 32),
              // Stats row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStat('45%', 'More\nMatches'),
                  const SizedBox(width: 32),
                  _buildStat('30%', 'Faster\nCheckout'),
                  const SizedBox(width: 32),
                  _buildStat('10+', 'Products'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopCTA(
      BuildContext context, String label, IconData icon, String target) {
    return ElevatedButton.icon(
      onPressed: () => _navigate(context, target),
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF34A853),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
    );
  }

  // ── Mobile: original stacked layout (kept clean) ──────────────────────
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.eco, size: 70, color: Color(0xFF34A853)),
        ),
        const SizedBox(height: 16),
        const Text(
          'AGRIBRIDGE',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 32),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Shop',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildMobileButton(context, 'Vegetables', Icons.eco_rounded),
        const SizedBox(height: 12),
        _buildMobileButton(context, 'Lifestyle', Icons.spa_rounded),
        const SizedBox(height: 12),
        _buildMobileButton(
            context, 'Vendor Opportunities', Icons.store_rounded),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildMobileButton(
      BuildContext context, String text, IconData icon) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 20),
        label: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF34A853),
          elevation: 0,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () => _navigate(context, text),
      ),
    );
  }

  void _navigate(BuildContext context, String target) {
    if (target == 'Vendor' || target == 'Vendor Opportunities') {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const VendorOpportunitiesScreen()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const ProductListScreen()));
    }
  }
}
