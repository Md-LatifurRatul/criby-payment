import 'dart:convert';
import 'dart:developer';

import 'package:criby_payment/data/services/network_caller.dart';
import 'package:criby_payment/data/utils/api_urls.dart';
import 'package:criby_payment/presentation/screens/subcription_activation_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StripePaymentWebView {
  static const String stripeSecretKey =
      "sk_test_51Rk13ECX7cWtiM720I0jg1qqWcpFTPzkVI0vhZqpOd8M6re5yMIVKMy5IaaY06EW7ppVIRP1JwZ6VvOMreEdItip00lv8TBTdW";
  static const String stripePublishableKey =
      "pk_test_51Rk13ECX7cWtiM72ZRVZCH3zV5j1lFpqCFQGLKm1cdLlbRlG9Qrc1oOVuew5hcgw0Sf1iCMaFzEOdn4STjvNBnhq00PLqyQ8Za";
  static const String successUrl = "https://yourapp.com/stripe-success";
  static const String cancelUrl = "https://yourapp.com/stripe-cancel";

  static Future<String?> createCheckoutSession({
    required String planName,
    required int amount,
  }) async {
    try {
      final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $stripeSecretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "mode": "payment",
          "success_url": successUrl,
          "cancel_url": cancelUrl,
          "line_items[0][price_data][currency]": "usd",
          "line_items[0][price_data][product_data][name]": planName,
          "line_items[0][price_data][unit_amount]": (amount * 100).toString(),
          "line_items[0][quantity]": "1",
        },
      );

      log("Stripe Session Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["url"];
      } else {
        log("Stripe error: ${response.body}");
        return null;
      }
    } catch (e) {
      log("Stripe error: $e");
      return null;
    }
  }

  static Future<void> openStripeCheckout(
    BuildContext context, {
    required int planId,
    required String planName,
    required int price,
  }) async {
    final checkoutUrl = await createCheckoutSession(
      planName: planName,
      amount: price,
    );

    if (checkoutUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to start payment session.")),
      );
      return;
    }

    if (await canLaunchUrl(Uri.parse(checkoutUrl))) {
      await launchUrl(
        Uri.parse(checkoutUrl),
        mode: LaunchMode.externalApplication,
      );
      await _confirmSubscription(context, planId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot open payment page.")),
      );
    }
  }

  static Future<void> _confirmSubscription(
    BuildContext context,
    int planId,
  ) async {
    final resp = await NetworkCaller.postRequest(
      url: ApiUrls.planSubscribeUrl,
      body: {"plan_id": planId},
    );

    if (resp.isSucess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SubcriptionActivationScreen(
            selectedPlan: _selectedPlanData!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Subscription failed. Try again.")),
      );
    }
  }
}
