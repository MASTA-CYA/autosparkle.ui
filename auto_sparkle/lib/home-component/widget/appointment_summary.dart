import 'package:auto_sparkle/home-component/models/appointment_summary_model.dart';
import 'package:flutter/material.dart';

class AppointmentSummaryWidget extends StatelessWidget {
  final AppointmentSummary appointment;
  final void Function() onViewAppointmentPressed;

  const AppointmentSummaryWidget({
    super.key,
    required this.appointment,
    required this.onViewAppointmentPressed,
  });

  final double _TILE_HEIGHT = 159;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: _TILE_HEIGHT),
        child: Row(
          children: [
            _buildPackageClip(),
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
                  _buildLocation(context),
                  const SizedBox(height: 4),
                  _buildPackage(context),
                  _buildActions(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: Text(
        appointment.name,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium?.merge(
              const TextStyle(fontWeight: FontWeight.bold),
            ),
      ),
    );
  }

  Widget _buildPackageClip() {
    return ClipPath(
      clipper: const ShapeBorderClipper(
        shape: RoundedRectangleBorder(),
      ),
      child: Container(
        height: _TILE_HEIGHT,
        width: 5,
        decoration: BoxDecoration(
          color: Colors.yellow[700],
        ),
      ),
    );
  }

  Widget _buildDateTimeInterval(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDate(),
        _buildDateTimeIntervalSpacer(),
        _buildTime(),
        _buildDateTimeIntervalSpacer(),
        _buildInterval(context),
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
        Text(appointment.date),
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
        Text(appointment.time),
      ],
    );
  }

  Widget _buildInterval(BuildContext context) {
    return Row(
      children: [
        const ImageIcon(
          ResizeImage(
            AssetImage('assets/images/recurring.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
          size: 15,
        ),
        const SizedBox(width: 5),
        Text(appointment.interval),
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
            width: 10,
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
          TextSpan(text: appointment.location)
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
              text: appointment.package,
              style: TextStyle(color: Colors.yellow[700]))
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onViewAppointmentPressed,
          child: const Text(
            'VIEW',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
