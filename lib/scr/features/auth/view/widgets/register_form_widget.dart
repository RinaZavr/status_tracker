import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/widgets/custom_button.dart';
import 'package:status_tracker/scr/config/styles/colors.dart';
import 'package:status_tracker/scr/features/auth/view/widgets/custom_text_field.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final loginForm = GlobalKey<FormState>();

  final loginController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();
  final keyController = TextEditingController();

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
            'Email',
            style: context.textExt.titleMiddle,
          ),
          CustomTextField(
            controller: emailController,
            hintText: 'Введите email',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email обязателен';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Имя',
            style: context.textExt.titleMiddle,
          ),
          CustomTextField(
            controller: nameController,
            hintText: 'Введите имя',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Имя обязательно';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Фамилия',
            style: context.textExt.titleMiddle,
          ),
          CustomTextField(
            controller: surnameController,
            hintText: 'Введите фамилию',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Фамилия обязательна';
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
          Text(
            'Повторите пароль',
            style: context.textExt.titleMiddle,
          ),
          CustomTextField(
            controller: passwordRepeatController,
            obscureText: true,
            hintText: 'Повторите пароль',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Повторите пароль';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Ключ',
            style: context.textExt.titleMiddle,
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: keyController,
                  obscureText: true,
                  hintText: 'Введите ключ',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Неверный ключ';
                    }
                    return null;
                  },
                ),
              ),
              Tooltip(
                message:
                    'Ключ можно получить у разработчика', // Текст подсказки
                triggerMode: TooltipTriggerMode.tap,
                child: Icon(
                  CupertinoIcons.info_circle,
                  color: context.colorExt.textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: CustomButton(
              onPressed: () {
                if (loginForm.currentState!.validate()) {
                  context.pop(loginController.text);
                }
              },
              backgroundColor: context.colorExt.buttonColor,
              child: Text(
                'Зарегистрироваться',
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
