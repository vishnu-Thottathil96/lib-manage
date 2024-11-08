import 'package:assesment_elt/config/app_router.dart';
import 'package:assesment_elt/core/constants/app_assets.dart';
import 'package:assesment_elt/core/util/custom_spacer.dart';
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

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Add listeners to update UI when focus changes
    _usernameFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
    _confirmPasswordFocusNode.addListener(() {
      setState(() {});
    });
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
    double w = ResponsiveHelper.getWidth(context);
    double h = ResponsiveHelper.getHeight(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Logo Section
              Container(
                color: Colors.white,
                child: Center(
                  child: SizedBox(
                    height: h / 5,
                    width: w / 5,
                    child: Image.asset(
                      AppAssets.logoAuthPage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SpaceWidget(
                size: h / 15,
              ),
              // Form Section
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: w / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Username Label
                    Text(
                      'Username',
                      style: TextStyle(
                        color: _usernameFocusNode.hasFocus
                            ? Colors.orange
                            : Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: h / 100),

                    // Username Field
                    TextFormField(
                      focusNode: _usernameFocusNode,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h / 50),

                    // Password Label
                    Text(
                      'Password',
                      style: TextStyle(
                        color: _passwordFocusNode.hasFocus
                            ? Colors.orange
                            : Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: h / 110),

                    // Password Field
                    TextFormField(
                      focusNode: _passwordFocusNode,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: h / 50),

                    // Confirm Password Label
                    Text(
                      'Confirm Password',
                      style: TextStyle(
                        color: _confirmPasswordFocusNode.hasFocus
                            ? Colors.orange
                            : Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: h / 110),

                    // Confirm Password Field
                    TextFormField(
                      focusNode: _confirmPasswordFocusNode,
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: h / 20),

                    // Register Button
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          AppRouter().goToLanding(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
