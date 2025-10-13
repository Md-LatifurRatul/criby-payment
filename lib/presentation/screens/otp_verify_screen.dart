import 'package:criby_payment/presentation/utils/app_theme_text_styles.dart';
import 'package:criby_payment/presentation/widgets/custom_elevated_button.dart';
import 'package:criby_payment/presentation/widgets/header_logo.dart';
import 'package:flutter/material.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  HeaderLogo(),
                  const SizedBox(height: 60),

                  const Text(
                    "Verify Your Email!",
                    style: AppThemeTextStyles.bodyHeaderBold,
                  ),
                  const SizedBox(height: 10),
                  _buildOtpSentEmail(),
                  Divider(color: Color(0xFF43A3F2), thickness: 0),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(6, (index) {
                      return buildOtpField(index);
                    }),
                  ),
                  const SizedBox(height: 30),
                  CustomElevatedButton(
                    buttonTextName: "Verify Now",
                    onPressed: () {},
                  ),
                  const SizedBox(height: 15),
                  CustomElevatedButton(
                    buttonTextName: "Resend OTP",
                    buttonTextColor: Colors.black,
                    buttonBGColor: Colors.blue.withValues(alpha: 0.1),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpSentEmail() {
    return Wrap(
      children: [
        RichText(
          text: TextSpan(
            text: 'OTP sent to ',
            style: AppThemeTextStyles.bodySectionMedium,
            children: [
              TextSpan(
                text: "criby123******@gmail.com",
                style: AppThemeTextStyles.bodySectionMedium.copyWith(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildOtpField(int index) {
    return SizedBox(
      width: 45,
      height: 45,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}
