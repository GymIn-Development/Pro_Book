import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pro_book/services/auth_service.dart';
import 'package:pro_book/widgets/rounded_text_field.dart';

class SignupPage extends HookWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _emailController = useTextEditingController();
    final _passwordController = useTextEditingController();
    final isLoading = useState(false);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: isLoading.value == true
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                width: size.width,
                height: size.height,
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Email",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    RoundedTextField(
                                      controller: _emailController,
                                      hintText: 'Your Email',
                                      secureIt: false,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Password",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    RoundedTextField(
                                      controller: _passwordController,
                                      hintText: 'Create a Password',
                                      secureIt: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    bottom: 30,
                                    top: 10,
                                  ),
                                  height: 55,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    color: Colors.red,
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        // ignore: use_full_hex_values_for_flutter_colors
                                        Color(0xff1EE1D72),
                                        Color(0xffF14C37),
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.lock_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Sign up Securely',
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () async {
                                  isLoading.value = true;
                                  await context
                                      .read(authServiceProvider)
                                      .signUpWithEmail(
                                          _emailController.text.trim(),
                                          _passwordController.text.trim(),
                                          context);
                                  isLoading.value = false;
                                  Navigator.pop(context);
                                }),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account?",
                                  style: TextStyle(color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Log In",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
