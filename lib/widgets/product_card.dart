import 'package:material_ui/material_ui.dart';
import 'package:shimmer/shimmer.dart';
import '../models/product.dart';
import 'custom_button.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.isFavorite = false,
    this.onFavoriteToggle,
    this.onAddToCart,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.9),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.9, end: 1.0),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _performAction(VoidCallback? action) {
    _controller.forward(from: 0);
    action?.call();
  }

  Widget _buildImage() {
    final colors = Theme.of(context).colorScheme;

    return Image.asset(
      widget.product.imageAsset,
      fit: BoxFit.contain,
      frameBuilder: (context, child, frame, loaded) {
        if (loaded || frame != null) {
          return child;
        }

        return Shimmer.fromColors(
          baseColor: colors.surfaceContainerHighest,
          highlightColor: colors.surface,
          child: Container(
            color: colors.surfaceContainerHighest,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(Icons.devices, size: 80),
        );
      },
    );
  }

  void _showImage() {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          height: 350,
          child: InteractiveViewer(
            child: _buildImage(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = widget.product;

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if ((details.primaryVelocity ?? 0).abs() > 100) {
          _performAction(widget.onFavoriteToggle);
        }
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: _showImage,
                  child: SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: _buildImage(),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: widget.onFavoriteToggle == null
                        ? null
                        : () => _performAction(
                      widget.onFavoriteToggle,
                    ),
                    icon: Icon(
                      widget.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.isFavorite
                          ? theme.colorScheme.error
                          : theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${product.price.toStringAsFixed(0)} грн',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ScaleTransition(
                    scale: _animation,
                    child: CustomButton(
                      text: 'До кошика',
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: widget.onAddToCart == null
                          ? null
                          : () => _performAction(
                        widget.onAddToCart,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}