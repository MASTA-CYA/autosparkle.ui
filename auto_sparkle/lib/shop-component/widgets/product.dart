import 'package:auto_sparkle/common/helpers/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:auto_sparkle/common/constants.dart';
import 'package:auto_sparkle/common/extensions.dart';
import 'package:auto_sparkle/shop-component/models/product_model.dart';
import 'package:auto_sparkle/shop-component/widgets/product_variation_chip.dart';
import 'package:auto_sparkle/shop-component/widgets/read_more_text.dart';

class ProductWidget extends StatefulWidget {
  final Product product;
  final bool isFavorite;
  final void Function(Product product) onAddToFavoritesPressed;
  final void Function(Product product) onAddToCartPressed;

  const ProductWidget({
    super.key,
    required this.product,
    this.isFavorite = false,
    required this.onAddToFavoritesPressed,
    required this.onAddToCartPressed,
  });

  @override
  State<StatefulWidget> createState() => _ProductWidget();
}

class _ProductWidget extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Theme.of(context).cardTheme.margin,
      child: Column(
        children: [
          _buildProductImage(),
          _buildProductDetails(),
          _buildQuantityPriceDetails(),
          _buildVariations(),
          _buildButtonBar(),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 190,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ResizeImage(
            AssetImage(widget.product.image),
            width: 704,
            height: 380,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.product.name,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleMedium?.merge(
                    TextStyle(
                      fontFamily: FontFamily.PRIMARY,
                      fontWeight: FontWeight.bold,
                      color: ColorHelper.lighten(
                        Theme.of(context).colorScheme.primary,
                        30,
                      ),
                    ),
                  ),
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: ReadMoreTextWidget(
              text: widget.product.description,
              style: Theme.of(context).textTheme.bodyMedium!.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      height: 1.0,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityPriceDetails() {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'af');

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.product.quantity,
            style: Theme.of(context).textTheme.bodyMedium!.merge(
                  const TextStyle(
                    color: Colors.blue,
                  ),
                ),
          ),
          Text(
            formatCurrency.format(widget.product.price),
            style: Theme.of(context).textTheme.bodyMedium!.merge(
                  const TextStyle(
                    color: Colors.green,
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariations() {
    if (widget.product.variations.isNull) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Wrap(
          children: widget.product.variations!
              .map(
                (variation) => ProductVariationChipWidget(
                  variations: variation,
                  startSelected: widget.product.variations!.last.equals(
                    variation,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildButtonBar() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => widget.onAddToFavoritesPressed(widget.product),
            child: Row(
              children: <Widget>[
                Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                const SizedBox(width: 8),
                Text(widget.isFavorite ? 'FAVORITE' : 'ADD TO FAVORITES'),
              ],
            ),
          ),
          InkWell(
            onTap: () => widget.onAddToCartPressed(widget.product),
            child: Row(
              children: <Widget>[
                ImageIcon(
                  const ResizeImage(
                    AssetImage('assets/images/cart.png'),
                    width: 70,
                    height: 70,
                    allowUpscaling: false,
                  ),
                  color: Theme.of(context).iconTheme.color,
                  size: 20,
                ),
                const SizedBox(width: 10),
                const Text('ADD TO CART'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
