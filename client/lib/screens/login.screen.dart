import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:app_flutter/services/user.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Save_token_preferences(token) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save an String value to 'action' key.
    await prefs.setString('token', token);
  }

  @override
  Widget build(BuildContext context) {
    String name = "";
    String password = "";
    final TextEditingController emailController =
        TextEditingController(); //TextEditingController se modifica segun lo que se agregue o cambie el textField
    final TextEditingController passwordController = TextEditingController();
    String token = "";

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              controller: emailController,
              onChanged: (value) {
                name = value;
              },
            ),
            const SizedBox(height: 10.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              controller: passwordController,
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              child: const Text('Ingresar'),
              onPressed: () async {
                var res = await UserService()
                    .loginUser('/login', emailController.text,
                        passwordController.text, true)
                    .then((res) async {
                  var resData = await UserService().loginUser('/login',
                      emailController.text, passwordController.text, false);

                  var jsondata = jsonDecode(res);
                  print(jsondata['token']);
                  Save_token_preferences(jsondata['token']);

                  Map resDataMap = jsonDecode(resData);

                  if (res == null) {
                    print("Error");
                  } else {
                    if (resDataMap['type'] == 'customer') {
                      Navigator.of(context).popAndPushNamed('/home');
                    } else if (resDataMap['type'] == 'seller') {
                      Navigator.of(context).popAndPushNamed('/homeSeller');
                    }
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
