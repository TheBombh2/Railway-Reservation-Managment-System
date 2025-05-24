import 'package:customer_frontend/data/model/user.dart';
import 'package:customer_frontend/data/repositories/authentication_repository.dart';
import 'package:customer_frontend/ui/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedGender;

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        authenticationRepositroy: context.read<AuthenticationRepository>(),
      ),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterCompleted) {
            context.pop();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Create Account', style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              leading: BackButton(color: Colors.black),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: state is RegisterLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _firstNameController,
                                  decoration: InputDecoration(labelText: 'First Name'),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: TextField(
                                  controller: _middleNameController,
                                  decoration: InputDecoration(labelText: 'Middle Name'),
                                ),
                              ),
                            ],
                          ),
                          TextField(
                            controller: _lastNameController,
                            decoration: InputDecoration(labelText: 'Last Name'),
                          ),
                          DropdownButtonFormField<String>(
                            value: _selectedGender,
                            decoration: InputDecoration(labelText: 'Gender'),
                            items: const [
                              DropdownMenuItem(value: 'M', child: Text('Male')),
                              DropdownMenuItem(value: 'F', child: Text('Female')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please select gender';
                              }
                              return null;
                            },
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(labelText: 'Email'),
                          ),
                          TextField(
                            controller: _phoneController,
                            decoration: InputDecoration(labelText: 'Phone Number'),
                            keyboardType: TextInputType.phone,
                          ),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0A1D56),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            onPressed: () {
                              final data = UserRegister(
                                firstName: _firstNameController.text.trim(),
                                middleName: _middleNameController.text.trim(),
                                lastName: _lastNameController.text.trim(),
                                gender: _selectedGender ?? '',
                                email: _emailController.text.trim(),
                                phoneNumber: _phoneController.text.trim(),
                                password: _passwordController.text.trim(),
                              );

                              context.read<RegisterBloc>().add(RegisterSubmitted(data));
                            },
                            child: Text('Sign Up', style: TextStyle(color: Colors.white)),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text('Already have an account? Log in'),
                          ),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
