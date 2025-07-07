import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/utils/app_images.dart';
import 'package:untitled/features/eco_zone/presentation/cubit/logics_cubit.dart';
import 'package:untitled/features/eco_zone/presentation/widgets/text_field.dart';
import 'package:untitled/routing/app_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isVisible = true;
  bool isVisibleConfirm = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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

        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: 10,
                child: InkWell(
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  onTap: () {
                    GoRouter.of(context).pop();
                  },
                ),
              ),
              Center(
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
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 20,
                          ),
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
                            if (state is SignUpLoading) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                            }

                            if (state is SignUpSuccess) {
                              Navigator.pop(context);
                              Fluttertoast.showToast(msg: state.message);
                              GoRouter.of(context).go(AppRouter.dashboard);
                            }

                            if (state is SignUpFailure) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error)),
                              );
                            }
                          },
                          builder: (context, state) {
                            return Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  buildTextField(
                                    controller: _usernameController,
                                    label: 'Username',
                                    context: context,
                                    obscureText: false,
                                  ),
                                  SizedBox(height: 10),

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

                                  SizedBox(height: 10),
                                  buildTextField(
                                    controller: _confirmPasswordController,
                                    label: 'Confirm Password',
                                    obscureText: isVisibleConfirm,
                                    context: context,
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isVisibleConfirm = !isVisibleConfirm;
                                        });
                                      },
                                      child: Icon(
                                        isVisibleConfirm
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
                                      } else if (_passwordController.text !=
                                          _confirmPasswordController.text) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Passwords do not match',
                                            ),
                                          ),
                                        );
                                      } else {
                                        BlocProvider.of<LogicsCubit>(
                                          context,
                                        ).register(
                                          _usernameController.text,
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
                                      'Sign Up',
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
                            GoRouter.of(context).pushNamed(AppRouter.login);
                          },
                          child: Text(
                            'Already have an account? Login',

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
