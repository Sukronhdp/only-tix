import 'package:only_tix/presentation/extensions/build_context_extension.dart';
import 'package:only_tix/presentation/misc/methods.dart';
import 'package:only_tix/presentation/providers/router/router_provider.dart';
import 'package:only_tix/presentation/providers/user_data/user_data_provider.dart';
import 'package:only_tix/presentation/widgets/tix_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:only_tix/presentation/misc/constants.dart';

class LoginPage extends ConsumerStatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData) {
          if (next.value != null) {
            ref.read(routerProvider).goNamed('main');
          }
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );

    return Scaffold(
      body: ListView(
        children: [
          verticalSpace(100),
          Center(
            child: Image.asset(
              'assets/only_tix_logo.png',
              width: 150,
            ),
          ),
          verticalSpace(50),
          verticalSpace(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                TixTextField(
                  labelText: 'Email',
                  controller: emailController,
                ),
                verticalSpace(24),
                TixTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  obsecureText: true,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: brightCyan,
                      ),
                      child: const Text(
                        'Lupa password?',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    )),
                verticalSpace(24),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              ref.read(userDataProvider.notifier).login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: brightCyan,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  _ => const Center(
                      child: CircularProgressIndicator(),
                    ),
                },
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          ref.read(routerProvider).goNamed('register');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: brightCyan,
                        ),
                        child: const Text(
                          'Buat akun baru',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
