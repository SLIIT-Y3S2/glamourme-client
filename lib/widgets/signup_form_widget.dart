///
/// This is the signup form widget
///

import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupFormWidget extends StatefulWidget {
  const SignupFormWidget({super.key});

  @override
  State<SignupFormWidget> createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {
  // To access the OnboardingBloc
  late AuthenticationBloc _authenticationBloc;
  // Global key that uniquely identifies the Form widget
  final _formKey = GlobalKey<FormState>();

  // to store the email entered by the user
  String _enteredEmail = '';
  // to store the password entered by the user
  String _enteredPassword = '';
  // to store the name entered by the user
  String _enteredName = '';
  // to store the user role selected by the user
  final UserRole _userRole = UserRole.customer;

  // Controllers for the input fields
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;

  //

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    _authenticationBloc.add(const GetCurrentUserEvent());

    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

// Function to handle form submission
  void _submit() {
    final isValid = _formKey.currentState!.validate();
    // Check if the form is valid
    if (!isValid) {
      return;
    }
    // Check if the controllers are not null
    if (_emailController == null ||
        _passwordController == null ||
        _nameController == null ||
        _confirmPasswordController == null) {
      return;
    }
    _formKey.currentState!.save();

    // Get the entered email, name and password
    _enteredEmail = _emailController!.text;
    _enteredPassword = _passwordController!.text;
    _enteredName = _nameController!.text;

    _authenticationBloc.add(CreateUserEvent(
      name: _enteredName,
      email: _enteredEmail,
      password: _enteredPassword,
      userRole: _userRole,
    ));
  }

  //Validator functions for email and password
  String? _emailValidate(value) {
    if (value.trim().isEmpty || value == null || !value.contains('@')) {
      return AppLocalizations.of(context)!.emailValidation;
    }

    return null;
  }

  String? _passwordValidate(value) {
    if (value.trim().isEmpty || value == null || value.length < 6) {
      return AppLocalizations.of(context)!.passwordValidation;
    }

    return null;
  }

  String? _nameValidate(value) {
    if (value.trim().isEmpty || value == null) {
      return AppLocalizations.of(context)!.nameValidation;
    }

    return null;
  }

  String? _confirmPasswordValidate(value) {
    String password = _passwordController!.text;
    String confirmPassword = _confirmPasswordController!.text;
    if (password != confirmPassword) {
      return AppLocalizations.of(context)!.passwordMatchValidation;
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose
    _emailController!.dispose();
    _passwordController!.dispose();
    _formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        if (state is CreatingUserState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!.creatingUser)));
        } else if (state is SignupErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
            duration: const Duration(milliseconds: 1500),
          ));
        } else if (state is UserCreatedState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.userCreated),
            duration: const Duration(milliseconds: 500),
          ));

          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 28),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildInputField(AppLocalizations.of(context)!.name,
                      AppLocalizations.of(context)!.nameHint),
                  const SizedBox(
                      height: 16), // Add spacing between input fields
                  _buildInputField(
                    AppLocalizations.of(context)!.email,
                    AppLocalizations.of(context)!.enterEmail,
                    isEmail: true,
                  ),
                  const SizedBox(
                      height: 16), // Add spacing between input fields
                  _buildInputField(
                    AppLocalizations.of(context)!.password,
                    '******',
                    isPassword: true,
                  ),
                  const SizedBox(
                      height: 16), // Add spacing between input fields
                  _buildInputField(
                    AppLocalizations.of(context)!.confirmPassword,
                    '******',
                    isConfirmPassword: true,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 28)),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return state is CreatingUserState
                          ? const CircularProgressIndicator()
                          : Center(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(signupScreenColor),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.signup,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            );
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildInputField(String labelText, String placeholder,
      {bool isPassword = false,
      bool isEmail = false,
      isConfirmPassword = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 2, left: 9),
          child: Text(
            labelText,
            style: const TextStyle(
              color: Color(0xFF1C1C28),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: const Color(0xFFC7C8D8)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: isPassword
                ? _passwordController
                : isConfirmPassword
                    ? _confirmPasswordController
                    : isEmail
                        ? _emailController
                        : _nameController,
            obscureText: isPassword || isConfirmPassword,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(
                color: Color(0xFF8E90A5),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
            validator: isPassword
                ? _passwordValidate
                : isConfirmPassword
                    ? _confirmPasswordValidate
                    : isEmail
                        ? _emailValidate
                        : _nameValidate,
          ),
        ),
      ],
    );
  }
}
