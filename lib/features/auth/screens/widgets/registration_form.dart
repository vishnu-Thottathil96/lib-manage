import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/constants/app_strings.dart';
import 'package:assesment_elt/core/util/custom_spacer.dart';
import 'package:assesment_elt/core/util/validator_helper.dart';
import 'package:assesment_elt/features/auth/screens/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

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
  final bool isLoading; // Add the loading state

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
    required this.isLoading, // Add the isLoading parameter
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
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
                return result;
                if (value != passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              }, // Validation for password confirmation
            ),
            SizedBox(height: height / 20),
            // Stack to show loading indicator or register button
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : onRegisterPressed, // Disable button when loading
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
                ),
                if (isLoading)
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
              ],
            ),
            const SpaceWidget(size: 20),
            SizedBox(
              height: 30,
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Already registered user will be signed up insed of registration',
                  style: TextStyle(color: AppColors.textGrey, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
