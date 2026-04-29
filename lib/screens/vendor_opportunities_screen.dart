import 'package:flutter/material.dart';
import 'package:agribridge/widgets/floating_cart_button.dart';
import 'vendor_form_screen.dart';

class VendorOpportunitiesScreen extends StatelessWidget {
  const VendorOpportunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF34A853),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Vendor Opportunities',
          style: TextStyle(color: Colors.black87),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Become a Vendor',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF34A853),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Join our platform and start selling your agricultural products directly to customers. We provide:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    _FeatureItem(
                      icon: Icons.store,
                      text: 'Your own vendor profile',
                    ),
                    _FeatureItem(
                      icon: Icons.people,
                      text: 'Access to thousands of customers',
                    ),
                    _FeatureItem(
                      icon: Icons.analytics,
                      text: 'Sales analytics and insights',
                    ),
                    _FeatureItem(
                      icon: Icons.local_shipping,
                      text: 'Logistics support',
                    ),
                    _FeatureItem(
                      icon: Icons.payment,
                      text: 'Secure payment processing',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF34A853),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VendorFormScreen(),
                  ),
                );
              },
              child: const Text(
                'Register as a Vendor',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingCartButton(),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF34A853),
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
