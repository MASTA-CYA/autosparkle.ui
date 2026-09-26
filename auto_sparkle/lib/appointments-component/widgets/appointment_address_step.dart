import 'package:auto_sparkle/appointments-component/models/address_model.dart';
import 'package:auto_sparkle/common/helpers/snackbar_helper.dart';
import 'package:auto_sparkle/common/widgets/form/textfields.dart';
import 'package:flutter/material.dart';

class AppointmentAddressStepWidget extends StatefulWidget {
  const AppointmentAddressStepWidget({super.key});

  @override
  State<StatefulWidget> createState() => _WashAddressStepWidget();
}

class _WashAddressStepWidget extends State<AppointmentAddressStepWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _canShowLocation = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _shouldUseStoreAddress = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isGarageSelected = ValueNotifier<bool>(true);
  late Address _storeAddress;

  @override
  void initState() {
    super.initState();

    _storeAddress = Address(
      street: '22 Foam Avenue',
      suburb: 'Soap Ville',
      city: 'Shine City',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 10),
          _buildLocationSelector(),
          _buildAddressForm(),
        ],
      ),
    );
  }

  Widget _buildLocationSelector() {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(child: _buildGarageOption(context)),
          const VerticalDivider(
            width: 1,
            thickness: 1,
          ),
          Expanded(child: _buildHomeOption(context)),
        ],
      ),
    );
  }

  Widget _buildGarageOption(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: ValueListenableBuilder(
        valueListenable: _isGarageSelected,
        builder: (context, isGarage, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageIcon(
              const ResizeImage(
                AssetImage('assets/images/garage.png'),
                width: 70,
                height: 70,
                allowUpscaling: false,
              ),
              color: isGarage
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).iconTheme.color,
            ),
            Text(
              'Garage',
              style: Theme.of(context).textTheme.titleMedium?.merge(
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isGarage
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                  ),
            )
          ],
        ),
      ),
      onTap: () => _onLocationSelected(true),
    );
  }

  Widget _buildHomeOption(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: ValueListenableBuilder(
        valueListenable: _isGarageSelected,
        builder: (context, isGarage, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageIcon(
              const ResizeImage(
                AssetImage('assets/images/home-1.png'),
                width: 70,
                height: 70,
                allowUpscaling: false,
              ),
              color: !isGarage
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).iconTheme.color,
            ),
            Text(
              'Home',
              style: Theme.of(context).textTheme.titleMedium?.merge(
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      color: !isGarage
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                  ),
            )
          ],
        ),
      ),
      onTap: () => _onLocationSelected(false),
    );
  }

  Widget _buildAddressForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: ValueListenableBuilder(
              valueListenable: _canShowLocation,
              builder: (context, canShow, child) => Column(
                children: [
                  const SizedBox(height: 30),
                  canShow
                      ? _buildUseCurrentLocation()
                      : const SizedBox.shrink(),
                  canShow
                      ? const SizedBox(height: 30)
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: ValueListenableBuilder(
              valueListenable: _shouldUseStoreAddress,
              builder: (context, canUse, child) => Column(
                children: [
                  _buildStreetTextField(canUse),
                  const SizedBox(height: 8),
                  _buildSuburbTextField(canUse),
                  const SizedBox(height: 8),
                  _buildCityTextField(canUse),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUseCurrentLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Use current location instead?'),
        Align(
          alignment: Alignment.centerRight,
          child: Material(
            elevation: 2,
            shape: const CircleBorder(),
            color: Theme.of(context).colorScheme.primary,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () =>
                  SnackbarHelper.showComingSoon(context, 'Current location'),
              child: Container(
                margin: const EdgeInsets.all(3),
                child: const Icon(
                  Icons.my_location_sharp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStreetTextField(bool canUse) {
    return TextFieldWidget(
      key: UniqueKey(),
      label: 'Street',
      text: canUse ? _storeAddress.street : '',
      inputAction: TextInputAction.next,
      validator: (value) => null,
      onChanged: (value) {},
    );
  }

  Widget _buildSuburbTextField(bool canUse) {
    return TextFieldWidget(
      key: UniqueKey(),
      label: 'Suburb',
      text: canUse ? _storeAddress.suburb : '',
      inputAction: TextInputAction.next,
      validator: (value) => null,
      onChanged: (value) {},
    );
  }

  Widget _buildCityTextField(bool canUse) {
    return TextFieldWidget(
      key: UniqueKey(),
      label: 'City',
      text: canUse ? _storeAddress.city : '',
      inputAction: TextInputAction.next,
      validator: (value) => null,
      onChanged: (value) {},
    );
  }

  void _onLocationSelected(bool isGarage) {
    _canShowLocation.value = !isGarage;
    _shouldUseStoreAddress.value = isGarage;
    _isGarageSelected.value = isGarage;
  }
}
