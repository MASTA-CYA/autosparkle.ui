import 'package:auto_sparkle/common/constants.dart';
import 'package:auto_sparkle/home-component/models/business_feature_model.dart';
import 'package:auto_sparkle/home-component/widget/carousal_container.dart';
import 'package:flutter/material.dart';

class BusinessFeatureWidget extends StatelessWidget {
  final BusinessFeature feature;

  const BusinessFeatureWidget({
    super.key,
    required this.feature,
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
        ImageIcon(
          ResizeImage(
            AssetImage(feature.icon),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
          color: Colors.white,
        ),
        const SizedBox(width: 12),
        Text(
          feature.name,
          style: Theme.of(context).textTheme.titleMedium?.merge(
                const TextStyle(
                  fontFamily: FontFamily.PRIMARY,
                  color: Colors.white,
                ),
              ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: feature.description,
      ),
    );
  }
}
