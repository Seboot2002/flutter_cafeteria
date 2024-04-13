import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:app_flutter/services/user.service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    String name = "";
    String password = "";
    final TextEditingController _emailController = TextEditingController(); //TextEditingController se modifica segun lo que se agregue o cambie el textField
    final TextEditingController _passwordController = TextEditingController();
    String token = "";

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              controller: _emailController,
              onChanged: (value) {
                name = value;
              },
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              controller: _passwordController,
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              child: Text('Ingresar'),
              onPressed: () async {
                var res = await UserService().loginUser('/login', _emailController.text, _passwordController.text, true).then((res) async {

                  var resData = await UserService().loginUser('/login', _emailController.text, _passwordController.text, false);

                  print(res);
                  Map resDataMap = jsonDecode(resData);

                  if(res == null){
                    print("Error");
                  }
                  else{
                    if(resDataMap['type'] == 'customer'){
                      Navigator.of(context).popAndPushNamed('/home');
                    }
                    else if(resDataMap['type'] == 'seller'){
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