
import 'package:material_ui/material_ui.dart';
import '../models/product.dart';
import '../utils/app_state.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  final AppState appState;

  const ProductsScreen({
    super.key,
    required this.appState,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _onlyFavorites = false;

  final List<Product> _products = const [
    Product(
      id: '1',
      name: 'Смартфон',
      description: 'Сучасний смартфон 128 GB',
      price: 15999,
      imageAsset: 'assets/images/phone.jpg',
    ),
    Product(
      id: '2',
      name: 'Ноутбук',
      description: 'Ноутбук для роботи та навчання',
      price: 32999,
      imageAsset: 'assets/images/laptop.jpg',
    ),
    Product(
      id: '3',
      name: 'Навушники',
      description: 'Бездротові Bluetooth-навушники',
      price: 2999,
      imageAsset: 'assets/images/headphones.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.appState,
      builder: (context, child) {
        final products = _onlyFavorites
            ? widget.appState.favoriteProducts
            : _products;

        return LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 1000
                ? 3
                : constraints.maxWidth >= 650
                ? 2
                : 1;

            final cardWidth =
                (constraints.maxWidth - 32 - (columns - 1) * 12) /
                    columns;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Каталог товарів',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),

                Text(
                  'Товарів у кошику: ${widget.appState.cartItemsCount}',
                ),

                const SizedBox(height: 8),

                if (widget.appState.cartItemsCount > 0)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Очистити кошик'),
                      onPressed: () {
                        widget.appState.clearCart();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Кошик очищено'),
                          ),
                        );
                      },
                    ),
                  ),

                SwitchListTile(
                  title: const Text('Тільки обране'),
                  value: _onlyFavorites,
                  onChanged: (value) {
                    setState(() {
                      _onlyFavorites = value;
                    });
                  },
                ),

                const SizedBox(height: 12),

                if (products.isEmpty)
                  const Center(
                    child: Text('Обраних товарів немає'),
                  ),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    for (final product in products)
                      SizedBox(
                        width: cardWidth,
                        child: ProductCard(
                          key: ValueKey(product.id),
                          product: product,
                          isFavorite:
                          widget.appState.isFavorite(product),
                          onFavoriteToggle: () {
                            widget.appState.toggleFavorite(product);
                          },
                          onAddToCart: () {
                            widget.appState.addToCart(product);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${product.name} додано до кошика',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
