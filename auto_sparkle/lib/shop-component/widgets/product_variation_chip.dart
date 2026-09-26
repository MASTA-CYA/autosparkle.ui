import 'package:flutter/material.dart';
import 'package:auto_sparkle/common/helpers/color_helper.dart';
import 'package:auto_sparkle/shop-component/models/product_variation_model.dart';

class ProductVariationChipWidget extends StatefulWidget {
  final ProductVariation variations;
  final bool? startSelected;

  const ProductVariationChipWidget({
    super.key,
    required this.variations,
    this.startSelected,
  });

  @override
  State<ProductVariationChipWidget> createState() =>
      _ProductVariationChipWidgetState();
}

class _ProductVariationChipWidgetState
    extends State<ProductVariationChipWidget> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();

    _isSelected = widget.startSelected ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onVariantSelected(),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: widget.variations.color,
            borderRadius: const BorderRadius.all(
              Radius.circular(45),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: _isSelected
                  ? ColorHelper.lighten(
                      widget.variations.color,
                      70,
                    )
                  : Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(
                Radius.circular(45),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: Text(widget.variations.name),
            ),
          ),
        ),
      ),
    );
  }

  void _onVariantSelected() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }
}
