import 'package:flutter/material.dart';

typedef OnRatingChangedCallback = void Function(int rating);

class RatingBarWidget extends StatelessWidget {
  final int value;
  final double size;
  final Color color;
  final Widget filledIcon;
  final Widget unfilledIcon;

  final OnRatingChangedCallback onChanged;

  const RatingBarWidget({
    super.key,
    this.value = 0,
    this.size = 40,
    this.color = Colors.blue,
    required this.onChanged,
    required this.filledIcon,
    required this.unfilledIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (rating) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: IconButton(
                  onPressed: () =>
                      onChanged(value == rating + 1 ? rating : rating + 1),
                  color: rating < value ? color : null,
                  iconSize: size,
                  icon: rating < value ? filledIcon : unfilledIcon,
                  padding: EdgeInsets.zero,
                  tooltip: "${rating + 1} of 5",
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
