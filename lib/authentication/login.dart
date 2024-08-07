import 'package:flutter/material.dart';
import 'package:project1/authentication/api_provider_auth.dart';
import 'package:project1/authentication/register.dart';

import '../models/product_model.dart';
import '../view/app_screens/home_screen.dart';
import '../view/app_screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visable = true;
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 35.0),
                  child: Text('Login to your account',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                const Text("It's great to see you again",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey)),
                const SizedBox(height: 40),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 35),
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passController,
                  obscureText: visable,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visable = !visable;
                          });
                        },
                        icon: Icon(
                            visable ? Icons.visibility : Icons.visibility_off)),
                  ),
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Forget your password?",
                        style: TextStyle(color: Colors.black)),
                    SizedBox(width: 10,),
                    Text("Reset your password",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(height: 35),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            var result = await ApiProviderAuth().userLogin(
                                userName: emailController.text,
                                password: passController.text);

                            print("Login result: $result"); // Debug print

                            if (result == "Login Success") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage(),),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(result)));
                            }
                          } catch (e) {
                            print("Exception: $e"); // Debug print
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("An error occurred")));
                          }
                        }
                      },
                      child: const Text('Login',
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300)),
                    SizedBox(width: 10,),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()));
                      },
                      child: const Text('Join',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: 17)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
