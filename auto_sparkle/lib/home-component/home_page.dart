import 'package:auto_sparkle/appointments-component/appointments_page.dart';
import 'package:auto_sparkle/common/navigator/page_navigator.dart';
import 'package:auto_sparkle/common/navigator/transition_direction_enum.dart';
import 'package:auto_sparkle/common/widgets/appbar.dart';
import 'package:auto_sparkle/common/widgets/bullet_point_paragraph.dart';
import 'package:auto_sparkle/common/widgets/drawer/custom_navigation_drawer.dart';
import 'package:auto_sparkle/common/widgets/page_section.dart';
import 'package:auto_sparkle/home-component/enums/payment_type_enum.dart';
import 'package:auto_sparkle/home-component/enums/transaction_type_enum.dart';
import 'package:auto_sparkle/home-component/models/appointment_summary_model.dart';
import 'package:auto_sparkle/home-component/models/business_feature_model.dart';
import 'package:auto_sparkle/home-component/models/carousal_item_model.dart';
import 'package:auto_sparkle/home-component/models/shop_product_summary.dart';
import 'package:auto_sparkle/home-component/models/wallet_transaction_model.dart';
import 'package:auto_sparkle/home-component/widget/appointment_summary.dart';
import 'package:auto_sparkle/home-component/widget/shop_feature_carousal.dart';
import 'package:auto_sparkle/home-component/widget/wallet_transaction.dart';
import 'package:auto_sparkle/shop-component/shop_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final String _title = 'Auto Sparkle';

  late List<CarousalItem> _carousalItems;
  late List<AppointmentSummary> _appointments;
  late List<WalletTransaction> _transactions;

  @override
  void initState() {
    super.initState();

    _carousalItems = [
      ShopProductSummary(
        name: 'Driving kit',
        image: 'assets/images/kit.jpg',
        quality: '1\tset',
        price: 594,
      ),
      BusinessFeature(
        icon: 'assets/images/home-1.png',
        name: 'Home Wash',
        description: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We wash your car in the convenience of your home. '
              'We bring all our equipment and only require:\n',
            ),
            BulletPointParagraphWidget(
              paragraph:
                  'A tap with running water\nA working electrical outlet',
            ),
          ],
        ),
      ),
      ShopProductSummary(
        name: 'God\'s Eye Camera',
        image: 'assets/images/dashcam.jpg',
        quality: '1\tpc',
        price: 7931,
      ),
      BusinessFeature(
        icon: 'assets/images/repeat.png',
        name: 'Recurring Appointments',
        description: const Text(
          'You can now make recurring appointments to suit your busy schedule.'
          '\n\nUse recurring appointments and get one free wash per month.',
        ),
      ),
    ];
    _appointments = [
      AppointmentSummary(
        name: 'Weekly Wash',
        date: '06/04/2024',
        time: '10:30',
        interval: 'Saturdays',
        location: 'Home',
        package: 'Gold',
      ),
    ];
    _transactions = const [
      WalletTransaction(
        reference: '53542',
        date: '01/04/2024',
        time: '20:06',
        description: 'Loyalty Points Transfer',
        amount: 500,
        type: TransactionType.credit,
        method: PaymentMethod.voucher,
      ),
      WalletTransaction(
        reference: '31952',
        date: '13/04/2024',
        time: '11:00',
        description: 'Payment (Gold)',
        amount: 150.00,
        type: TransactionType.debit,
        method: PaymentMethod.card,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget<HomePage>(title: _title),
      drawer: const CustomNavigationDrawer<HomePage>(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: _buildHomeScaffold(),
        ),
      ),
    );
  }

  Widget _buildHomeScaffold() {
    return Column(
      children: [
        ShopFeatureWidget(
          items: _carousalItems,
          onOrderNowPressed: () => _navigateTo<ShopPage>(const ShopPage()),
        ),
        const SizedBox(height: 14),
        PageSectionWidget(
          startExpanded: true,
          title: 'Recurring Appointments',
          child: _buildAppointments(),
        ),
        PageSectionWidget(
          startExpanded: true,
          title: 'Recent Transactions',
          child: _buildRecentTransactions(),
        ),
      ],
    );
  }

  Widget _buildAppointments() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _appointments.length,
      itemBuilder: (context, index) => AppointmentSummaryWidget(
        appointment: _appointments.elementAt(index),
        onViewAppointmentPressed: () => _navigateTo<AppointmentsPage>(
          const AppointmentsPage(),
        ),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _transactions.length,
      itemBuilder: (context, index) => WalletTransactionWidget(
        transaction: _transactions.elementAt(index),
      ),
    );
  }

  void _navigateTo<T>(
    Widget widget, {
    TransitionDirection direction = TransitionDirection.ltr,
  }) async {
    PageNavigator.navigateTo<T>(
      context,
      widget,
      direction: direction,
      useScheduler: false,
      shouldPop: false,
    );
  }
}
