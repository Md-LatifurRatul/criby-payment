import 'package:criby_payment/presentation/screens/subcription_activation_screen.dart';
import 'package:criby_payment/presentation/utils/app_theme_text_styles.dart';
import 'package:criby_payment/presentation/widgets/custom_elevated_button.dart';
import 'package:criby_payment/presentation/widgets/details_card.dart';
import 'package:criby_payment/presentation/widgets/pricing_plan_tile.dart';
import 'package:flutter/material.dart';

class SubscriptionPricingScreen extends StatefulWidget {
  const SubscriptionPricingScreen({super.key});

  @override
  State<SubscriptionPricingScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionPricingScreen> {
  String selectedPlan = "Diamond";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Column(
                  children: [
                    Text(
                      "Pricing",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0C0310),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Get unlimited\naccess to all features",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0x800C0310),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(67, 163, 241, 0.04),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0x330C0310),
                    width: 1.5,
                  ),
                ),
                child: _buildPricingPlanSection(),
              ),

              const SizedBox(height: 30),

              Text(
                "Details",
                style: AppThemeTextStyles.bodySectionMedium.copyWith(
                  fontSize: 13,
                  height: 1,
                  color: Colors.black.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 12),

              _buildDetailsCard(),

              const SizedBox(height: 30),
              CustomElevatedButton(
                buttonTextName: "Pay Now",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubcriptionActivationScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPricingPlanSection() {
    return Column(
      children: [
        PricingPlanTile(
          title: "Gold Plan",
          price: "\$10.99 / month",
          selected: selectedPlan == "Gold",
          onTap: () => setState(() => selectedPlan = "Gold"),
        ),
        PricingPlanTile(
          title: "Diamond Plan",
          price: "\$100.99 / month",
          selected: selectedPlan == "Diamond",
          isPopular: true,
          onTap: () => setState(() => selectedPlan = "Diamond"),
        ),
        PricingPlanTile(
          title: "Basic Plan",
          price: "\$4.99 / month",
          selected: selectedPlan == "Basic",
          onTap: () => setState(() => selectedPlan = "Basic"),
        ),
      ],
    );
  }

  Widget _buildDetailsCard() {
    return Card(
      elevation: 0,
      color: const Color(0x0D43A3F2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0x1A0C0310)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          children: [
            DetailsCard(label: "Plan Name:", value: "Premium"),
            const SizedBox(height: 6),
            DetailsCard(label: "Duration:", value: "1 Month"),
            const SizedBox(height: 6),
            DetailsCard(label: "Amount:", value: "\$29.99"),
            const SizedBox(height: 6),
            DetailsCard(label: "Charge:", value: "\$10"),
          ],
        ),
      ),
    );
  }
}
