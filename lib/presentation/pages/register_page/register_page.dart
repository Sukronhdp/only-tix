import 'dart:io';

import 'package:only_tix/presentation/extensions/build_context_extension.dart';
import 'package:only_tix/presentation/misc/methods.dart';
import 'package:only_tix/presentation/providers/router/router_provider.dart';
import 'package:only_tix/presentation/providers/user_data/user_data_provider.dart';
import 'package:only_tix/presentation/widgets/tix_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:only_tix/presentation/misc/constants.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();

  XFile? xfile;

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          ref
              .read(routerProvider)
              .goNamed('main', extra: xfile != null ? File(xfile!.path) : null);
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              verticalSpace(50),
              Center(
                child: Image.asset(
                  'assets/only_tix_logo.png',
                  width: 150,
                ),
              ),
              verticalSpace(50),
              GestureDetector(
                onTap: () async {
                  xfile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  setState(() {});
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      xfile != null ? FileImage(File(xfile!.path)) : null,
                  child: xfile != null
                      ? null
                      : const Icon(
                          Icons.add_a_photo,
                          size: 50,
                        ),
                ),
              ),
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
                      labelText: 'Name',
                      controller: nameController,
                    ),
                    verticalSpace(24),
                    TixTextField(
                      labelText: 'Password',
                      controller: passwordController,
                      obsecureText: true,
                    ),
                    verticalSpace(24),
                    TixTextField(
                      labelText: 'Retype Password',
                      controller: retypePasswordController,
                      obsecureText: true,
                    ),
                    verticalSpace(24),
                    switch (ref.watch(userDataProvider)) {
                      AsyncData(:final value) => value == null
                          ? SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: brightCyan,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () {
                                  if (passwordController.text ==
                                      retypePasswordController.text) {
                                    ref
                                        .read(userDataProvider.notifier)
                                        .register(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text);
                                  } else {
                                    context.showSnackBar(
                                        'Your password is not match');
                                  }
                                },
                                child: const Text(
                                  'Buat Akun',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                      _ => const Center(
                          child: CircularProgressIndicator(),
                        )
                    },
                    verticalSpace(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Sudah punya akun?'),
                        TextButton(
                            onPressed: () {
                              ref.read(routerProvider).goNamed('login');
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: brightCyan,
                            ),
                            child: const Text(
                              'Login di sini',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                    verticalSpace(24),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
