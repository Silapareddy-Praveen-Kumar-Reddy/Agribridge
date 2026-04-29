import '../models/product.dart';

class ProductData {
  static final List<Product> products = [
    // Vegetables Section
    Product(
      id: '1',
      name: 'Fresh Potatoes',
      description: 'Farm fresh , perfect for salads and cooking',
      price: 40,
      imageUrl:
          'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=500&h=500&fit=crop',
      category: 'Vegetables',
      unit: 'kg',
    ),
    Product(
      id: '2',
      name: 'Organic Potatoes',
      description: 'Premium quality potatoes, locally grown',
      price: 30,
      imageUrl:
          'https://images.unsplash.com/photo-1582284540020-8acbea4d4a54?w=500&h=500&fit=crop',
      category: 'Vegetables',
      unit: 'kg',
    ),
    Product(
      id: '3',
      name: 'Green Bell Peppers',
      description: 'Fresh and crispy bell peppers',
      price: 45,
      imageUrl:
          'https://images.unsplash.com/photo-1563642421748-5047b658a1e4?w=500&h=500&fit=crop',
      category: 'Vegetables',
      unit: 'kg',
    ),
    Product(
      id: '4',
      name: 'Fresh Carrots',
      description: 'Sweet and crunchy carrots',
      price: 35,
      imageUrl:
          'https://images.unsplash.com/photo-1447175008436-0541c9e0e0e3?w=500&h=500&fit=crop',
      category: 'Vegetables',
      unit: 'kg',
    ),
    Product(
      id: '5',
      name: 'Green Lettuce',
      description: 'Crisp and fresh lettuce',
      price: 25,
      imageUrl:
          'https://images.unsplash.com/photo-1622205313162-be1d5712a43c?w=500&h=500&fit=crop',
      category: 'Vegetables',
      unit: 'kg',
    ),
    Product(
      id: '6',
      name: 'Fresh Spinach',
      description: 'Organic spinach leaves',
      price: 30,
      imageUrl:
          'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=500&h=500&fit=crop',
      category: 'Vegetables',
      unit: 'kg',
    ),
    Product(
      id: '7',
      name: 'Red Onions',
      description: 'Premium quality red onions (1 kg)',
      price: 35,
      imageUrl:
          'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=500',
      category: 'Vegetables', unit: 'kg',
    ),
    Product(
      id: '8',
      name: 'Cauliflower',
      description: 'Fresh white cauliflower (per head)',
      price: 40,
      imageUrl:
          'https://images.unsplash.com/photo-1613743983303-b3e89f8a2b80?w=500',
      category: 'Vegetables', unit: 'piece',
    ),

    // Lifestyle Section (keeping some lifestyle products)
    Product(
      id: '9',
      name: 'Organic Honey',
      description: 'Pure organic honey (500g)',
      price: 200,
      imageUrl:
          'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=500',
      category: 'Lifestyle', unit: 'jar',
    ),
    Product(
      id: '10',
      name: 'Herbal Tea',
      description: 'Organic herbal tea blend (100g)',
      price: 120,
      imageUrl:
          'https://images.unsplash.com/photo-1597481499750-3e6b22637e12?w=500',
      category: 'Lifestyle', unit: 'pack',
    ),
  ];
}
