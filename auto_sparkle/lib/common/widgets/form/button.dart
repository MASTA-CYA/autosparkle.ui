import 'package:flutter/material.dart';
import 'package:auto_sparkle/common/constants.dart';

class FormButtonWidget extends StatelessWidget {
  final String text;
  final bool? isPrimary;
  final double? width;
  final VoidCallback? onClicked;

  const FormButtonWidget({
    super.key,
    required this.text,
    this.isPrimary = true,
    this.width,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary!
            ? Theme.of(context)
                .elevatedButtonTheme
                .style
                ?.backgroundColor
                ?.resolve({WidgetState.pressed})
            : Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        foregroundColor:
            isPrimary! ? Colors.white : Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width ?? 32,
          vertical: 12,
        ),
      ),
      onPressed: onClicked,
      child: Container(
        margin: const EdgeInsets.only(top: 3),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: FontFamily.PRIMARY,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
