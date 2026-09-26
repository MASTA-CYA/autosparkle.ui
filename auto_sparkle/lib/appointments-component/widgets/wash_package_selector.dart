import 'package:auto_sparkle/appointments-component/enums/package_actions.dart';
import 'package:auto_sparkle/appointments-component/models/wash_package_model.dart';
import 'package:auto_sparkle/appointments-component/widgets/package_tile.dart';
import 'package:auto_sparkle/common/constants.dart';
import 'package:auto_sparkle/common/extensions.dart';
import 'package:auto_sparkle/common/helpers/color_helper.dart';
import 'package:flutter/material.dart';

class WashPackageSelectorWidget extends StatefulWidget {
  const WashPackageSelectorWidget({super.key});

  @override
  State<WashPackageSelectorWidget> createState() =>
      _WashPackageSelectorWidgetState();
}

class _WashPackageSelectorWidgetState extends State<WashPackageSelectorWidget> {
  late List<WashPackage> _packages;
  late Map<int, bool> _packageState;

  @override
  void initState() {
    super.initState();

    _packages = [
      WashPackage(
        id: 0,
        name: 'Bronze',
        color: ColorHelper.fromHex('#CD7F32'),
        actions: [
          PackageAction.wash,
          PackageAction.dry,
        ],
        price: 50,
      ),
      WashPackage(
        id: 1,
        name: 'Silver',
        color: ColorHelper.fromHex('#C0C0C0'),
        actions: [
          PackageAction.vacuum,
          PackageAction.wash,
          PackageAction.dry,
        ],
        price: 70,
      ),
      WashPackage(
        id: 2,
        name: 'Gold',
        color: ColorHelper.fromHex('#FFDE2E'),
        actions: [
          PackageAction.vacuum,
          PackageAction.dashboard,
          PackageAction.wash,
          PackageAction.dry,
          PackageAction.tyres
        ],
        price: 150,
      ),
      WashPackage(
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
    ];

    _packageState = {};
    _packageState.addEntries(
      _packages.map(
        (package) => MapEntry(package.id, package.id.equals(0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Package',
            style: TextStyle(
              fontFamily: FontFamily.PRIMARY,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildPackages(),
      ],
    );
  }

  Widget _buildPackages() {
    return StatefulBuilder(
      builder: (context, setState) => SizedBox(
        height: 260,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _packages.length,
          itemBuilder: (context, index) => SizedBox(
            width: 200,
            child: PackageTileWidget(
              package: _packages.elementAt(index),
              isSelected: _packageState[_packages.elementAt(index).id] ?? false,
              onPackageSelected: (id) => _onPackageSelected(id, setState),
            ),
          ),
        ),
      ),
    );
  }

  void _onPackageSelected(int id, StateSetter setState) {
    setState(
      () {
        for (final int key in _packageState.keys) {
          _packageState.update(key, (value) => id.equals(key) ? !value : false);
        }
      },
    );
  }
}
