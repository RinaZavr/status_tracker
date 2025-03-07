import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/widgets/custom_button.dart';
import 'package:status_tracker/scr/config/styles/colors.dart';
import 'package:status_tracker/scr/features/auth/view/widgets/custom_text_field.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final loginForm = GlobalKey<FormState>();

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginForm,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Логин',
            style: context.textExt.titleMiddle,
          ),
          CustomTextField(
            controller: loginController,
            hintText: 'Введите логин',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Логин только на латинице';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Пароль',
            style: context.textExt.titleMiddle,
          ),
          CustomTextField(
            controller: passwordController,
            obscureText: true,
            hintText: 'Введите пароль',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пароль обязателен';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: CustomButton(
              onPressed: () {
                if (loginForm.currentState!.validate()) {
                  log('Login: ${loginController.text}');
                  log('Password: ${passwordController.text}');
                  context.pop(loginController.text);
                }
              },
              backgroundColor: context.colorExt.buttonColor,
              child: Text(
                'Войти',
                style: context.textExt.normal
                    .copyWith(color: AppColors.raisinblacksecond),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
