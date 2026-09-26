import 'package:auto_sparkle/appointments-component/enums/wash_status_enum.dart';
import 'package:auto_sparkle/appointments-component/models/wash_history_model.dart';
import 'package:auto_sparkle/appointments-component/widgets/appointment.dart';
import 'package:auto_sparkle/appointments-component/widgets/upcoming_appointment.dart';
import 'package:auto_sparkle/appointments-component/widgets/wash_history.dart';
import 'package:auto_sparkle/common/helpers/snackbar_helper.dart';
import 'package:auto_sparkle/common/navigator/page_navigator.dart';
import 'package:auto_sparkle/common/navigator/transition_direction_enum.dart';
import 'package:auto_sparkle/common/widgets/appbar.dart';
import 'package:auto_sparkle/common/widgets/drawer/custom_navigation_drawer.dart';
import 'package:auto_sparkle/common/widgets/page_section.dart';
import 'package:auto_sparkle/home-component/models/appointment_summary_model.dart';
import 'package:auto_sparkle/message-component/models/message_severity_enum.dart';
import 'package:auto_sparkle/message-component/services/message_service.dart';
import 'package:auto_sparkle/rating-component/rating_view.dart';
import 'package:flutter/material.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<StatefulWidget> createState() => _AppointmentsPage();
}

class _AppointmentsPage extends State<AppointmentsPage> {
  final String _title = 'Appointments';

  late List<WashHistory> _history;
  late List<AppointmentSummary> _appointments;

  @override
  void initState() {
    super.initState();

    _appointments = [
      AppointmentSummary(
        name: 'Weekly Wash',
        date: '20/04/2024',
        time: '10:30',
        interval: 'Saturdays',
        location: 'Home',
        package: 'Gold',
      ),
    ];

    _history = [
      WashHistory(
        name: 'Weekly Wash',
        date: '13/04/2024',
        time: '10:30',
        location: 'Home',
        package: 'Gold',
        status: WashStatus.paid,
      ),
      WashHistory(
        name: 'Weekly Wash',
        date: '06/04/2024',
        time: '10:30',
        location: 'Home',
        package: 'Gold',
        status: WashStatus.cancelled,
      ),
      WashHistory(
        name: 'Weekly Wash',
        date: '30/03/2024',
        time: '10:30',
        location: 'Home',
        package: 'Gold',
        status: WashStatus.pending,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget<AppointmentsPage>(title: _title),
      drawer: const CustomNavigationDrawer<AppointmentsPage>(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: _buildAppointmentsScaffold(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openBooking(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildAppointmentsScaffold() {
    return Column(
      children: [
        PageSectionWidget(
          startExpanded: true,
          title: 'Upcoming Appointment',
          child: _buildAppointments(),
        ),
        PageSectionWidget(
          startExpanded: true,
          title: 'Wash History',
          child: _buildWashHistory(),
        ),
      ],
    );
  }

  Widget _buildAppointments() {
    if (_appointments.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text('No upcoming appointments. Tap + to book a wash.'),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _appointments.length,
      itemBuilder: (context, index) => UpcomingAppointmentWidget(
        appointment: _appointments.elementAt(index),
        onCancelPressed: () =>
            _onCancelAppointmentPressed(_appointments.elementAt(index)),
        onEditPressed: () => _openBooking(),
      ),
    );
  }

  Widget _buildWashHistory() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _history.length,
      itemBuilder: (context, index) => WashHistoryWidget(
        history: _history.elementAt(index),
        onReviewPressed: () => _navigateTo<RatingWidget>(
          RatingWidget(
            history: _history.elementAt(index),
          ),
        ),
      ),
    );
  }

  void _openBooking() {
    PageNavigator.navigateTo<AppointmentWidget>(
      context,
      const AppointmentWidget(),
      useScheduler: false,
    );
  }

  Future<void> _onCancelAppointmentPressed(
    AppointmentSummary appointment,
  ) async {
    final bool shouldCancel = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Cancel appointment?'),
            content: Text(
              'Your ${appointment.name} on ${appointment.date} at '
              '${appointment.time} will be cancelled.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Keep it'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Cancel appointment',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;

    if (!shouldCancel || !mounted) return;

    setState(() => _appointments.remove(appointment));
    SnackbarHelper.show(context, 'Appointment cancelled');

    await MessageService().saveMessageAsync(
      'Appointment cancelled',
      'Your ${appointment.name} on ${appointment.date} at '
          '${appointment.time} has been cancelled.',
      MessageSeverity.information,
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
    );
  }
}
