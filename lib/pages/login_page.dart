import 'package:flutter/material.dart';
import 'package:minimal_chat_app/components/widgets/widgets.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';
import 'package:minimal_chat_app/components/custom_button.dart';
import 'package:minimal_chat_app/components/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    } catch (error) {
      showSnackBar(context, Colors.red, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(
            height: 50,
          ),
          // welcome back message
          Text(
            "Welcome back, you,ve been missed!",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 16),
          ),

          const SizedBox(
            height: 25,
          ),

          // textfields
          CustomTextFiled(
            hintText: "Email",
            obscureText: false,
            controller: _emailController,
          ),

          const SizedBox(
            height: 10,
          ),

          CustomTextFiled(
            hintText: "Password",
            obscureText: true,
            controller: _passwordController,
          ),

          const SizedBox(
            height: 25,
          ),

          // login button

          CustomButton(
            text: "Login",
            onTap: () => login(context),
          ),

          const SizedBox(
            height: 25,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Register here",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          // register now
        ],
      )),
    );
  }
}
