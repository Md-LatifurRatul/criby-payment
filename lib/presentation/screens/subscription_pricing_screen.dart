import 'dart:developer';

import 'package:criby_payment/data/models/network_response.dart';
import 'package:criby_payment/data/models/pricing_data.dart';
import 'package:criby_payment/data/services/network_caller.dart';
import 'package:criby_payment/data/utils/api_urls.dart';
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
  // String selectedPlan = "Diamond";

  List<PricingData> _subsCribeplan = [];
  PricingData? _selectedPlan;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPricingPlansData();
  }

  Future<void> _fetchPricingPlansData() async {
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: ApiUrls.subsCriptionPlanUrl,
    );
    if (response.isSucess && response.responseData != null) {
      final List<dynamic> planListData = response.responseData['data'] ?? [];

      _subsCribeplan = planListData
          .map((json) => PricingData.fromJson(json))
          .toList();
      if (_subsCribeplan.isNotEmpty) {
        _selectedPlan = _subsCribeplan.first;
      }
    } else {
      log("Failed to fetch the plans: ${response.errorMessage}");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
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
                      onPressed: () async {
                        final selectedPlanData = _selectedPlan;

                        if (selectedPlanData == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please select a plan first."),
                            ),
                          );
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SubcriptionActivationScreen(),
                          ),
                        );

                        // await StripePaymentWebView.openStripeCheckout(
                        //   context,
                        //   planId: selectedPlanData.id!,
                        //   planName: selectedPlanData.name ?? "Unknown Plan",
                        //   price: selectedPlanData.price ?? 0,
                        // );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildPricingPlanSection() {
    if (_subsCribeplan.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Text("No plans available."),
      );
    }

    return Column(
      children: List.generate(_subsCribeplan.length, (index) {
        final subsCribePlan = _subsCribeplan[index];

        final isSelected = _selectedPlan?.id == subsCribePlan.id;
        final isMostPopular =
            subsCribePlan.price ==
            _subsCribeplan
                .map((p) => p.price ?? 0)
                .reduce((a, b) => a > b ? a : b);

        return PricingPlanTile(
          title: subsCribePlan.name ?? "Unnamed Plan",
          price:
              "\$${subsCribePlan.price ?? 0} / ${subsCribePlan.durationDays} days",
          selected: isSelected,
          isPopular: isMostPopular,
          onTap: () => setState(() => _selectedPlan = subsCribePlan),
        );
      }),
    );
  }

  Widget _buildDetailsCard() {
    if (_selectedPlan == null) return const SizedBox.shrink();

    // final totalCharge =
    //     (_selectedPlan!.price ?? 0) + (_selectedPlan!.charge ?? 0);

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
            DetailsCard(label: "Plan Name:", value: _selectedPlan!.name ?? ''),
            const SizedBox(height: 6),
            DetailsCard(
              label: "Duration:",
              value: "${_selectedPlan!.durationDays ?? 0}Month",
            ),
            const SizedBox(height: 6),
            DetailsCard(
              label: "Amount:",
              value: "\$${_selectedPlan!.price ?? 0}",
            ),
            const SizedBox(height: 6),
            DetailsCard(
              label: "Charge:",
              value: "\$${_selectedPlan!.charge ?? 0}",
            ),
          ],
        ),
      ),
    );
  }
}
