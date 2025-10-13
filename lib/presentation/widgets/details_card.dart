import 'package:criby_payment/presentation/utils/app_theme_text_styles.dart';
import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  final String label;
  final String value;

  const DetailsCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppThemeTextStyles.bodySectionSemiBold.copyWith(
              color: Colors.black,
              fontSize: 14,
              height: 1,
            ),
          ),
          Text(
            value,
            style: AppThemeTextStyles.bodySectionMedium.copyWith(
              color: Colors.black.withValues(alpha: 0.6),
              fontSize: 14,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
