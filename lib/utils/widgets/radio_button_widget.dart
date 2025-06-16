import 'package:flutter/material.dart';

class CustomRadioWidget<T> extends StatelessWidget {
  const CustomRadioWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.width = 24,
    this.height = 24,
  });

  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          onChanged(this.value);
        },
        child: Container(
          height: this.height,
          width: this.width,
          decoration: ShapeDecoration(
            shape: CircleBorder(),
            gradient: LinearGradient(
              colors: [Color(0xFF49EF3E), Color(0xFF06D89A)],
            ),
          ),

          child: Center(
            child: Container(
              height: this.height - 8,
              width: this.width - 8,
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                gradient: LinearGradient(
                  colors:
                      value == groupValue
                          ? [Color(0xFFE13684), Color(0xFFFF6EEC)]
                          : [
                            Theme.of(context).scaffoldBackgroundColor,
                            Theme.of(context).scaffoldBackgroundColor,
                          ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
