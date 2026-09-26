import 'package:auto_sparkle/common/constants.dart';
import 'package:auto_sparkle/home-component/models/shop_product_summary.dart';
import 'package:auto_sparkle/home-component/widget/carousal_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShopProductWidget extends StatelessWidget {
  final ShopProductSummary product;
  final void Function() onOrderNowPressed;

  const ShopProductWidget({
    super.key,
    required this.product,
    required this.onOrderNowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CarousalContainerWidget(
      header: _buildHeader(context),
      body: _buildBody(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        const ImageIcon(
          ResizeImage(
            AssetImage('assets/images/shop.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
          color: Colors.white,
        ),
        const SizedBox(width: 12),
        Text(
          product.name,
          style: Theme.of(context).textTheme.titleMedium?.merge(
                TextStyle(
                  fontFamily: FontFamily.PRIMARY,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ResizeImage(
                AssetImage(product.image),
                width: 560,
                height: 181,
                allowUpscaling: false,
              ),
              fit: BoxFit.fill,
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
        ),
        _buildQuantity(context),
        _buildPrice(context),
        _buildOrderNow(context),
      ],
    );
  }

  Widget _buildQuantity(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(5),
          ),
          color: Colors.blue.withValues(alpha: 0.8),
        ),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Text(
            product.quality,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrice(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(5),
          ),
          color: Colors.green.withValues(alpha: 0.8),
        ),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Text(
            NumberFormat.simpleCurrency(locale: 'af').format(product.price),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderNow(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
          ),
          color: Colors.transparent.withValues(alpha: 0.4),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Wrap(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(4, 4, 0, 3),
                child: Text(
                  'Order Now',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.merge(const TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ],
          ),
          onTap: () => onOrderNowPressed(),
        ),
      ),
    );
  }
}
