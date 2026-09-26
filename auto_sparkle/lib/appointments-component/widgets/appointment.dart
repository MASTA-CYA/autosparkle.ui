import 'package:auto_sparkle/appointments-component/widgets/appointment_confirm_step.dart';
import 'package:auto_sparkle/appointments-component/widgets/appointment_date_step.dart';
import 'package:auto_sparkle/appointments-component/widgets/package_details_step.dart';
import 'package:auto_sparkle/appointments-component/widgets/appointment_address_step.dart';
import 'package:auto_sparkle/common/functions.dart';
import 'package:auto_sparkle/common/helpers/snackbar_helper.dart';
import 'package:auto_sparkle/common/widgets/appbar.dart';
import 'package:auto_sparkle/common/widgets/custom_stepper.dart';
import 'package:auto_sparkle/common/widgets/form/button.dart';
import 'package:flutter/material.dart';

class AppointmentWidget extends StatefulWidget {
  const AppointmentWidget({super.key});

  @override
  State<StatefulWidget> createState() => _AppointmentWidget();
}

class _AppointmentWidget extends State<AppointmentWidget> {
  final String _title = 'Appointment';

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget<AppointmentWidget>(title: _title),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Functions.horizontalScreenMargin(context),
          vertical: 4,
        ),
        child: _buildStepper(),
      ),
    );
  }

  Widget _buildStepper() {
    return CustomStepperWidget(
      elevation: 4,
      physics: const BouncingScrollPhysics(),
      type: StepperType.horizontal,
      connectorThickness: 1.5,
      currentStep: _currentStep,
      onStepContinue: () => _onStepContinue(),
      onStepCancel: () => _onStepCancel(),
      onStepTapped: (step) => _onStepTapped(step),
      controlsBuilder: (context, details) => _buildButtonBar(details),
      steps: _buildSteps(),
    );
  }

  List<Step> _buildSteps() {
    return [
      Step(
        state: _getStepState(0),
        isActive: _currentStep >= 0,
        title: Text(
          'Package',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        content: const PackageDetailsStepWidget(),
      ),
      Step(
        state: _getStepState(1),
        isActive: _currentStep >= 1,
        title: Text(
          'Address',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        content: const AppointmentAddressStepWidget(),
      ),
      Step(
        state: _getStepState(2),
        isActive: _currentStep >= 2,
        title: Text(
          'Date',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        content: const AppointmentDateStepWidget(),
      ),
      Step(
        state: _getStepState(3),
        isActive: _currentStep >= 3,
        title: Text(
          'Confirm',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        content: const AppointmentConfirmStepWidget(),
      ),
    ];
  }

  StepState _getStepState(int index) {
    if (_currentStep == index) return StepState.editing;
    if (_currentStep > index) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  Widget _buildButtonBar(ControlsDetails details) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep != 3) ...[
            if (_currentStep != 0)
              Expanded(
                child: FormButtonWidget(
                  isPrimary: false,
                  text: 'Back',
                  onClicked: details.onStepCancel,
                ),
              ),
            if (_currentStep != 0) const SizedBox(width: 8),
            Expanded(
              child: FormButtonWidget(
                text: 'Next',
                onClicked: details.onStepContinue,
              ),
            ),
          ] else ...[
            Expanded(
              child: FormButtonWidget(
                isPrimary: false,
                text: 'Back',
                onClicked: details.onStepCancel,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FormButtonWidget(
                text: 'Checkout',
                onClicked: () =>
                    SnackbarHelper.showComingSoon(context, 'Online payment'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _onStepContinue() {
    if (_currentStep != 3) _currentStep++;
    setState(() {});
  }

  void _onStepCancel() {
    if (_currentStep != 0) _currentStep--;
    setState(() {});
  }

  void _onStepTapped(int step) {
    _currentStep = step;
    setState(() {});
  }
}
