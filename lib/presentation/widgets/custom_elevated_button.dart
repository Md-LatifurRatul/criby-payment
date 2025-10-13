import 'package:criby_payment/presentation/utils/app_theme_text_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.buttonTextName,
    this.buttonBGColor = Colors.blue,
    this.buttonColor = Colors.white,
    this.onPressed,
  });

  final String buttonTextName;
  final Color buttonBGColor;
  final Color buttonColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonBGColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonTextName,
          style: AppThemeTextStyles.bodyHeaderBold.copyWith(
            fontSize: 16,
            color: buttonColor,
          ),
        ),
      ),
    );
  }
}
