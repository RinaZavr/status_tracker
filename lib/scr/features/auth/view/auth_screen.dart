import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/features/auth/bloc/auth_bloc.dart';
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          spacing: 16,
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () {
                context.pop();
              },
              child: const Icon(AppIcons.closeIcon),
            ),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _selectedIndex == 0
                  ? const LoginFormWidget()
                  : const RegisterFormWidget(),
            ),
          );
        },
      ),
    );
  }
}
