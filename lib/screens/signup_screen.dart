// ignore_for_file: use_build_context_synchronously

import 'package:app_domicilios/main.dart';
import 'package:app_domicilios/reusable_widgets/reusable_widget.dart';
import 'package:app_domicilios/screens/home_screen.dart';
import 'package:app_domicilios/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
                  child: loginSignUpButtonButton(context, false, () async {
                    if (_userNameTextController.text.length > 5) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyApp()));
                          _mostrarAlerta(context);
                        });
                      } catch (error) {
                        if (error is FirebaseAuthException) {
                          if (error.code == 'invalid-email') {
                            _mostrarAlertaError(context,
                                'La dirección de correo electrónico no es válida.');
                          } else if (error.code == 'weak-password') {
                            _mostrarAlertaError(context,
                                'La contraseña es débil. Debe tener al menos 6 caracteres.');
                          } else {
                            _mostrarAlertaError(context,
                                'Error de autenticación: ${error.message}');
                          }
                        } else {
                          _mostrarAlertaError(
                              context, 'Se produjo un error desconocido.');
                        }
                      }
                    } else {
                      _mostrarAlertaError(context,
                          "Username debe tener al menos 6 caracteres.");
                    }
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

void _mostrarAlertaError(BuildContext context, String error) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Error"),
        content: Text(error),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
