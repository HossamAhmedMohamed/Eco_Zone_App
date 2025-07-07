import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/utils/app_images.dart';
import 'package:untitled/features/eco_zone/presentation/cubit/logics_cubit.dart';
import 'package:untitled/features/eco_zone/presentation/widgets/text_field.dart';
import 'package:untitled/routing/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isVisible = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final bottominset = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.imagesEco),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // alignment: Alignment.center,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFF0D98BA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'ECO ZONE',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  BlocConsumer<LogicsCubit, LogicsState>(
                    listener: (context, state) {
                      if (state is LoginLoading) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(child: CircularProgressIndicator());
                          },
                        );
                      }

                      if (state is LoginSuccess) {
                        Navigator.pop(context);

                        // Close the loading dialog
                        Fluttertoast.showToast(msg: state.message);
                        GoRouter.of(context).go(AppRouter.dashboard);
                      }

                      if (state is LoginFailure) {
                        Navigator.pop(context); // Close the loading dialog
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    builder: (context, state) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            buildTextField(
                              controller: _emailController,
                              label: 'Email',
                              context: context,
                              obscureText: false,
                            ),
                            SizedBox(height: 10),
                            buildTextField(
                              controller: _passwordController,
                              label: 'Password',
                              obscureText: isVisible,
                              context: context,
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: Icon(
                                  isVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                } else {
                                  log(  'Login button pressed');
                                  BlocProvider.of<LogicsCubit>(context).login(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 80,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: Color(0xFF0D98BA),
                              ),

                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed(AppRouter.signup);
                    },
                    child: Text(
                      'Don\'t have an account? Sign up',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: bottominset),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
