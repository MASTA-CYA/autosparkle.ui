import 'package:auto_sparkle/appointments-component/widgets/wash_package_selector.dart';
import 'package:auto_sparkle/common/constants.dart';
import 'package:auto_sparkle/common/widgets/form/textfields.dart';
import 'package:flutter/material.dart';

class PackageDetailsStepWidget extends StatefulWidget {
  const PackageDetailsStepWidget({super.key});

  @override
  State<StatefulWidget> createState() => _PackageDetailsStepWidget();
}

class _PackageDetailsStepWidget extends State<PackageDetailsStepWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late List<String> _vehicleTypes;

  @override
  void initState() {
    super.initState();

    _vehicleTypes = [
      'SUV',
      'Hatchback/Sedan',
      'Pickup Truck',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildCategoryDropdown(),
            const SizedBox(height: 8),
            _buildPlateTextField(),
            const SizedBox(height: 14),
            _buildWashPackageSelector(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildPlateTextField() {
    return TextFieldWidget(
      label: 'Number Plate',
      text: '',
      inputAction: TextInputAction.next,
      validator: (value) => null,
      onChanged: (value) {},
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField(
      isDense: true,
      isExpanded: true,
      icon: const Icon(Icons.arrow_downward),
      decoration: InputDecoration(
        labelText: 'Vehicle',
        labelStyle: Theme.of(context).textTheme.bodyLarge?.merge(
              const TextStyle(
                fontFamily: FontFamily.PRIMARY,
              ),
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
        ),
      ),
      items: _vehicleTypes.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getFilterIcon(value),
                const SizedBox(width: 10),
                Text(value),
              ],
            ),
          );
        },
      ).toList(),
      initialValue: _vehicleTypes.first,
      onChanged: (String? value) {},
    );
  }

  Widget _getFilterIcon(String filter) {
    switch (filter) {
      case 'SUV':
        return const ImageIcon(
          ResizeImage(
            AssetImage('assets/images/suv.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
        );
      case 'Hatchback/Sedan':
        return const ImageIcon(
          ResizeImage(
            AssetImage('assets/images/hatchback.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
        );
      case 'Pickup Truck':
        return const ImageIcon(
          ResizeImage(
            AssetImage('assets/images/pickup.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
        );
      default:
        return const ImageIcon(
          ResizeImage(
            AssetImage('assets/images/hatchback.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
        );
    }
  }

  Widget _buildWashPackageSelector() {
    return const WashPackageSelectorWidget();
  }
}
