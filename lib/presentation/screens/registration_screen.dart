import 'package:criby_payment/presentation/screens/login_screen.dart';
import 'package:criby_payment/presentation/utils/app_theme_text_styles.dart';
import 'package:criby_payment/presentation/widgets/bottom_section_auth.dart';
import 'package:criby_payment/presentation/widgets/custom_elevated_button.dart';
import 'package:criby_payment/presentation/widgets/header_logo.dart';
import 'package:criby_payment/presentation/widgets/icon_line_field.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _fullNameTextEditingController =
      TextEditingController();

  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();

  final TextEditingController _confirmPasswordTextEditingController =
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
                    "Create Account!",
                    style: AppThemeTextStyles.bodyHeaderBold,
                  ),
                  const SizedBox(height: 5),
                  Divider(color: Color(0xFF43A3F2), thickness: 0),
                  const SizedBox(height: 20),
                  _buildFullNameFormField(),
                  const SizedBox(height: 16),
                  _buildPhoneFormField(),
                  const SizedBox(height: 16),
                  _buildEmailFormField(),
                  const SizedBox(height: 16),

                  _buildPasswordFormField(),

                  const SizedBox(height: 16),

                  _buildConfirmPasswordFormField(),

                  const SizedBox(height: 20),

                  CustomElevatedButton(
                    buttonTextName: "Login",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                  const SizedBox(height: 20),
                  BottomSectionAuth(
                    bottomSpanText: "Already have an account? ",

                    bottomSpanClickText: "Next",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullNameFormField() {
    return TextFormField(
      controller: _fullNameTextEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your full name';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Full Name",
        prefixIcon: IconLineField(textFieldIcon: Icons.person),
      ),
    );
  }

  Widget _buildPhoneFormField() {
    return TextFormField(
      controller: _phoneTextEditingController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Phone No",
        prefixIcon: IconLineField(textFieldIcon: Icons.phone_outlined),
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

  Widget _buildPasswordFormField() {
    return TextFormField(
      controller: _passwordTextEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Password",
        prefixIcon: IconLineField(textFieldIcon: Icons.lock_outline),
      ),
    );
  }

  Widget _buildConfirmPasswordFormField() {
    return TextFormField(
      controller: _confirmPasswordTextEditingController,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != _passwordTextEditingController.text) {
          return "Please match the password";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Confirm Password",

        prefixIcon: IconLineField(textFieldIcon: Icons.lock_outline),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _phoneTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    super.dispose();
  }
}
