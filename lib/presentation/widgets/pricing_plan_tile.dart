import 'package:criby_payment/presentation/utils/app_theme_text_styles.dart';
import 'package:flutter/material.dart';

class PricingPlanTile extends StatelessWidget {
  final String title;
  final String price;
  final bool selected;
  final VoidCallback onTap;
  final bool isPopular;

  const PricingPlanTile({
    super.key,
    required this.title,
    required this.price,
    required this.selected,
    required this.onTap,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      selected: selected,
      selectedTileColor: const Color.fromRGBO(67, 163, 242, 0.08),

      leading: Checkbox(
        value: selected,
        onChanged: (_) => onTap(),
        activeColor: const Color(0xFF43A3F2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      title: Text(
        title,
        style: AppThemeTextStyles.bodyHeaderBold.copyWith(fontSize: 14),
      ),

      subtitle: Text(
        price,
        style: AppThemeTextStyles.bodySectionMedium.copyWith(
          fontSize: 13,
          height: 1,
          color: Colors.black.withValues(alpha: 0.6),
        ),
      ),

      trailing: isPopular
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(206, 67, 241, 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                "Most Popular",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
    );
  }
}
