import 'package:criby_payment/data/models/network_response.dart';
import 'package:criby_payment/data/services/network_caller.dart';
import 'package:criby_payment/data/utils/api_urls.dart';
import 'package:criby_payment/presentation/screens/login_screen.dart';
import 'package:criby_payment/presentation/utils/app_theme_text_styles.dart';
import 'package:criby_payment/presentation/widgets/custom_elevated_button.dart';
import 'package:criby_payment/presentation/widgets/header_logo.dart';
import 'package:criby_payment/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key, required this.userVerifyEmail});
  final String userVerifyEmail;

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool _isOtpVerificationInProgress = false;
  bool _isOtpResend = false;

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
                  Visibility(
                    visible: _isOtpVerificationInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: CustomElevatedButton(
                      buttonTextName: "Verify Now",
                      onPressed: () {
                        verifyOtp();
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Visibility(
                    visible: _isOtpResend == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: CustomElevatedButton(
                      buttonTextName: "Resend OTP",
                      buttonTextColor: Colors.black,
                      buttonBGColor: Colors.blue.withValues(alpha: 0.1),
                      onPressed: () {
                        otpResend();
                      },
                    ),
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
                text: widget.userVerifyEmail,
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

  Future<void> verifyOtp() async {
    String otpInput = _controllers.map((controller) => controller.text).join();

    if (otpInput.length != 6) {
      SnackMessage.showSnackBarMessage(
        context,
        "Please enter the 6-digin Otp!",
        true,
      );
      return;
    }

    _isOtpVerificationInProgress = true;
    setState(() {});

    Map<String, dynamic> inputVerify = {
      "email": widget.userVerifyEmail,

      "otp": otpInput,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: ApiUrls.verifyOtpUrl,
      body: inputVerify,
    );

    _isOtpVerificationInProgress = false;
    setState(() {});

    if (response.isSucess) {
      if (mounted) {
        SnackMessage.showSnackBarMessage(context, "Otp Verified/Please Login");

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        SnackMessage.showSnackBarMessage(
          context,
          "Otp didn't match/try again!",
          true,
        );
      }
    }
  }

  Future<void> otpResend() async {
    _isOtpResend = true;
    setState(() {});

    Map<String, dynamic> inputEmail = {"email": widget.userVerifyEmail};

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: ApiUrls.otpResendUrl,
      body: inputEmail,
    );

    _isOtpResend = false;
    setState(() {});

    if (response.isSucess) {
      if (mounted) {
        SnackMessage.showSnackBarMessage(context, "Otp resend to your email");
      }
    } else {
      if (mounted) {
        SnackMessage.showSnackBarMessage(context, "Otp Send Failed!", true);
      }
    }
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
