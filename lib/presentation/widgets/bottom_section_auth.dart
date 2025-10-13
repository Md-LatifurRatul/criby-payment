import 'package:criby_payment/presentation/utils/app_theme_text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BottomSectionAuth extends StatelessWidget {
  const BottomSectionAuth({
    super.key,
    required this.bottomSpanText,
    required this.bottomSpanClickText,
  });
  final String bottomSpanText;
  final String bottomSpanClickText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: bottomSpanText,
          style: AppThemeTextStyles.bodySectionSemiBold,
          children: [
            TextSpan(
              text: bottomSpanClickText,
              style: AppThemeTextStyles.bodySectionSemiBold.copyWith(
                color: Color(0xff43A3F2),
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
          ],
        ),
      ),
    );
  }
}
