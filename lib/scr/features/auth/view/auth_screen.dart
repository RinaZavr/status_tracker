import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
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
      insetPadding: EdgeInsets.zero,
      backgroundColor: context.colorExt.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
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
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height *
                        0.7, // Limit height to 70% of screen height
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: _selectedIndex == 0
                        ? const LoginFormWidget()
                        : const RegisterFormWidget(),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                context.pop();
              },
              child: const Icon(AppIcons.closeIcon),
            ),
          ],
        ),
      ),
    );
  }
}
