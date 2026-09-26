import 'package:auto_sparkle/common/constants.dart';
import 'package:auto_sparkle/common/helpers/color_helper.dart';
import 'package:auto_sparkle/message-component/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageHeaderWidget extends StatefulWidget {
  final int messageId;
  final String heading;
  final bool hasBeenRead;
  final void Function(bool isExpanded) onExpandMessagePressed;

  const MessageHeaderWidget({
    super.key,
    required this.messageId,
    required this.hasBeenRead,
    required this.heading,
    required this.onExpandMessagePressed,
  });

  @override
  State<MessageHeaderWidget> createState() => _MessageHeaderWidgetState();
}

class _MessageHeaderWidgetState extends State<MessageHeaderWidget> {
  late bool _isExpanded;
  late bool _hasBeenRead;

  @override
  void initState() {
    super.initState();

    _isExpanded = false;
    _hasBeenRead = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.light
          ? ColorHelper.lighten(Theme.of(context).colorScheme.secondary, 70)
          : Theme.of(context).colorScheme.secondary.withValues(alpha: 0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildText(),
          _buildExpander(),
        ],
      ),
    );
  }

  Widget _buildText() {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 4, 0, 4),
        child: Text(
          widget.heading,
          style: Theme.of(context).textTheme.titleMedium?.merge(
                const TextStyle(fontFamily: FontFamily.PRIMARY),
              ),
        ),
      ),
    );
  }

  Widget _buildExpander() {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 5),
      child: GestureDetector(
        key: UniqueKey(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: Consumer<MessageService>(
            builder: (context, service, child) => FutureBuilder(
              future: service.getMessageReadStatus(widget.messageId),
              builder: (context, snapshot) => Icon(
                _isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
                color: (snapshot.hasData ? snapshot.data! : _hasBeenRead)
                    ? Theme.of(context).iconTheme.color
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        onTap: () => _onExpandMessagePressed(),
      ),
    );
  }

  void _onExpandMessagePressed() {
    _isExpanded = !_isExpanded;
    widget.onExpandMessagePressed(_isExpanded);
    if (!_hasBeenRead) _hasBeenRead = !_hasBeenRead;
    setState(() {});
  }
}
