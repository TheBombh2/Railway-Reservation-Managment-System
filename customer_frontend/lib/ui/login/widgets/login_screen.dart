import 'package:customer_frontend/data/repositories/authentication_repository.dart';
import 'package:customer_frontend/secrets.dart';
import 'package:customer_frontend/ui/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          authenticationRepositroy: context.read<AuthenticationRepository>()),
      child: LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.failureReason)),
              );
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.transparent],
                          ).createShader(
                            Rect.fromLTRB(0, 200, rect.width, rect.height),
                          );
                        },
                        blendMode: BlendMode.dstIn,
                        child: Image.asset(
                          'assets/images/login_image_new.jpg',
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  _EmailInput(),
                  SizedBox(
                    height: 20,
                  ),
                  _PasswordInput(),
                  SizedBox(
                    height: 29,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      
                      TextButton(
                    onPressed: () {},
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                    ],
                  ),
                  SizedBox(
                    height: 29,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: _LoginButton()),
                       
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.password.displayError,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        key: const Key("login_password_field"),
        onChanged: (value) {
          context.read<LoginBloc>().add(LoginPasswordChanged(value));
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF1F1F1),
          hintText: "Password",
          hintStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 31),
        ),
        obscureText: true,
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.email.displayError,
    );
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        //controller: TextEditingController(text: Secrets.rootManagerEmail),
        key: const Key("login_email_field"),
        onChanged: (value) {
          context.read<LoginBloc>().add(LoginEmailChanged(value));
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF1F1F1),
          hintText: "Email",
          hintStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 31),
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
        onPressed: isValid
            ? () => context.read<LoginBloc>().add(const LoginSubmitted())
            : null,
        style: FilledButton.styleFrom(
            backgroundColor: Color(0xFF0076CB),
            padding: EdgeInsetsDirectional.symmetric(
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
