import 'package:auto_sparkle/appointments-component/models/wash_history_model.dart';
import 'package:auto_sparkle/appointments-component/widgets/wash_history.dart';
import 'package:auto_sparkle/common/functions.dart';
import 'package:auto_sparkle/common/helpers/snackbar_helper.dart';
import 'package:auto_sparkle/common/navigator/page_navigator.dart';
import 'package:auto_sparkle/common/widgets/appbar.dart';
import 'package:auto_sparkle/common/widgets/form/button.dart';
import 'package:auto_sparkle/common/widgets/form/textfields.dart';
import 'package:auto_sparkle/message-component/models/message_severity_enum.dart';
import 'package:auto_sparkle/message-component/services/message_service.dart';
import 'package:auto_sparkle/rating-component/widgets/rating_bar.dart';
import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  final WashHistory history;

  const RatingWidget({
    super.key,
    required this.history,
  });

  @override
  State<StatefulWidget> createState() => _RatingWidget();
}

class _RatingWidget extends State<RatingWidget> {
  final String _title = 'Review';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late int _rating;
  String _review = '';

  @override
  void initState() {
    super.initState();

    _rating = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget<RatingWidget>(title: _title),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Functions.horizontalScreenMargin(context),
          vertical: 10,
        ),
        child: _buildRatingScaffold(),
      ),
    );
  }

  Widget _buildRatingScaffold() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildWashDetails(),
          const Spacer(),
          _buildReview(),
          const Spacer(),
          _buildRatingBar(),
          const Spacer(),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildWashDetails() {
    return WashHistoryWidget(
      history: widget.history,
      onReviewPressed: null,
    );
  }

  Widget _buildReview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _buildReviewTextField(),
        ),
        _buildVoiceNoteButton(),
      ],
    );
  }

  Widget _buildReviewTextField() {
    return TextFieldWidget(
      label: 'Review',
      text: '',
      maxLines: 3,
      inputAction: TextInputAction.next,
      validator: (value) => null,
      onChanged: (value) => _review = value.trim(),
    );
  }

  Widget _buildVoiceNoteButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: FloatingActionButton(
        heroTag: 'rating-fab',
        child: const Icon(
          Icons.mic,
          color: Colors.white,
        ),
        onPressed: () => SnackbarHelper.showComingSoon(context, 'Voice notes'),
      ),
    );
  }

  Widget _buildRatingBar() {
    return StatefulBuilder(
      builder: (context, setState) => RatingBarWidget(
        value: _rating,
        color: Colors.yellow[700]!,
        filledIcon: const ImageIcon(
          ResizeImage(
            AssetImage('assets/images/wash.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
        ),
        unfilledIcon: const ImageIcon(
          ResizeImage(
            AssetImage('assets/images/wash-empty.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
        ),
        onChanged: (rating) => _onRatingChanged(rating, setState),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Row(
      children: [
        Expanded(
          child: FormButtonWidget(
            text: 'Submit',
            onClicked: _onSubmitPressed,
          ),
        ),
      ],
    );
  }

  void _onRatingChanged(int rating, StateSetter setState) {
    setState(() => _rating = rating);
  }

  Future<void> _onSubmitPressed() async {
    final WashHistory wash = widget.history;
    await MessageService().saveMessageAsync(
      'Thanks for your review',
      'You rated your ${wash.name} on ${wash.date} $_rating out of 5.'
          '${_review.isEmpty ? '' : '\n\n"$_review"'}',
      MessageSeverity.information,
    );

    if (!mounted) return;
    SnackbarHelper.show(
      context,
      'Thanks for your review!',
      icon: Icons.check_circle_outline,
    );
    PageNavigator.navigateBack<RatingWidget>(context);
  }
}
