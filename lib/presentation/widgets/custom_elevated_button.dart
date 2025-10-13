import 'package:criby_payment/presentation/utils/app_theme_text_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.buttonTextName,
    this.buttonBGColor = Colors.blue,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final String buttonTextName;
  final Color buttonBGColor;

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
        onPressed: () {
          if (_formKey.currentState!.validate()) {}
        },
        child: Text(
          buttonTextName,
          style: AppThemeTextStyles.bodyHeaderBold.copyWith(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
