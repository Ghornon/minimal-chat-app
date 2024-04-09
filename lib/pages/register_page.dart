import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';
import 'package:minimal_chat_app/components/custom_button.dart';
import 'package:minimal_chat_app/components/custom_textfield.dart';

import '../components/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypeController = TextEditingController();
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) {
    final authService = AuthService();

    if (formKey.currentState!.validate()) {
      try {
        authService.signUpWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
      } catch (error) {
        showSnackBar(context, Colors.red, error.toString());
      }
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
          // welcome back message
          Text(
            "Create an new account!",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 16),
          ),

          const SizedBox(
            height: 25,
          ),
          // logo
          Image.asset("undraw_sign_up_ln1s.png"),

          const SizedBox(
            height: 25,
          ),

          // textfields
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFiled(
                  hintText: "Email",
                  obscureText: false,
                  controller: _emailController,
                  validator: (value) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)
                        ? null
                        : "Enter valid email";
                  },
                ),

                const SizedBox(
                  height: 10,
                ),

                CustomTextFiled(
                  hintText: "Password",
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.length < 6) {
                      return "Password must be at least 6 characters";
                    }

                    return null;
                  },
                ),

                const SizedBox(
                  height: 10,
                ),

                CustomTextFiled(
                  hintText: "Retype password",
                  obscureText: true,
                  controller: _retypeController,
                  validator: (value) {
                    if (value!.length < 6) {
                      return "Password must be at least 6 characters";
                    }

                    if (value != _passwordController.text) {
                      return "The passwords does not match!";
                    }

                    return null;
                  },
                ),

                const SizedBox(
                  height: 25,
                ),

                // login button

                CustomButton(
                  text: "Sign up",
                  onTap: () => register(context),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          Center(
            child: Text.rich(
              TextSpan(
                text: "Already have an account? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Sign in now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onTap,
                  )
                ],
              ),
            ),
          ),
          // register now
        ],
      )),
    );
  }
}
