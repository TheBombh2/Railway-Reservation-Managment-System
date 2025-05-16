import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_frontend/data/repositories/authentication_repositroy.dart';
import 'package:manager_frontend/secrets.dart';
import 'package:manager_frontend/ui/core/shared_widgets/blue_button.dart';
import 'package:manager_frontend/ui/core/shared_widgets/blue_text_field.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/login/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: BlocProvider(
        create:
            (context) => LoginBloc(
              authenticationRepositroy:
                  context.read<AuthenticationRepositroy>(),
            ),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 100,
                horizontal: 80,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: primaryWhite,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 64,
                  ),
                  child: BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state.status.isFailure) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(content: Text(state.failureReason)),
                          );
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Login to access Manager Features",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: darkerBlue,
                          ),
                        ),
                        _EmailInput(),
                        _PasswordInput(),
                        _LoginButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/home_screen.jpg',
                fit: BoxFit.cover,
                width: 600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.password.displayError,
    );
    return TextField(
      key: const Key("login_password_field"),
      

      onChanged: (value) {
        context.read<LoginBloc>().add(LoginPasswordChanged(value));
      },
      decoration: InputDecoration(
        hintText: 'Password',
        errorText: displayError != null ? 'invalid password' : null,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: darkBlue),
        ),
      ),
      obscureText: true,
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.email.displayError,
    );
    return TextField(
      key: const Key("login_email_field"),
      controller: TextEditingController()..text = Secrets.rootManagerEmail,

      onChanged: (value) {
        context.read<LoginBloc>().add(LoginEmailChanged(value));
      },
      decoration: InputDecoration(
        hintText: 'Email',
        errorText: displayError != null ? 'invalid email' : null,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: darkBlue),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgressOrSucess = context.select(
      (LoginBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSucess) return const CircularProgressIndicator();

    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed:
            isValid
                ? () => context.read<LoginBloc>().add(const LoginSubmitted())
                : null,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          backgroundColor: darkBlue,
          elevation: 2,
        ),
        child: Text(
          "Log In",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
