import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/features/auth/view/widgets/login_form_widget.dart';
import 'package:status_tracker/scr/features/auth/view/widgets/register_form_widget.dart';
import 'package:status_tracker/scr/features/auth/view/widgets/tab_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.colorExt.backgroundColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabWidget(
                    isSelected: _selectedIndex == 0,
                    title: 'Вход',
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                  ),
                  TabWidget(
                    isSelected: _selectedIndex == 1,
                    title: 'Регистрация',
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                  ),
                ],
              ),
              if (_selectedIndex == 0)
                const LoginFormWidget()
              else
                const RegisterFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
