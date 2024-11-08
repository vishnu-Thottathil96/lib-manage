import 'package:assesment_elt/config/app_router.dart';
import 'package:assesment_elt/core/constants/app_assets.dart';
import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/constants/app_strings.dart';
import 'package:assesment_elt/core/util/custom_spacer.dart';
import 'package:flutter/material.dart';
import '../../../core/util/responsive_helper.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

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
    super.dispose();
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
                onTogglePasswordVisibility: () {
                  setState(() => _isPasswordVisible = !_isPasswordVisible);
                },
                onToggleConfirmPasswordVisibility: () {
                  setState(() =>
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
                },
                onRegisterPressed: () => AppRouter().goToLanding(context),
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
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
    required this.onRegisterPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width / 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            label: AppStrings.userName,
            focusNode: usernameFocusNode,
            obscureText: false,
            height: height,
          ),
          CustomTextField(
            label: AppStrings.password,
            focusNode: passwordFocusNode,
            obscureText: !isPasswordVisible,
            height: height,
            onVisibilityToggle: onTogglePasswordVisibility,
          ),
          CustomTextField(
            label: AppStrings.confirmpassword,
            focusNode: confirmPasswordFocusNode,
            obscureText: !isConfirmPasswordVisible,
            height: height,
            onVisibilityToggle: onToggleConfirmPasswordVisibility,
          ),
          SizedBox(height: height / 20),
          RegisterButton(onPressed: onRegisterPressed),
        ],
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
  final VoidCallback? onVisibilityToggle;

  const CustomTextField({
    required this.label,
    required this.focusNode,
    required this.obscureText,
    required this.height,
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
          style: TextStyle(
            fontSize: 18,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
