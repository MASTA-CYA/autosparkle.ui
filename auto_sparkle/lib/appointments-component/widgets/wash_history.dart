import 'package:auto_sparkle/appointments-component/enums/wash_status_enum.dart';
import 'package:auto_sparkle/appointments-component/models/wash_history_model.dart';
import 'package:auto_sparkle/common/extensions.dart';
import 'package:flutter/material.dart';

class WashHistoryWidget extends StatelessWidget {
  final WashHistory history;
  final void Function()? onReviewPressed;

  const WashHistoryWidget({
    super.key,
    required this.history,
    this.onReviewPressed,
  });

  final double _TILE_HEIGHT = 185;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: _TILE_HEIGHT),
        child: Row(
          children: [
            _buildFaultOutcomeClip(),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    child: _buildTitle(context),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    child: _buildDateTimeInterval(context),
                  ),
                  const SizedBox(height: 8),
                  _buildPackage(context),
                  const SizedBox(height: 4),
                  _buildLocation(context),
                  const SizedBox(height: 4),
                  _buildStatus(context),
                  Visibility(
                    visible: !onReviewPressed.isNull,
                    child: _buildActions(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaultOutcomeClip() {
    return ClipPath(
      clipper: const ShapeBorderClipper(
        shape: RoundedRectangleBorder(),
      ),
      child: Container(
        height: _TILE_HEIGHT,
        width: 5,
        decoration: BoxDecoration(
          color: history.status.color,
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: Text(
        history.name,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium?.merge(
              const TextStyle(fontWeight: FontWeight.bold),
            ),
      ),
    );
  }

  Widget _buildDateTimeInterval(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildDate(),
        _buildDateTimeIntervalSpacer(),
        _buildTime(),
      ],
    );
  }

  Widget _buildDate() {
    return Row(
      children: [
        const ImageIcon(
          ResizeImage(
            AssetImage('assets/images/appointment.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
          size: 15,
        ),
        const SizedBox(width: 5),
        Text(history.date),
      ],
    );
  }

  Widget _buildTime() {
    return Row(
      children: [
        const ImageIcon(
          ResizeImage(
            AssetImage('assets/images/time.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
          size: 15,
        ),
        const SizedBox(width: 5),
        Text(history.time),
      ],
    );
  }

  Widget _buildDateTimeIntervalSpacer() {
    return const Row(
      children: [
        SizedBox(width: 4),
        SizedBox(
          height: 25,
          child: VerticalDivider(
            thickness: 1,
            width: 20,
          ),
        ),
        SizedBox(width: 4),
      ],
    );
  }

  Widget _buildLocation(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: 'Location:\t\t'),
          TextSpan(text: history.location)
        ],
      ),
    );
  }

  Widget _buildPackage(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: 'Package:\t\t'),
          TextSpan(
              text: history.package,
              style: TextStyle(color: Colors.yellow[700]))
        ],
      ),
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: 'Status:\t\t'),
          TextSpan(
            text: history.status.displayName,
            style: TextStyle(color: history.status.color),
          )
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onReviewPressed,
          child: const Text(
            'REVIEW',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
