import 'package:auto_sparkle/common/helpers/snackbar_helper.dart';
import 'package:auto_sparkle/common/themes/themes_common.dart';
import 'package:auto_sparkle/common/widgets/appbar.dart';
import 'package:auto_sparkle/common/widgets/drawer/custom_navigation_drawer.dart';
import 'package:auto_sparkle/shop-component/models/product_model.dart';
import 'package:auto_sparkle/shop-component/models/product_variation_model.dart';
import 'package:auto_sparkle/shop-component/widgets/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<StatefulWidget> createState() => _ShopPage();
}

class _ShopPage extends State<ShopPage> {
  final String _title = 'Shop';

  late List<Product> _products;
  final Set<int> _favoriteProductIds = {};

  @override
  void initState() {
    super.initState();

    _products = [
      Product(
        id: 0,
        image: 'assets/images/kit.jpg',
        name: 'Driving kit',
        description:
            'A one of kind driving kit for the serious car enthusiast. '
            'Hand crafted to perfection to meet your every driving need.',
        quantity: '1\tset',
        price: 594,
        variations: [
          ProductVariation(name: 'Baby Blue', color: Colors.blue),
          ProductVariation(name: 'Cherry Red', color: Colors.red),
        ],
      ),
      Product(
        id: 1,
        image: 'assets/images/dashcam.jpg',
        name: 'God\'s Eye Camera',
        description:
            'A state of art dash cam with cloud capabilities. Uses WiFi/Mobile data '
            'to stream video footage in real-time. '
            'Accident detection can alert police and health care professionals of choice',
        quantity: '1\tpc',
        price: 7931,
        variations: [
          ProductVariation(name: 'Sunshine Yellow', color: Colors.yellow),
          ProductVariation(
            name: 'Carbon Grey',
            color: ThemesCommon.secondaryColor,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget<ShopPage>(
        title: _title,
        actions: GestureDetector(
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 4, 6, 0),
              child: Icon(
                CupertinoIcons.search,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          onTap: () => SnackbarHelper.showComingSoon(context, 'Search'),
        ),
      ),
      drawer: const CustomNavigationDrawer<ShopPage>(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: _buildShopScaffold(),
      ),
    );
  }

  Widget _buildShopScaffold() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: _products.length,
      itemBuilder: (context, index) => ProductWidget(
        product: _products.elementAt(index),
        isFavorite:
            _favoriteProductIds.contains(_products.elementAt(index).id),
        onAddToFavoritesPressed: (product) => _toggleFavorite(product),
        onAddToCartPressed: (product) => _addToCart(product),
      ),
    );
  }

  void _toggleFavorite(Product product) {
    final bool isFavorite = _favoriteProductIds.contains(product.id);
    setState(
      () => isFavorite
          ? _favoriteProductIds.remove(product.id)
          : _favoriteProductIds.add(product.id),
    );
    SnackbarHelper.show(
      context,
      isFavorite
          ? '${product.name} removed from favorites'
          : '${product.name} added to favorites',
      icon: isFavorite ? Icons.favorite_border : Icons.favorite,
    );
  }

  void _addToCart(Product product) {
    SnackbarHelper.show(
      context,
      '${product.name} added to your cart',
      icon: Icons.shopping_cart_outlined,
    );
  }
}
