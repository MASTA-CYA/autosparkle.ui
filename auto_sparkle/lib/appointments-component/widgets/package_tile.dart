import 'package:auto_sparkle/appointments-component/enums/package_actions.dart';
import 'package:auto_sparkle/appointments-component/models/wash_package_model.dart';
import 'package:auto_sparkle/common/constants.dart';
import 'package:auto_sparkle/common/helpers/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PackageTileWidget extends StatelessWidget {
  final WashPackage package;
  final bool isSelected;
  final void Function(int id) onPackageSelected;

  const PackageTileWidget({
    super.key,
    required this.package,
    required this.isSelected,
    required this.onPackageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: _buildActions(context),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: _buildPrice(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: ColorHelper.lighten(package.color, 85),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTitle(context),
              _buildSelector(context),
            ],
          ),
        ),
      ),
      onTap: () => onPackageSelected(package.id),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: Text(
        package.name,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium?.merge(
              TextStyle(
                fontFamily: FontFamily.PRIMARY,
                fontWeight: FontWeight.bold,
                color: package.color,
              ),
            ),
      ),
    );
  }

  Widget _buildSelector(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: package.color,
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? package.color : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: package.actions
          .map(
            (action) => Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  ImageIcon(
                    ResizeImage(
                      AssetImage('assets/images/${action.icon}.png'),
                      width: 70,
                      height: 70,
                      allowUpscaling: false,
                    ),
                    size: 22,
                  ),
                  const SizedBox(width: 20),
                  Text(action.displayName),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildPrice(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        NumberFormat.simpleCurrency(locale: 'en_za').format(package.price),
        style: Theme.of(context).textTheme.bodyMedium?.merge(
              const TextStyle(color: Colors.green),
            ),
      ),
    );
  }
}
