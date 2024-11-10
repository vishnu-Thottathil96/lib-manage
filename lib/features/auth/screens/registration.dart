import 'dart:developer';
import 'package:assesment_elt/config/app_router.dart';
import 'package:assesment_elt/core/services/auth_service.dart';
import 'package:assesment_elt/core/services/session_service.dart';
import 'package:assesment_elt/core/services/user_data.dart';
import 'package:assesment_elt/core/util/custom_spacer.dart';
import 'package:assesment_elt/features/auth/screens/widgets/logo_section.dart';
import 'package:assesment_elt/features/auth/screens/widgets/registration_form.dart';
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
  bool _isLoading = false; // Add this variable to track loading state
  final _formKey = GlobalKey<FormState>();

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
      setState(() {
        _isLoading = true; // Set loading state to true
      });

      String username = _usernameController.text;
      String password = _passwordController.text;

      // Call the register API
      final result = await apiService.registerUser(username, password);

      setState(() {
        _isLoading = false; // Set loading state to false after API response
      });

      if (result['status'] == 'success') {
        await SecureStorageService.saveAccessToken(result['access_token']);
        await UserSessionService.saveUserSession(result['access_token']);
        log(result['access_token']);
        AppRouter().goToLanding(context);
      } else {
        _showErrorSnackbar(result['message'] ?? 'Registration failed');
      }
    }
  }

  // Show error snackbar if registration fails
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 50.0),
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
                formKey: _formKey,
                onTogglePasswordVisibility: () {
                  setState(() => _isPasswordVisible = !_isPasswordVisible);
                },
                onToggleConfirmPasswordVisibility: () {
                  setState(() =>
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
                },
                onRegisterPressed: _onRegisterPressed,
                isLoading: _isLoading, // Pass the loading state to the form
              ),
            ],
          ),
        ),
      ),
    );
  }
}
