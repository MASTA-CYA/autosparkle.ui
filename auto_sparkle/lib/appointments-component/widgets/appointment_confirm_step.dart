import 'package:auto_sparkle/appointments-component/enums/package_actions.dart';
import 'package:auto_sparkle/appointments-component/models/wash_package_model.dart';
import 'package:auto_sparkle/appointments-component/widgets/package_tile.dart';
import 'package:auto_sparkle/common/helpers/snackbar_helper.dart';
import 'package:auto_sparkle/common/widgets/form/textfields.dart';
import 'package:flutter/material.dart';

class AppointmentConfirmStepWidget extends StatefulWidget {
  const AppointmentConfirmStepWidget({super.key});

  @override
  State<StatefulWidget> createState() => _AppointmentCompleteStepWidget();
}

class _AppointmentCompleteStepWidget
    extends State<AppointmentConfirmStepWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool _isRecurring;

  @override
  void initState() {
    super.initState();

    _isRecurring = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildVehicleDetails(),
          _buildPackage(),
          _buildSpecialInstructionsOptions(),
          const SizedBox(height: 14),
          _buildRecurringAppointment(),
        ],
      ),
    );
  }

  Widget _buildVehicleDetails() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildVehicleType(),
          _buildVehiclePlate(),
          _buildTime(),
        ],
      ),
    );
  }

  Widget _buildVehicleType() {
    return Material(
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.all(4),
        child: const Row(
          children: [
            ImageIcon(
              ResizeImage(
                AssetImage('assets/images/suv.png'),
                width: 70,
                height: 70,
                allowUpscaling: false,
              ),
              color: Colors.purple,
            ),
            SizedBox(width: 12),
            Text('SUV'),
          ],
        ),
      ),
    );
  }

  Widget _buildVehiclePlate() {
    return Material(
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.all(4),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImageIcon(
              ResizeImage(
                AssetImage('assets/images/plate.png'),
                width: 70,
                height: 70,
                allowUpscaling: false,
              ),
              color: Colors.purple,
            ),
            SizedBox(width: 12),
            Text('BC XB 11 • ZN'),
          ],
        ),
      ),
    );
  }

  Widget _buildTime() {
    return Material(
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.all(4),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImageIcon(
              ResizeImage(
                AssetImage('assets/images/time.png'),
                width: 70,
                height: 70,
                allowUpscaling: false,
              ),
              color: Colors.purple,
            ),
            SizedBox(width: 12),
            Text('11:00'),
          ],
        ),
      ),
    );
  }

  Widget _buildPackage() {
    return SizedBox(
      height: 260,
      child: PackageTileWidget(
        isSelected: true,
        package: WashPackage(
          id: 3,
          name: 'VIP',
          color: Colors.purple,
          actions: [
            PackageAction.vacuum,
            PackageAction.dashboard,
            PackageAction.wash,
            PackageAction.dry,
            PackageAction.tyres,
            PackageAction.polish,
          ],
          price: 200,
        ),
        onPackageSelected: (id) {},
      ),
    );
  }

  Widget _buildSpecialInstructionsOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _buildInstructionsTextField(),
        ),
        _buildVoiceNoteButton(),
      ],
    );
  }

  Widget _buildInstructionsTextField() {
    return TextFieldWidget(
      label: 'Instructions',
      text: '',
      maxLines: 3,
      inputAction: TextInputAction.next,
      validator: (value) => null,
      onChanged: (value) => {},
    );
  }

  Widget _buildVoiceNoteButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: FloatingActionButton(
        heroTag: 'special-fab',
        child: const Icon(
          Icons.mic,
          color: Colors.white,
        ),
        onPressed: () => SnackbarHelper.showComingSoon(context, 'Voice notes'),
      ),
    );
  }

  Widget _buildRecurringAppointment() {
    return StatefulBuilder(
      builder: (context, setState) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.trailing,
        value: _isRecurring,
        title: const Text(
          'Recurring',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Make appointment recurring every Saturday',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        secondary: Icon(
          Icons.info_outline,
          color: Colors.blue[300],
        ),
        onChanged: (isChecked) =>
            _onRecurringChanged(isChecked ?? false, setState),
      ),
    );
  }

  void _onRecurringChanged(bool isChecked, StateSetter stateSetter) {
    stateSetter(() => _isRecurring = isChecked);
  }
}
