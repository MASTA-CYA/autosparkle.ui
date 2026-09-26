import 'package:flutter/material.dart';
import 'package:auto_sparkle/common/constants.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final int maxLines;
  final String? Function(String?) validator;
  final String label;
  final String text;
  final TextInputAction? inputAction;
  final void Function(String)? onChanged;

  const TextFieldWidget({
    super.key,
    this.controller,
    this.maxLines = 1,
    required this.validator,
    required this.label,
    required this.text,
    this.inputAction = TextInputAction.done,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    // Only dispose controllers this widget created.
    if (widget.controller == null) controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          textInputAction: widget.inputAction,
          autocorrect: true,
          decoration: InputDecoration(
            isDense: true,
            labelText: widget.label,
            labelStyle: Theme.of(context).textTheme.bodyLarge?.merge(
                  const TextStyle(
                    fontFamily: FontFamily.PRIMARY,
                  ),
                ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          validator: widget.validator,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
