import 'package:criby_payment/presentation/utils/app_theme_text_styles.dart';
import 'package:criby_payment/presentation/widgets/bottom_section_auth.dart';
import 'package:criby_payment/presentation/widgets/custom_elevated_button.dart';
import 'package:criby_payment/presentation/widgets/header_logo.dart';
import 'package:criby_payment/presentation/widgets/icon_line_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obsecurePassword = true;
  bool _isChecked = false;

  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  HeaderLogo(),
                  const SizedBox(height: 60),

                  const Text(
                    "Login!",
                    style: AppThemeTextStyles.bodyHeaderBold,
                  ),
                  const SizedBox(height: 5),
                  Divider(color: Color(0xFF43A3F2), thickness: 0),
                  const SizedBox(height: 20),
                  _buildEmailFormField(),

                  const SizedBox(height: 16),

                  _buildPasswordFormField(),

                  const SizedBox(height: 10),

                  _buildRememberAndForgetSection(),
                  const SizedBox(height: 20),

                  CustomElevatedButton(
                    buttonTextName: "Login",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                  const SizedBox(height: 20),
                  BottomSectionAuth(
                    bottomSpanText: "Don't have an account? ",

                    bottomSpanClickText: "Create One",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRememberAndForgetSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
            ),
            Text(
              "Remember me",
              style: AppThemeTextStyles.bodySectionSemiBold.copyWith(
                fontSize: 14,
                height: 1,
              ),
            ),
          ],
        ),

        _buildForgetPasswordSection(),
      ],
    );
  }

  Widget _buildPasswordFormField() {
    return TextFormField(
      obscureText: _obsecurePassword,
      controller: _passwordTextEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Password",
        prefixIcon: IconLineField(textFieldIcon: Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _obsecurePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          onPressed: securePasswordVisibility,
        ),
      ),
    );
  }

  Widget _buildEmailFormField() {
    return TextFormField(
      controller: _emailTextEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Email",

        prefixIcon: IconLineField(textFieldIcon: Icons.email_outlined),
      ),
    );
  }

  Widget _buildForgetPasswordSection() {
    return TextButton(
      onPressed: () {},
      child: Text(
        "Forget password",
        style: AppThemeTextStyles.bodySectionSemiBold.copyWith(
          height: 1,
          fontSize: 14,
          color: Color(0xff43A3F2),
        ),
      ),
    );
  }

  void securePasswordVisibility() {
    setState(() {
      _obsecurePassword = !_obsecurePassword;
    });
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }
}
