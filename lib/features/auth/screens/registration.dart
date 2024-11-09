import 'dart:developer';

import 'package:assesment_elt/config/app_router.dart';
import 'package:assesment_elt/core/constants/app_assets.dart';
import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/constants/app_strings.dart';
import 'package:assesment_elt/core/services/auth_service.dart';
import 'package:assesment_elt/core/services/jwtdecode_service.dart';
import 'package:assesment_elt/core/services/session_service.dart';
import 'package:assesment_elt/core/services/user_data.dart';
import 'package:assesment_elt/core/util/custom_spacer.dart';
import 'package:assesment_elt/core/util/validator_helper.dart';
import 'package:flutter/material.dart';
import '../../../core/util/responsive_helper.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>(); // Add a form key for validation

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final TextEditingController _emailController =
      TextEditingController(); // Controller for email
  final TextEditingController _usernameController =
      TextEditingController(); // Controller for username
  final TextEditingController _passwordController =
      TextEditingController(); // Controller for password
  final TextEditingController _confirmPasswordController =
      TextEditingController(); // Controller for confirm password

  // Create an instance of ApiService to use for making API calls
  final AuthService apiService = AuthService();

  @override
  void initState() {
    super.initState();
    _addFocusListeners();
  }

  void _addFocusListeners() {
    _usernameFocusNode.addListener(() => setState(() {}));
    _passwordFocusNode.addListener(() => setState(() {}));
    _confirmPasswordFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Method to handle registration and API call
  void _onRegisterPressed() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Get the username and password from the controllers
      String username = _usernameController.text;
      String password = _passwordController.text;

      // Call the register API
      final result = await apiService.registerUser(username, password);

      // Handle the result
      if (result['status'] == 'success') {
        await SecureStorageService.saveAccessToken(result['access_token']);
        await UserSessionService.saveUserSession(result['access_token']);
        // String? id =
        //     JWTDecoderService.getUserIdFromToken(result['access_token']);
        // log(id ?? 'empty');

        log(result['access_token']);

        AppRouter().goToLanding(context);
      } else {
        // Show an error message if registration failed
        _showErrorSnackbar(result['message'] ?? 'Registration failed');
      }
    }
  }

  // Show error snackbar if registration fails
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),

        behavior: SnackBarBehavior.floating, // Show it floating at the top
        margin:
            const EdgeInsets.only(top: 50.0), // Set top margin for positioning
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double w = ResponsiveHelper.getWidth(context);
    final double h = ResponsiveHelper.getHeight(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LogoSection(height: h, width: w),
              SpaceWidget(size: h / 15),
              RegistrationForm(
                width: w,
                height: h,
                isPasswordVisible: _isPasswordVisible,
                isConfirmPasswordVisible: _isConfirmPasswordVisible,
                usernameFocusNode: _usernameFocusNode,
                passwordFocusNode: _passwordFocusNode,
                confirmPasswordFocusNode: _confirmPasswordFocusNode,
                emailController: _emailController,
                usernameController: _usernameController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                formKey: _formKey, // Pass form key for validation
                onTogglePasswordVisibility: () {
                  setState(() => _isPasswordVisible = !_isPasswordVisible);
                },
                onToggleConfirmPasswordVisibility: () {
                  setState(() =>
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
                },
                onRegisterPressed: _onRegisterPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// logo section
class LogoSection extends StatelessWidget {
  final double height;
  final double width;

  const LogoSection({required this.height, required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height / 5,
        width: width / 5,
        child: Image.asset(
          AppAssets.logoAuthPage,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

// Modular registration form
class RegistrationForm extends StatelessWidget {
  final double width;
  final double height;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final FocusNode usernameFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey; // Form key for validation
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onToggleConfirmPasswordVisibility;
  final VoidCallback onRegisterPressed;

  const RegistrationForm({
    required this.width,
    required this.height,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.usernameFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
    required this.onRegisterPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      // Wrap the form with Form widget
      key: formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width / 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              label: AppStrings.userName,
              focusNode: usernameFocusNode,
              obscureText: false,
              height: height,
              controller: usernameController,
              validator: (value) =>
                  InputValidator.validateName(value), // Validation
            ),
            CustomTextField(
              label: AppStrings.password,
              focusNode: passwordFocusNode,
              obscureText: !isPasswordVisible,
              height: height,
              controller: passwordController,
              onVisibilityToggle: onTogglePasswordVisibility,
              validator: (value) =>
                  InputValidator.validatePassword(value), // Validation
            ),
            CustomTextField(
              label: AppStrings.confirmpassword,
              focusNode: confirmPasswordFocusNode,
              obscureText: !isConfirmPasswordVisible,
              height: height,
              controller: confirmPasswordController,
              onVisibilityToggle: onToggleConfirmPasswordVisibility,
              validator: (value) {
                String? result = InputValidator.validatePassword(value);
                if (result != null) return result;
                if (value != passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              }, // Validation for password confirmation
            ),
            SizedBox(height: height / 20),
            RegisterButton(onPressed: onRegisterPressed),
          ],
        ),
      ),
    );
  }
}

// Modular text field
class CustomTextField extends StatelessWidget {
  final String label;
  final FocusNode focusNode;
  final bool obscureText;
  final double height;
  final TextEditingController controller;
  final String? Function(String?)? validator; // Add validator
  final VoidCallback? onVisibilityToggle;

  const CustomTextField({
    required this.label,
    required this.focusNode,
    required this.obscureText,
    required this.height,
    required this.controller,
    this.validator,
    this.onVisibilityToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelText(label: label, isFocused: focusNode.hasFocus),
        SizedBox(height: height / 100),
        TextFormField(
          focusNode: focusNode,
          obscureText: obscureText,
          controller: controller,
          validator: validator, // Apply validator
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: AppColors.primaryOrange,
                width: 2.0,
              ),
            ),
            suffixIcon: onVisibilityToggle != null
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: onVisibilityToggle,
                  )
                : null,
          ),
        ),
        SizedBox(height: height / 50),
      ],
    );
  }
}

// Label text widget
class LabelText extends StatelessWidget {
  final String label;
  final bool isFocused;

  const LabelText({required this.label, required this.isFocused, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: isFocused ? AppColors.primaryOrange : AppColors.textGrey,
        fontSize: 16,
      ),
    );
  }
}

// Register button widget
class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          AppStrings.register,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
