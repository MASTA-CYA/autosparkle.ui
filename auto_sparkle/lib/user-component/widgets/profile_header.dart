import 'package:auto_sparkle/common/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:auto_sparkle/user-component/widgets/profile_image.dart';
import 'package:auto_sparkle/user-component/widgets/profile_statistics.dart';
import 'package:auto_sparkle/user-component/widgets/profile_username.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImage(context),
        const SizedBox(height: 10),
        _buildUsername(),
        const SizedBox(height: 10),
        _buildStatistics(),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return ProfileImageWidget(
      onClicked: () =>
          SnackbarHelper.showComingSoon(context, 'Changing your photo'),
    );
  }

  Widget _buildUsername() {
    return const ProfileUsernameWidget();
  }

  Widget _buildStatistics() {
    return const ProfileStatisticsWidget();
  }
}
