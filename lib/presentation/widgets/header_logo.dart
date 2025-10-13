import 'package:criby_payment/presentation/utils/app_assets.dart';
import 'package:criby_payment/presentation/utils/app_theme_text_styles.dart';
import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.appHeaderLogo, height: 24, width: 24),
          const SizedBox(width: 6),
          const Text("Criby", style: AppThemeTextStyles.appHeaderSection),
        ],
      ),
    );
  }
}
