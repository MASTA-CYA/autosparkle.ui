import 'package:auto_sparkle/common/constants.dart';
import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  final bool isEdit;
  final VoidCallback? onClicked;

  const ProfileImageWidget({
    super.key,
    this.isEdit = false,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.onPrimary;

    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: Center(
        child: Stack(
          children: [
            _buildImage(),
            Positioned(
              bottom: 0,
              right: 4,
              child: _buildEditIcon(context, color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: const ResizeImage(
            AssetImage(DemoUser.AVATAR),
            width: 300,
            height: 300,
            allowUpscaling: false,
          ),
          fit: BoxFit.cover,
          width: 150,
          height: 150,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget _buildEditIcon(BuildContext context, Color color) => buildCircle(
        color: color,
        all: 3,
        child: buildCircle(
          color: Theme.of(context).colorScheme.primary,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: color,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
