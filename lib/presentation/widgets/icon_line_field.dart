import 'package:flutter/material.dart';

class IconLineField extends StatelessWidget {
  const IconLineField({super.key, required this.textFieldIcon});
  final IconData textFieldIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(textFieldIcon),
          const SizedBox(width: 8),

          Container(width: 1.2, height: 18, color: const Color(0x330C0310)),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
