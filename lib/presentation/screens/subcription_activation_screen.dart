import 'package:criby_payment/presentation/screens/dash_board_screen.dart';
import 'package:criby_payment/presentation/utils/app_assets.dart';
import 'package:criby_payment/presentation/utils/app_theme_text_styles.dart';
import 'package:criby_payment/presentation/widgets/custom_elevated_button.dart';
import 'package:criby_payment/presentation/widgets/details_card.dart';
import 'package:flutter/material.dart';

class SubcriptionActivationScreen extends StatelessWidget {
  const SubcriptionActivationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE3F2FD), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.appSubscriptionLogo,
                        height: 70,
                        width: 67,
                      ),
                      const SizedBox(height: 10),

                      const Text(
                        'Subscription Activated\nSuccessfully!',
                        textAlign: TextAlign.center,
                        style: AppThemeTextStyles.bodyHeaderBold,
                      ),
                      const SizedBox(height: 8),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text(
                          'Your Premium Plan is now active. Enjoy all exclusive features without limits.',
                          textAlign: TextAlign.center,
                          style: AppThemeTextStyles.bodySectionMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 30,
              ),
              child: _buildSubscriptionActicationCard(),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomElevatedButton(
                buttonTextName: "Go to Dashboard",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashBoardScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionActicationCard() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),

        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          children: [
            const DetailsCard(label: "Plan Name:", value: "Premium"),
            const SizedBox(height: 6),
            const DetailsCard(label: "Duration:", value: "1 Month"),
            const SizedBox(height: 6),
            const DetailsCard(label: "Amount Paid:", value: "\$29.99"),
            const SizedBox(height: 6),
            const DetailsCard(
              label: "Payment Method:",
              value: "Visa •••• 1234",
            ),
            const SizedBox(height: 6),
            const DetailsCard(
              label: "Next Billing Date:",
              value: "Oct 8, 2026",
            ),
          ],
        ),
      ),
    );
  }
}
