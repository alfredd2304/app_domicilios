import 'package:app_domicilios/providers/estado_de_red.dart';
import 'package:app_domicilios/reusable_widgets/reusable_widget.dart';
import 'package:app_domicilios/screens/home_screen.dart';
import 'package:app_domicilios/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SizedBox(
      width: 320,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          reusableTextField("Enter Email", Icons.person_2_outlined, false,
              _emailTextController),
          const SizedBox(
            height: 30,
          ),
          reusableTextField("Enter Password", Icons.lock_outlined, true,
              _passwordTextController),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 180,
            child: loginSignUpButtonButton(context, true, () async {
              await context
                  .read<EstadoDeRedProvider>()
                  .onVerificarEstadoDeRed();
              bool estadoRed = context.read<EstadoDeRedProvider>().estadoRed;
              await Future.delayed(const Duration(seconds: 1));
              if (estadoRed == true) {
                try {
                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  });
                } catch (error) {
                  // ignore: use_build_context_synchronously
                  _mostrarAlertaError(
                      context, "Email o Contraseña incorrectos");
                }
              } else {
                _mostrarAlertaError(context, "Verifica estado de Red");
              }
            }),
          ),
          signUpOption()
        ],
      ),
    )));
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account?",
            style: TextStyle(color: Colors.black54)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign up",
            style: TextStyle(
                color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
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
