import 'package:app_domicilios/main.dart';
import 'package:app_domicilios/reusable_widgets/reusable_widget.dart';
import 'package:app_domicilios/screens/home_screen.dart';
import 'package:app_domicilios/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                reusableTextField("Enter Username", Icons.person_2_outlined,
                    false, _userNameTextController),
                const SizedBox(
                  height: 15,
                ),
                reusableTextField("Enter Email", Icons.person_outlined, false,
                    _emailTextController),
                const SizedBox(
                  height: 15,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 180,
                  child: loginSignUpButtonButton(context, false, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                    _mostrarAlerta(context);
                  }),
                ),
              ]),
        ),
      ),
    );
  }
}

void _mostrarAlerta(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Usuario Creado"),
        content: const Text("El Usuario ha sido registrado exitosamente."),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Aceptar"),
          ),
        ],
      );
    },
  );
}
