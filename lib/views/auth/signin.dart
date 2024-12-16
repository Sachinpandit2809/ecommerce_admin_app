import 'package:ecommerce_admin_app/containers/home_buttons.dart';
import 'package:ecommerce_admin_app/controllers/auth_services.dart';
import 'package:ecommerce_admin_app/providers/loading_provider.dart';
import 'package:ecommerce_admin_app/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
                  Text("Create a new account and get started"),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? "Enter Email" : null,
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), label: Text("Email")),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) => value!.isEmpty || value.length < 6
                        ? "Enter password"
                        : null,
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text("Password")),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  HomeButton(
                      loading: Provider.of<LoadingProvider>(
                        context,
                      ).signInLoading,
                      name: "sign Up",
                      onPress: () {
                        Provider.of<LoadingProvider>(context, listen: false)
                            .setSignInLoading(true);
                        if (_formKey.currentState!.validate()) {
                          AuthServices()
                              .createAccountWithEmail(
                                  emailController.text, passwordController.text)
                              .then((onValue) => {
                                    Provider.of<LoadingProvider>(context,
                                            listen: false)
                                        .setSignInLoading(false),
                                    if (onValue == "Account Created")
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Colors.green,
                                                content:
                                                    Text("Account Created"))),
                                        Navigator
                                            .restorablePushNamedAndRemoveUntil(
                                                context,
                                                "/adminHome",
                                                (route) => false)
                                      }
                                    else
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            onValue,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ))
                                      }
                                  });
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text("Login"))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
