import 'package:ecommerce_admin_app/containers/home_buttons.dart';
import 'package:ecommerce_admin_app/controllers/auth_services.dart';
import 'package:ecommerce_admin_app/views/signin.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
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
                      "Login",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                    ),
                    Text("Get started with your account"),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter Email" : null,
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
                          border: OutlineInputBorder(),
                          label: Text("Password")),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            child: Text("Forget Password"),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Forget Password"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Enter your email "),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              // validator: (value) =>
                                              //     value!.isEmpty ? "Enter Email" : null,
                                              controller: emailController,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  label: Text("Email")),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("close")),
                                          TextButton(
                                              onPressed: () {
                                                if (emailController
                                                    .text.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Enter Email")));
                                                }
                                              },
                                              child: Text("Send)"))
                                        ],
                                      ));
                            })
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    HomeButton(
                        name: "Login",
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            AuthServices()
                                .loginWithEmail(emailController.text,
                                    passwordController.text)
                                .then((onValue) => {
                                      if (onValue == "Login Succesful")
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Login Successful"))),
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
                        Text("Don't have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
                            },
                            child: Text("Register"))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
